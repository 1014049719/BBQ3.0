//
//  Dynamic.m
//  BBQ
//
//  Created by 朱琨 on 15/12/6.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "Dynamic.h"
#import "BBQAddCommentApi.h"
#import "BBQDeleteCommentApi.h"
#import "BBQDeleteDynamicApi.h"
#import <DateTools.h>

@implementation Dynamic

- (instancetype)init {
    self = [super init];
    if (self) {
        _uploadState = BBQDynamicUploadStateSuccess;
        _localid = [NSString stringWithUUID];
    }
    return self;
}

+ (instancetype)dynamicWithMediaType:(BBQDynamicMediaType)mediaType object:(id)object {
    Dynamic *dynamic = [Dynamic new];
    dynamic.dateline = @([[NSDate date] timeIntervalSince1970]);
    dynamic.ispajs = @0;
    dynamic.fbztx = TheCurUser.member.avartar;
    dynamic.mediaType = mediaType;
    dynamic.groupkey = TheCurUser.member.groupkey;
#ifndef TARGET_PARENT
    dynamic.crenickname = TheCurUser.member.realname;
#endif
    dynamic.graphtime = @([[NSDate date] timeIntervalSince1970]);
    if ([object isKindOfClass:[BBQBabyModel class]]) {
        BBQBabyModel *baby = (BBQBabyModel *)object;
        dynamic.dtype = @(BBQDynamicGroupTypeBaby);
        dynamic.baobaouid = baby.uid;
        dynamic.classuid = baby.curClass.classid;
        dynamic.schoolid = baby.curSchool.schoolid;
        dynamic.schoolname = baby.curSchool.schoolname;
        dynamic.classname = baby.curClass.classname;
#ifdef TARGET_PARENT
        dynamic.gxid = baby.gxid;
        dynamic.gxname = baby.gxname;
#endif
        dynamic.baobaoname = baby.realname;
    } else if ([object isKindOfClass:[BBQClassDataModel class]]) {
        BBQClassDataModel *classModel = (BBQClassDataModel *)object;
        dynamic.dtype = @(BBQDynamicGroupTypeClass);
        dynamic.classuid = classModel.classid;
        dynamic.classname = classModel.classname;
        dynamic.schoolid = TheCurUser.curSchool.schoolid;
        dynamic.schoolname = TheCurUser.curSchool.schoolname;
    } else if ([object isKindOfClass:[BBQSchoolDataModel class]]) {
        BBQSchoolDataModel *school = (BBQSchoolDataModel *)object;
        dynamic.dtype = @(BBQDynamicGroupTypeSchool);
        dynamic.classuid = TheCurUser.curClass.classid;
        dynamic.classname = TheCurUser.curClass.classname;
        dynamic.schoolid = school.schoolid;
        dynamic.schoolname = school.schoolname;
    }
    return dynamic;
}

+ (instancetype)dynamicForWelcome {
    Dynamic *dynamic = [Dynamic new];
    dynamic.ispajs = @(BBQDynamicContentTypePickUp);
    dynamic.content = @"Hi~ 亲爱的，欢迎来到宝宝圈的大家庭。这里不仅可以记录宝宝的成长瞬间，也可以知道宝宝在幼儿园的最新表现哦~";
    dynamic.graphtime = @([[NSDate date] timeIntervalSince1970]);
    dynamic.dateline = dynamic.graphtime;
    
    return dynamic;
}
//
//+ (instancetype)dynamicForForward:(Dynamic *)dynamic {
//    Dynamic *new = [dynamic copy];
//
//}

//- (BOOL)isEqual:(id)object {
//    if (self == object) return YES;
//    if (![object isMemberOfClass:self.class]) return NO;
//    Dynamic *dynamic = object;
//    if ([self hash] != [object hash]) return NO;
//    if ([_guid isEqualToString:dynamic.guid] || [self.localid isEqualToString:dynamic.localid]) return YES;
//    return NO;
//}
//
//- (NSUInteger)hash {
//    return [[self valueForKey:self.primaryKey] hash];
//}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"attachinfo" : [Attachment class],
             @"giftdata" : [Gift class],
             @"reply" : [Comment class],
             };
}

- (id)copyWithZone:(NSZone *)zone {
    return [self modelCopy];
}

- (void)updateAttachment:(Attachment *)attach {
    [_attachinfo enumerateObjectsUsingBlock:^(Attachment *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.attachid isEqualToString:attach.attachid]) {
            [_attachinfo replaceObjectAtIndex:idx withObject:attach];
            *stop = YES;
        }
    }];
    [self insertUpdateSyncToDB:nil];
}

#pragma mark - ALAsset
- (void)addSelectedAssetURLs:(NSMutableOrderedSet *)selectedAssetURLs {
    [selectedAssetURLs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self addASelectedAssetURL:obj];
    }];
}

