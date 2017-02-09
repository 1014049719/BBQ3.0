//
//  Dynamic.h
//  BBQ
//
//  Created by 朱琨 on 15/12/6.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Attachment.h"
#import "Gift.h"
#import "Comment.h"
#import "JJFMDB.h"

typedef void (^SearchCompletion)(NSArray *dynamics);

typedef NS_ENUM(NSInteger, BBQDynamicUploadState) {
    BBQDynamicUploadStateSuccess,
    BBQDynamicUploadStateWaiting,
    BBQDynamicUploadStateUploading,
    BBQDynamicUploadStateFail
};

typedef NS_ENUM(NSInteger, BBQDynamicContentType) {
    BBQDynamicContentTypeNormal,
    BBQDynamicContentTypePickUp,
    BBQDynamicContentTypeDailyReport,
    BBQDynamicContentTypeSchoolBulletin,
    BBQDynamicContentTypeClassBulletin,
    BBQDynamicContentTypeHomework
};

typedef NS_ENUM(NSInteger, BBQDynamicGroupType) {
    BBQDynamicGroupTypeBaby = 1,
    BBQDynamicGroupTypeClass,
    BBQDynamicGroupTypeSchool,
    
};

typedef NS_ENUM(NSInteger, BBQDynamicMediaType) {
    BBQDynamicMediaTypeNone,
    BBQDynamicMediaTypePhoto,
    BBQDynamicMediaTypeVideo,
    BBQDynamicMediaTypeBatch
};

@interface Dynamic : NSObject<YYModel, JJFMDBProtocol, NSCopying>

@property (assign, nonatomic) BBQDynamicMediaType mediaType;
@property (assign, nonatomic) BBQDynamicUploadState uploadState;
@property (assign, nonatomic) BOOL flag;
@property (assign, nonatomic) BOOL fb_flag;
@property (assign, nonatomic) BOOL reedit;
@property (assign, nonatomic) BOOL setDate;
@property (copy, nonatomic) NSArray *giftdata;
@property (copy, nonatomic) NSArray *reply;
@property (copy, nonatomic) NSNumber *baobaouid;
@property (copy, nonatomic) NSNumber *classuid;
@property (copy, nonatomic) NSNumber *commentcount;
@property (copy, nonatomic) NSNumber *commentupdate;
@property (copy, nonatomic) NSNumber *contentupdate;
@property (copy, nonatomic) NSNumber *creuid;
@property (copy, nonatomic) NSNumber *dateline;
@property (copy, nonatomic) NSNumber *dtype;
@property (copy, nonatomic) NSNumber *giftcount;
@property (copy, nonatomic) NSNumber *giftupdate;
@property (copy, nonatomic) NSNumber *graphtime;
@property (copy, nonatomic) NSNumber *groupkey;
@property (copy, nonatomic) NSNumber *gxid;
@property (copy, nonatomic) NSNumber *ispajs;
@property (copy, nonatomic) NSNumber *oldcreuid;
@property (copy, nonatomic) NSNumber *schoolid;
@property (copy, nonatomic) NSNumber *shareflag;
@property (copy, nonatomic) NSNumber *updatetime;
@property (copy, nonatomic) NSString *baobaoname;
@property (copy, nonatomic) NSString *baobaousername;
@property (copy, nonatomic) NSString *classname;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *crenickname;
@property (copy, nonatomic) NSString *dynatag;
@property (copy, nonatomic) NSString *fbztx;
@property (copy, nonatomic) NSString *guid;
@property (copy, nonatomic) NSString *gxname;
@property (copy, nonatomic) NSString *localid;
@property (copy, nonatomic) NSString *oldcrenickname;
@property (copy, nonatomic) NSString *position;
@property (copy, nonatomic) NSString *schoolname;
@property (copy, nonatomic) NSString *shareusergxname;
@property (copy, nonatomic) NSString *shareusername;
@property (copy, nonatomic) NSString *tradetable;
@property (copy, nonatomic) NSString *user_type;
@property (strong, nonatomic) NSMutableArray *attachinfo;
@property (strong, nonatomic) NSMutableArray *selectedAssetURLs;

+ (instancetype)dynamicWithMediaType:(BBQDynamicMediaType)mediaType object:(id)object;
+ (instancetype)dynamicForWelcome;

- (void)updateAttachment:(Attachment *)attach;
- (void)addSelectedAssetURLs:(NSMutableOrderedSet *)selectedAssetURLs;
- (void)addASelectedAssetURL:(NSURL *)assetURL;
- (void)deleteASelectedAssetURL:(NSURL *)assetURL;
- (void)deleteAAttach:(Attachment *)attach;
- (BOOL)isAllImagesHaveDone;
- (BOOL)hasNoContent;
- (BOOL)hasBeenDeleted;

- (void)addComment:(Comment *)comment;
- (void)deleteComment:(Comment *)comment;
- (void)addGift:(Gift *)gift;

+ (void)deleteDynamic:(Dynamic *)dynamic;

+ (void)dynamicWithGuid:(NSString *)guid completion:(SearchCompletion)block;
+ (void)dynamicWithLocalid:(NSString *)localid completion:(SearchCompletion)block;
+ (void)dynamicsWithUploadState:(BBQDynamicUploadState)state completion:(SearchCompletion)block;
+ (void)dynamicsNeedUploadWithCompletion:(SearchCompletion)block;
+ (void)dynamicsAtBeginningWithCompletion:(SearchCompletion)block;
+ (void)dynamicsAfterDynamic:(Dynamic *)dynamic completion:(SearchCompletion)block;
+ (void)dynamicsWhere:(NSString *)where count:(NSInteger)count completion:(SearchCompletion)block;
+ (void)dynamicsWithParams:(NSDictionary *)dic completion:(SearchCompletion)block;

@end
