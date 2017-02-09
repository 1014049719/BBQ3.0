//
//  Attachment.h
//  BBQ
//
//  Created by 朱琨 on 15/12/6.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Dynamic;

typedef NS_ENUM(NSInteger, BBQAttachmentType) {
    BBQAttachmentTypePhoto,
    BBQAttachmentTypeVideo
};

typedef NS_ENUM(NSInteger, BBQAttachmentUploadState) {
    BBQAttachmentUploadStateSuccess,
    BBQAttachmentUploadStateInit,
    BBQAttachmentUploadStateIng,
    BBQAttachmentUploadStateFail
};

typedef NS_ENUM(NSInteger, BBQAttachmentRemoteType) {
    BBQAttachmentRemoteTypeLocal,
    BBQAttachmentRemoteTypeServer,
    BBQAttachmentRemoteTypeQiniu
};

@interface Attachment : NSObject

@property (copy, nonatomic) NSDictionary *data;
@property (copy, nonatomic) NSString *attachid;
@property (copy, nonatomic) NSNumber *remote;
@property (copy, nonatomic) NSString *filepath;
@property (copy, nonatomic) NSString *guid;
@property (copy, nonatomic) NSString *localid;
@property (copy, nonatomic) NSNumber *graphtime;
@property (copy, nonatomic) NSNumber *itype;
@property (copy, nonatomic) NSNumber *width;
@property (copy, nonatomic) NSNumber *height;

@property (assign, nonatomic) BBQAttachmentUploadState uploadState;
@property (strong, nonatomic) NSURL *assetURL;

- (NSURL *)filepathURL;
- (NSURL *)thumbpathURL;
- (NSString *)thumbpath;

+ (instancetype)attachmentWithAsset:(ALAsset *)asset dynamic:(Dynamic *)dynamic;
+ (instancetype)attachWithAssetURL:(NSURL *)assetURL dynamic:(Dynamic *)dynamic;
- (void)deleteLocalFile;
- (void)deleteLocalThumb;

@end