- (void)addASelectedAssetURL:(NSURL *)assetURL {
    Attachment *attach = [Attachment attachWithAssetURL:assetURL dynamic:self];
    if (self.mediaType == BBQDynamicMediaTypeVideo) {
        attach.itype = @(BBQAttachmentTypeVideo);
    } else {
        attach.itype = @(BBQAttachmentTypePhoto);
    }
    
    NSMutableArray *attachments = [self mutableArrayValueForKey:@"attachinfo"];
    [attachments addObject:attach];
    [_selectedAssetURLs addObject:assetURL];
}

- (void)deleteASelectedAssetURL:(NSURL *)assetURL {
    [self.selectedAssetURLs removeObject:assetURL];
    NSMutableArray *attachments = [self mutableArrayValueForKey:@"attachinfo"];
    [attachments enumerateObjectsUsingBlock:^(Attachment *obj, NSUInteger idx, BOOL *stop) {
        if (obj.assetURL == assetURL) {
            [self.attachinfo removeObject:obj];
        }
    }];
}

- (void)deleteAAttach:(Attachment *)attach {
    NSMutableArray *attachments = [self mutableArrayValueForKey:@"attachinfo"];
    [attachments removeObject:attach];
    if (attach.assetURL) {
        [self.selectedAssetURLs removeObject:attach.assetURL];
    }
}

- (BOOL)isAllImagesHaveDone {
    for (Attachment *attach in self.attachinfo) {
        if (attach.remote.integerValue == BBQAttachmentRemoteTypeLocal) {
            return NO;
        }
    }
    if (self.mediaType == BBQDynamicMediaTypeVideo) {
        Attachment *attachment = self.attachinfo.firstObject;
        if ([attachment.data[@"yt"][@"remote"] integerValue] == BBQAttachmentRemoteTypeLocal) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)hasNoContent {
    if ([self.content isNotBlank] || self.attachinfo.count) {
        return NO;
    }
    return YES;
}

- (BOOL)hasBeenDeleted {
    if (self.flag) {
        return YES;
    }
    __block BOOL deleted = NO;
    [Dynamic searchDynamicsWhere:[NSString stringWithFormat:@"localid = '%@'", self.localid] count:0 completion:^(NSArray *dynamics) {
        if (dynamics.count) {
            Dynamic *dynamic = dynamics.firstObject;
            deleted = dynamic.flag;
        } else {
            deleted = YES;
        }
    }];
    _flag = deleted;
    return deleted;
}

#pragma mark - Comment
- (void)addComment:(Comment *)comment {
    if (!comment) return;
    BBQAddCommentApi *api = [[BBQAddCommentApi alloc] initWithComment:comment];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [MTA trackCustomKeyValueEvent:kMTACommentCount props:@{ @"comment" : @1 }];
        });
    } failure:nil];
    NSMutableArray *tempReply = [NSMutableArray arrayWithArray:_reply];
    [tempReply addObject:comment];
    self.reply = tempReply;
}

- (void)deleteComment:(Comment *)comment {
    if (!comment) return;
    BBQDeleteCommentApi *api = [[BBQDeleteCommentApi alloc] initWithComment:comment];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
    NSInteger index = [_reply indexOfObject:comment];
    if (index != NSNotFound) {
        NSMutableArray *tempReply = [NSMutableArray arrayWithArray:_reply];
        [tempReply removeObjectAtIndex:index];
        self.reply = tempReply;
    }
}

- (void)addGift:(Gift *)gift {
    if (!gift) return;
    NSMutableArray *tempGift = [NSMutableArray arrayWithArray:_giftdata];
    [tempGift insertObject:gift atIndex:0];
    self.giftdata = tempGift;
}

+ (void)deleteDynamic:(Dynamic *)dynamic {
    dynamic.flag = YES;
    for (Attachment *attachment in dynamic.attachinfo) {
        [attachment deleteLocalFile];
    }
    [dynamic insertUpdateSyncToDB:nil];
    if (dynamic.uploadState == BBQDynamicUploadStateSuccess && [dynamic.guid isNotBlank]) {
        BBQDeleteDynamicApi *api = [[BBQDeleteDynamicApi alloc] initWithGuid:dynamic.guid];
        [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            [dynamic deleteToDB:nil];
        } failure:nil];
    } else if (dynamic.uploadState == BBQDynamicUploadStateWaiting || dynamic.uploadState == BBQDynamicUploadStateFail) {
        [[NSNotificationCenter defaultCenter] postNotificationOnMainThreadWithName:kCancelPublishDynamicNotification object:dynamic];
    }
}

