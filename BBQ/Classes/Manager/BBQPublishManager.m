//
//  BBQPublishManager.m
//  BBQ
//
//  Created by 朱琨 on 15/12/17.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQPublishManager.h"
#import <QiniuSDK.h>
#import "BBQPublishDynamicApi.h"
#import "BBQForwardDynamicApi.h"
#import "UnboundedBlockingQueue.h"
#import "JJSandBox.h"

@interface BBQPublishManager ()

@property (strong, nonatomic) QNUploadManager *uploadManager;
@property (strong, nonatomic) Dynamic *curDynamic;
@property (strong, nonatomic) UnboundedBlockingQueue *queue;
@property (strong, nonatomic) QNUploadOption *option;

@end

@implementation BBQPublishManager {
    dispatch_queue_t addQueue;
    dispatch_queue_t workingQueue;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _queue = [UnboundedBlockingQueue new];
        _uploadManager = [QNUploadManager sharedInstanceWithConfiguration:nil];
        addQueue = dispatch_queue_create("com.jyex.dynamic.retrieval", DISPATCH_QUEUE_SERIAL);
        workingQueue = dispatch_queue_create("com.jyex.dynamic.working", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

+ (instancetype)sharedManager {
    static BBQPublishManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)startWorking {
    if (self.working) {
        return;
    }
    self.working = YES;
    @weakify(self)
    dispatch_async(addQueue, ^{
        @strongify(self)
        [self retrievalDynamicsForPublishing];
        dispatch_async(workingQueue, ^{
            [self doGet];
        });
    });
}

- (void)stopWorking {
    if (!self.working) {
        return;
    }
    self.working = NO;
    [self bk_removeAllBlockObservers];
    [self.queue clearQueue];
}

- (void)retrievalDynamicsForPublishing {
    __block NSArray *array = nil;
    [Dynamic dynamicsNeedUploadWithCompletion:^(NSArray *dynamics) {
        array = dynamics;
    }];
    if (array.count) {
        [array bk_each:^(id obj) {
            [self addDynamic:obj];
        }];
    } else {
        [JJSandBox deleteAllForDocumentsDir:[[@"Database" stringByAppendingPathComponent:[[NSUserDefaults standardUserDefaults] stringForKey:kLoginCurUid] ?: @"000000"] stringByAppendingPathComponent:@"Media"]];
    }
}

- (void)addDynamic:(Dynamic *)dynamic {
    @weakify(self)
    dynamic.uploadState = BBQDynamicUploadStateWaiting;
    [dynamic insertUpdateSyncToDB:nil];
    [[NSNotificationCenter defaultCenter] postNotificationOnMainThreadWithName:kPublishDynamicNotification object:dynamic];
    dispatch_async(addQueue, ^{
        @strongify(self)
        [self.queue put:dynamic];
    });
}

- (void)doGet {
    while (self.working) {
        if ([self canPublish]) {
            @autoreleasepool {
                Dynamic *dynamic = [_queue take:10];
                if (dynamic) {
                    if (![dynamic hasNoContent] && ![dynamic hasBeenDeleted]) {
                        [self publishDynamic:dynamic completion:nil];
                    }
                }
            }
        }
    }
}

- (void)publishDynamic:(Dynamic *)dynamic completion:(void (^)(Dynamic *dynamic, NSError *error))completion {
    dynamic.uploadState = BBQDynamicUploadStateUploading;
    [dynamic insertUpdateSyncToDB:nil];
    [[NSNotificationCenter defaultCenter] postNotificationOnMainThreadWithName:kPublishDynamicNotification object:dynamic];
    dispatch_group_t group = dispatch_group_create();
    @weakify(self)
    for (Attachment *attachment in dynamic.attachinfo) {
        if (attachment.uploadState != BBQAttachmentUploadStateSuccess && [attachment.filepath isNotBlank]) {
            dispatch_group_enter(group);
            attachment.uploadState = BBQAttachmentUploadStateIng;
            [dynamic insertUpdateSyncToDB:nil];
            @strongify(self)
            [self.uploadManager putFile:attachment.filepath key:nil token:TheCurUser.qntoken complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                if (info.isOK) {
                    if (attachment.assetURL && (attachment.itype.integerValue == BBQAttachmentTypePhoto) && ![TheCurUser.usedMedia containsObject:attachment.assetURL.absoluteString]) {
                        NSMutableArray *array = [NSMutableArray arrayWithArray:TheCurUser.usedMedia];
                        [array addObject:attachment.assetURL.absoluteString];
                        TheCurUser.usedMedia = array;
                        [TheCurUser save];
                    }
                    [attachment deleteLocalFile];
                    attachment.filepath = [NSString stringWithFormat:@"http://%@/%@", TheCurUser.qndns, resp[@"key"]];
                    if (dynamic.mediaType != BBQDynamicMediaTypeVideo) {
                        attachment.uploadState = BBQAttachmentUploadStateSuccess;
                    }
                    attachment.height = resp[@"height"];
                    attachment.width = resp[@"width"];
                    attachment.remote = @2;
                } else {
                    attachment.uploadState = BBQAttachmentUploadStateFail;
                }
                [dynamic insertUpdateSyncToDB:nil];
                dispatch_group_leave(group);
            } option:self.option];
        }
    }
    
    
    if (dynamic.mediaType == BBQDynamicMediaTypeVideo) {
        Attachment *attachment = dynamic.attachinfo.firstObject;
        if ([attachment.data[@"yt"][@"remote"] integerValue] == BBQAttachmentRemoteTypeLocal) {
            dispatch_group_enter(group);
            @strongify(self)
            [self.uploadManager putFile:[attachment thumbpath] key:nil token:TheCurUser.qntoken complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                if (info.isOK) {
                    [attachment deleteLocalThumb];
                    NSString *filepath = [NSString stringWithFormat:@"http://%@/%@", TheCurUser.qndns, resp[@"key"]];
                    attachment.data = @{@"yt": @{
                                                @"filepath": filepath,
                                                @"remote": @(BBQAttachmentRemoteTypeQiniu),
                                                @"itype": @0,
                                                @"width": resp[@"width"],
                                                @"height": resp[@"height"]
                                                }
                                        };
                    attachment.uploadState = BBQAttachmentUploadStateSuccess;
                } else {
                    attachment.uploadState = BBQAttachmentUploadStateFail;
                }
                [dynamic insertUpdateSyncToDB:nil];
                dispatch_group_leave(group);
            } option:self.option];
        }
    }
    
    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @strongify(self)
        if ([dynamic isAllImagesHaveDone]) {
            BBQPublishDynamicApi *api = [BBQPublishDynamicApi apiWithDynamic:dynamic];
            [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
                if (self.working) {
                    dynamic.uploadState = BBQDynamicUploadStateSuccess;
                    if (request.responseJSONObject[@"data"][@"guid"]) {
                        dynamic.guid = [request.responseJSONObject[@"data"][@"guid"] firstObject];
                    }
                    dynamic.dateline = @([[NSDate date] timeIntervalSince1970]);
                    [dynamic insertUpdateSyncToDB:[NSString stringWithFormat:@"localid = '%@'", dynamic.localid] result:nil];
                    [[NSNotificationCenter defaultCenter] postNotificationOnMainThreadWithName:kPublishDynamicNotification object:dynamic];
                    [self refreshNewTaskState:dynamic];
                    if (completion) {
                        completion(dynamic, nil);
                    }
                }
            } failure:^(YTKBaseRequest *request) {
                if (self.working) {
                    dynamic.uploadState = BBQDynamicUploadStateFail;
                    [dynamic insertUpdateSyncToDB:nil];
                    [[NSNotificationCenter defaultCenter] postNotificationOnMainThreadWithName:kPublishDynamicNotification object:dynamic];
                    if (completion) {
                        completion(dynamic, request.requestOperation.error);
                    }
                }
            }];
        } else {
            if (self.working) {
                dynamic.uploadState = BBQDynamicUploadStateFail;
                [dynamic insertUpdateSyncToDB:nil];
                [[NSNotificationCenter defaultCenter] postNotificationOnMainThreadWithName:kPublishDynamicNotification object:dynamic];
                NSError *error = [NSError errorWithDomain:@"com.jyex.dynamic" code:-100 userInfo:@{NSLocalizedDescriptionKey: @"图片或视频上传失败"}];
                if (completion) {
                    completion(dynamic, error);
                }
            }
        }
    });
}

