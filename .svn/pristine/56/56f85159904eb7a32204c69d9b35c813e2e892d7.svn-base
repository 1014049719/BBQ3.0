//
//  NotificationMacro.h
//  JYEX
//
//  Created by mwt on 15/7/9.
//  Copyright (c) 2015年 广州洋基. All rights reserved.
//

#ifndef JYEX_NotificationMacro_h
#define JYEX_NotificationMacro_h


//购买支付结果（1:成功 2:失败 3:用户取消 4:无效 5:其他）
static NSString * const NOTIFICATION_Buy_Result = @"Notification_BuyQzk_Result";

//更新支付信息(在支付更新成功后)
static NSString * const NOTIFICATION_Update_BuyResult = @"Notification_Update_BuyResult";

//添加动态
static NSString * const kAddedDynamicNotification = @"AddedDynamicNotification";

//刷新所有数据
static NSString * const kSetNeedsRefreshEntireDataNotification = @"SetNeedsRefreshEntireDataNotification";

//完成新手任务
static NSString * const kFinishedNewGuideTaskNotification = @"FinishedNewGuideTaskNotification";

//刷新宝宝头像
static NSString * const kSetNeedsRefreshBaobaoHeadNotification = @"SetNeedsRefreshBaobaoHeadNotification";
//刷新宝宝信息数据
static NSString * const kSetNeedsRefreshBaobaoinfoNotification = @"SetNeedsRefreshBaobaoinfoNotification";

static NSString * const kDidSwitchBabyNotification = @"DidSwitchBabyNotification";
//刷新指定数据
static NSString * const kSetNeedsRefreshSpecifiedDataNotification = @"SetNeedsRefreshSpecifiedDataNotification";

static NSString * const kPageVCDidFinishScrolling = @"PageVCDidFinishScrolling";

//更新新消息数红点通知
static NSString * const kSetUpdateNewMsgNotification = @"SetUpdateNewMsgNotification";

//通知显示介绍
static NSString * const kProcIntroductionNotification = @"ProcIntroductionNotification";


//正在上传动态
static NSString * const kStartUploadDynamic = @"StartUploadDynamic";


//上传动态失败
static NSString * const kUploadDynamicFailed = @"UploadDynamicFailed";

//上传动态成功
static NSString * const NOTIFICATION_UploadDynaSucess = @"Notification_UploadDynaSucess";

//更新动态状态
static NSString * const kUpdateDynamicStatusNotification = @"UpdateDynamicStatusNotification";

//删除动态
static NSString * const kDeleteDynamicNotification = @"DeleteDynamicNotification";

//网络恢复正常
static NSString * const kNetworkRestroreNormal = @"NetworkRestroreNormal";

//下线
static NSString * const kLogoutNotification = @"LogoutNotification";

//将要下线……
static NSString * const kWillLogoutNotification = @"WillLogoutNotification";

//完善与宝宝关系
static NSString * const kNeedCompleteRelationship = @"NeedCompleteRelationship";

//发表动态
static NSString * const kPublishDynamicNotification = @"PublishDynamicNotification";

//取消发表动态
static NSString * const kCancelPublishDynamicNotification = @"CancelPublishDynamicNotification";

static NSString * const NOTIFICATION_REFRESH_CONTENT = @"NOTIFICATION_REFRESH_CONTENT";

// 有新照片需要提醒上传通知
static NSString * const kNewPhotoRemind = @"NewPhotoRemind";

static NSString * const kWillGiveUpEditing = @"WillGiveUpEditing";

typedef NS_ENUM(NSUInteger, BBQRefreshSpecifiedDataNotificationType) {
    BBQRefreshSpecifiedDataNotificationTypeDynamic,
    BBQRefreshSpecifiedDataNotificationTypeComment,
    BBQRefreshSpecifiedDataNotificationTypeGift,
};

typedef NS_ENUM(NSInteger, BBQNewGuideTaskType) {
    BBQNewGuideTaskTypePhoto = 1,
    BBQNewGuideTaskTypeVideo,
    BBQNewGuideTaskTypeInvite
};

typedef NS_ENUM(NSUInteger, BBQRefreshNotificationType) {
    BBQRefreshNotificationTypeAll,
    BBQRefreshNotificationTypeDynamic,
    BBQRefreshNotificationTypeUserInfo,
    BBQRefreshNotificationTypeBook,
    BBQRefreshNotificationTypeGroup,
    BBQRefreshNotificationTypeReceivedGift,
    BBQRefreshNotificationTypePhotoRemind,
};

#endif