#pragma mark - 数据库
+ (void)dynamicWithGuid:(NSString *)guid completion:(SearchCompletion)block {
    NSString *sql = [NSString stringWithFormat:@"guid = '%@'", guid];
    [Dynamic searchAllWhere:sql results:^(NSArray *results) {
        if (block) {
            block(results);
        }
    }];
}

+ (void)dynamicWithLocalid:(NSString *)localid completion:(SearchCompletion)block {
    NSString *sql = [NSString stringWithFormat:@"localid = '%@'", localid];
    [Dynamic searchDynamicsWhere:sql count:0 completion:block];
}

+ (void)dynamicsWithUploadState:(BBQDynamicUploadState)state completion:(SearchCompletion)block {
    NSString *sql = [NSString stringWithFormat:@"(uploadState = %@ AND flag = 0)", @(state)];
    [Dynamic searchDynamicsWhere:sql count:0 completion:block];
}

+ (void)dynamicsNeedUploadWithCompletion:(SearchCompletion)block {
    NSString *sql = [NSString stringWithFormat:@"((uploadState = %@ OR uploadState = %@ OR uploadState = %@) AND flag = 0)", @(BBQDynamicUploadStateFail), @(BBQDynamicUploadStateWaiting), @(BBQDynamicUploadStateUploading)];
    [Dynamic searchDynamicsWhere:sql count:0 completion:block];
}

+ (void)dynamicsAtBeginningWithCompletion:(SearchCompletion)block {
    [Dynamic searchDynamicsWhere:nil count:10 completion:block];
}

+ (void)dynamicsAfterDynamic:(Dynamic *)dynamic completion:(SearchCompletion)block {
    NSString *sql = [NSString stringWithFormat:@"graphtime < %@", dynamic.graphtime];
    [Dynamic searchDynamicsWhere:sql count:10 completion:block];
}

+ (void)dynamicsWithParams:(NSDictionary *)dic completion:(SearchCompletion)block {
    
    NSString *where;
    switch ((BBQDynamicGroupType)([dic[@"dtype"] integerValue])) {
        case BBQDynamicGroupTypeBaby: {
            where = @"dtype = 1 AND ";
            if ([dic[@"baobaouid"] isEqualToNumber:@(0)] && [dic[@"classuid"] isEqualToNumber:@(0)]) {
                where = [where stringByAppendingFormat:@"schoolid = %@", dic[@"schoolid"]];
            } else if ([dic[@"baobaouid"] isEqualToNumber:@(0)]) {
                where = [where stringByAppendingFormat:@"classuid = %@", dic[@"classuid"]];
            } else {
                where = [where stringByAppendingFormat:@"baobaouid = %@", dic[@"baobaouid"]];
            }
            break;
        }
        case BBQDynamicGroupTypeClass: {
            where = @"dtype = 2 AND ";
            if ([dic[@"classuid"] isEqualToNumber:@(0)] && ![dic[@"schoolid"] isEqualToNumber:@(0)]) {
                where = [where stringByAppendingFormat:@"schoolid = %@", dic[@"schoolid"]];
            } else {
                where = [where stringByAppendingFormat:@"classuid = %@", dic[@"classuid"]];
            }
            break;
        }
        case BBQDynamicGroupTypeSchool: {
            where = [NSString stringWithFormat:@"dtype != 1 AND schoolid = %@", dic[@"schoolid"]];
            break;
        }
    }
    if ([dic[@"type"] integerValue] == 2) {
        where = [where stringByAppendingFormat:@" AND graphtime < %@", dic[@"dateline"]];
    }
    [Dynamic searchDynamicsWhere:where count:10 completion:^(NSArray *dynamics) {
        if (block) block(dynamics);
    }];
}

+ (void)dynamicsWhere:(NSString *)where count:(NSInteger)count completion:(SearchCompletion)block {
    [Dynamic searchDynamicsWhere:where count:count completion:block];
}

+ (void)searchDynamicsWhere:(NSString *)where count:(NSInteger)count completion:(SearchCompletion)block {
    [Dynamic searchSyncWhere:[where stringByAppendingString:@" AND flag = 0"] orderBy:@"graphtime DESC" count:(int)count results:^(NSArray *results) {
        if (block) {
            block(results);
        }
    }];
}

#pragma mark - Getter & Setter
- (NSMutableArray *)attachinfo {
    if (!_attachinfo) {
        _attachinfo = [NSMutableArray array];
    }
    return _attachinfo;
}

- (NSMutableArray *)selectedAssetURLs {
    if (!_selectedAssetURLs) {
        _selectedAssetURLs = [NSMutableArray array];
    }
    return _selectedAssetURLs;
}

- (NSString *)primaryKey {
    if (self.reedit) {
        return @"guid";
    }
    return [self.guid isNotBlank] ? @"guid" : @"localid";
}

@end