#pragma mark - Getter & Setter
- (BOOL)canPublish {
    if (TheCurUser.onlyViaWifi) {
        return [[AFNetworkReachabilityManager sharedManager] isReachableViaWiFi];
    }
    return !kNetworkNotReachability;
}

- (QNUploadOption *)option {
    if (!_option) {
        @weakify(self)
        _option = [[QNUploadOption alloc] initWithMime:nil progressHandler:nil params:@{@"x:abc": @"1234"} checkCrc:NO cancellationSignal:^BOOL{
            @strongify(self)
            return !self.working;
        }];
    }
    return _option;
}

-(void)refreshNewTaskState:(Dynamic *)dynamic{
    BBQNewGuideTaskType tasktype =0;
    if (dynamic.mediaType ==BBQDynamicMediaTypeVideo) {
        tasktype = BBQNewGuideTaskTypeVideo;
    }else if (dynamic.mediaType == BBQDynamicMediaTypePhoto)
        tasktype = BBQNewGuideTaskTypePhoto;
    if (tasktype) {
        if  ([TheCurUser needRefreshNewGuideTask:tasktype]){
            [[NSNotificationCenter defaultCenter]
             postNotificationName:kFinishedNewGuideTaskNotification object:nil userInfo:@{@"taskno" : [NSNumber numberWithInteger:tasktype] }];
        }
    }
}

@end
