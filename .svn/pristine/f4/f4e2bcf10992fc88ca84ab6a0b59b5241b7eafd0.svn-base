//
//  Attachment.m
//  BBQ
//
//  Created by 朱琨 on 15/12/6.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "Attachment.h"
#import "Dynamic.h"
#import "UIImage+Common.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>

@implementation Attachment

- (instancetype)init {
    if (self = [super init]) {
        _attachid = [NSString stringWithUUID];
        _remote = @(BBQAttachmentRemoteTypeQiniu);
        _uploadState = BBQAttachmentUploadStateSuccess;
    }
    return self;
}

+ (instancetype)attachmentWithAsset:(ALAsset *)asset dynamic:(Dynamic *)dynamic {
    Attachment *attach = [[Attachment alloc] init];
    attach.remote = @(BBQAttachmentRemoteTypeLocal);
    attach.uploadState = BBQAttachmentUploadStateInit;
    attach.assetURL = [asset valueForProperty:ALAssetPropertyAssetURL];
    if (dynamic) {
        [dynamic.selectedAssetURLs addObject:attach.assetURL];
        attach.localid = dynamic.localid;
        attach.guid = dynamic.guid;
    }
    
    NSDate *date = [asset valueForProperty:ALAssetPropertyDate];
    attach.graphtime = @([date timeIntervalSince1970]);
    NSData *data;
    NSString *filename;
    NSString *filepath;
    if ([[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
        attach.itype = @(BBQAttachmentTypePhoto);
        UIImage *image = [UIImage fullScreenImageALAsset:asset];
        data = UIImageJPEGRepresentation(image, 0.75);
        if ((float)data.length/1024 > 1000) {
            data = UIImageJPEGRepresentation(image, 1024*1000.0/(float)data.length);
        }
        filename = [NSString stringWithFormat:@"%@.jpg", attach.attachid];
        filepath = [JJSandBox getPathForDocuments:filename inDir:[[@"Database" stringByAppendingPathComponent:[[NSUserDefaults standardUserDefaults] stringForKey:kLoginCurUid] ?: @"000000"] stringByAppendingPathComponent:@"Media"]];
        BOOL ret = [data writeToFile:filepath atomically:YES];
        if (ret) {
            attach.filepath = filepath;
        } else {
            NSLog(@"选择图片写入失败！");
        }
    } else if ([[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo]) {
        attach.itype = @(BBQAttachmentTypeVideo);
        filename = [NSString stringWithFormat:@"%@.mp4", attach.attachid];
        AVURLAsset * avAsset = [[AVURLAsset alloc] initWithURL:[asset valueForProperty:ALAssetPropertyAssetURL] options:nil];
        AVAssetImageGenerator *imageGenerator = [AVAssetImageGenerator assetImageGeneratorWithAsset:avAsset];
        imageGenerator.appliesPreferredTrackTransform = YES;
        NSError *error = nil;
        CMTime time = CMTimeMake(0.0,10);
        CMTime actualTime;
        CGImageRef image = [imageGenerator copyCGImageAtTime:time actualTime:&actualTime error:&error];
        UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
        NSString *thumbname = [NSString stringWithFormat:@"%@.jpg", attach.attachid];
        NSString *thumbpath = [JJSandBox getPathForDocuments:thumbname inDir:[[@"Database" stringByAppendingPathComponent:[[NSUserDefaults standardUserDefaults] stringForKey:kLoginCurUid] ?: @"000000"] stringByAppendingPathComponent:@"Media"]];
        NSData *thumbdata = UIImageJPEGRepresentation(thumb, 0.75);
        
        BOOL ret = [thumbdata writeToFile:thumbpath atomically:YES];
        if (ret) {
            attach.data = @{@"yt": @{
                                        @"filepath": thumbpath,
                                        @"remote": @(BBQAttachmentRemoteTypeLocal),
                                        @"itype": @(BBQAttachmentTypePhoto)
                                        }
                                };
        } else {
            NSLog(@"选择图片写入失败！");
        }
        
        CGImageRelease(image);
        AVAssetExportSession * exportSession = [AVAssetExportSession exportSessionWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
        exportSession.outputFileType = AVFileTypeMPEG4;
        exportSession.shouldOptimizeForNetworkUse = YES;
        filepath = [JJSandBox getPathForDocuments:filename inDir:[[@"Database" stringByAppendingPathComponent:[[NSUserDefaults standardUserDefaults] stringForKey:kLoginCurUid] ?: @"000000"] stringByAppendingPathComponent:@"Media"]];
        exportSession.outputURL = [NSURL fileURLWithPath:filepath];
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            switch (exportSession.status) {
                case AVAssetExportSessionStatusUnknown: {
                    
                    break;
                }
                case AVAssetExportSessionStatusWaiting: {
                    
                    break;
                }
                case AVAssetExportSessionStatusExporting: {
                    
                    break;
                }
                case AVAssetExportSessionStatusCompleted: {
                    attach.filepath = filepath;
                    break;
                }
                case AVAssetExportSessionStatusFailed: {
                    
                    break;
                }
                case AVAssetExportSessionStatusCancelled: {
                    
                    break;
                }
            }
        }];
    }
    return attach;
}

+ (instancetype)attachWithAssetURL:(NSURL *)assetURL dynamic:(Dynamic *)dynamic {
    __block Attachment *attach;
    attach.assetURL = assetURL;
    
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    [assetsLibrary assetForURL:assetURL
                   resultBlock:^(ALAsset *asset) {
                       if (asset) {
                           attach = [Attachment attachmentWithAsset:asset dynamic:dynamic];
                       } else {
                           [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupPhotoStream
                                                        usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                                                            [group enumerateAssetsUsingBlock:^(
                                                                                               ALAsset *result, NSUInteger index, BOOL *stop) {
                                                                if ([result.defaultRepresentation.url isEqual:assetURL]) {
                                                                    attach = [Attachment attachmentWithAsset:asset dynamic:dynamic];
                                                                    *stop = YES;
                                                                }
                                                            }];
                                                        }
                                                      failureBlock:^(NSError *error) {
                                                          NSLog(@"Error: %@", [error localizedDescription]);
                                                      }];
                       }
                   }
                  failureBlock:^(NSError *error) {
                      NSLog(@"Error: %@", [error localizedDescription]);
                  }];
    return attach;
}

- (NSURL *)filepathURL {
    if (self.remote.integerValue == BBQAttachmentRemoteTypeLocal) {
        return [[NSURL alloc] initFileURLWithPath:self.filepath];
    }
    return [NSURL URLWithString:self.filepath];
}

- (NSURL *)thumbpathURL {
    if ([self.data[@"yt"][@"remote"] integerValue] == BBQAttachmentRemoteTypeLocal) {
        return [[NSURL alloc] initFileURLWithPath:[self thumbpath]];
    }
    return [NSURL URLWithString:[self thumbpath]];
}

- (void)deleteLocalFile {
    if (self.remote.integerValue == BBQAttachmentRemoteTypeLocal) {
        NSFileManager *manager = [NSFileManager defaultManager];
        [manager removeItemAtPath:self.filepath error:nil];
    }
}

- (void)deleteLocalThumb {
    if (self.itype.integerValue == BBQAttachmentTypeVideo) {
        NSFileManager *manager = [NSFileManager defaultManager];
        [manager removeItemAtPath:self.data[@"yt"][@"filepath"] error:nil];
    }
}

#pragma mark - Getter & Setter
- (NSString *)filepath {
    if (self.remote.integerValue != BBQAttachmentRemoteTypeLocal) {
        return _filepath;
    }
    NSString *name = [NSString stringWithFormat:@"%@.%@", self.attachid, [self.itype isEqualToNumber:@0] ? @"jpg" : @"mp4"];
    NSString *filepath = [JJSandBox getPathForDocuments:name inDir:[[@"Database" stringByAppendingPathComponent:[[NSUserDefaults standardUserDefaults] stringForKey:kLoginCurUid] ?: @"000000"] stringByAppendingPathComponent:@"Media"]];
    return filepath;
}

- (NSString *)thumbpath {
    if ([self.data[@"yt"][@"remote"] integerValue] != BBQAttachmentRemoteTypeLocal) {
        return self.data[@"yt"][@"filepath"];
    }
    NSString *thumbName = [NSString stringWithFormat:@"%@.jpg", self.attachid];
    NSString *thumbFilepath = [JJSandBox getPathForDocuments:thumbName inDir:[[@"Database" stringByAppendingPathComponent:[[NSUserDefaults standardUserDefaults] stringForKey:kLoginCurUid] ?: @"000000"] stringByAppendingPathComponent:@"Media"]];
    return thumbFilepath;
}

@end
