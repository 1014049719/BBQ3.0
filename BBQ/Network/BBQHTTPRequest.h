//
//  BBQHTTPRequest.h
//  BBQ
//
//  Created by anymuse on 15/8/7.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworkingHelper.h"
/**
 *  HTTP Request Type
 */
typedef NS_ENUM(NSUInteger, BBQHTTPRequestType){
    /**
     *  添加评论回复
     */
    BBQHTTPRequestTypeAddComment,
    /**
     *  添加动态
     */
    BBQHTTPRequestTypeAddDynamic,
    /**
     *  修改密码
     */
    BBQHTTPRequestTypeChangePassword,
    /**
     *  输入验证码修改密码
     */
    BBQHTTPRequestTypeChangePasswordWithVerifyCode,
    /**
     *  删除评论回复
     */
    BBQHTTPRequestTypeDeleteComment,
    /**
     *  删除动态
     */
    BBQHTTPRequestTypeDeleteDynamic,
    /**
     *  获取动态列表
     */
    BBQHTTPRequestTypeGetDynamic,
    /**
     *  获取邀请码
     */
    BBQHTTPRequestTypeGetInviteCode,
    /**
     *  登出
     */
    BBQHTTPRequestTypeLogout,
    /**
     *  修改个人信息
     */
    BBQHTTPRequestTypeModifyInfo,
    /**
     *  修改个人关系
     */
    BBQHTTPRequestTypeModifyRelationship,
    /**
     *  注册
     */
    BBQHTTPRequestTypeRegist,
    /**
     *  获取短信验证码
     */
    BBQHTTPRequestTypeGetSMSVerifyCode,
    /**
     *  发送邀请码
     */
    BBQHTTPRequestTypeSendInviteCode,
    /**
     *  分享动态
     */
    BBQHTTPRequestTypeShareDynamic,
    /**
     *  获取指定动态
     */
    BBQHTTPRequestTypeGetSpecifyDynamic,
    /**
     *  获取指定动态所有评论回复
     */
    BBQHTTPRequestTypeGetSpecifyDynamicComment,
    /**
     *  上传头像
     */
    BBQHTTPRequestTypeUploadAvartar,
    /**
     *  验证邀请码
     */
    BBQHTTPRequestTypeVerifyInviteCode,
    /**
     * 获取消息列表
     */
    BBQHTTPRequestTypeGetMessageList,
    /**
     * 提交反馈信息
     */
    BBQHTTPRequestTypePostUserProblem,
    /**
     * 获取亲友列表
     */
    BBQHTTPRequestTypeGetRelativeList,
    /**
     * 查询个人信息
     */
    BBQHTTPRequestTypeGetUserData,
    /**
     * 获得班级下宝宝的信息接口
     */
    BBQHTTPRequestTypeGetBaoBaoList,
    /**
     * 查询收货地址接口
     */
    BBQHTTPRequestTypeGetGoodsLocation,
    /**
     * 保存新增收货地址接口
     */
    BBQHTTPRequestTypeAddNewGoodsLocation,
    /**
     * 编辑收货地址接口
     */
    BBQHTTPRequestTypeModifyGoodsLocation,
    /**
     * 查询某用户收到的虚拟礼物汇总信息接口
     */
    BBQHTTPRequestTypeGetAllGiftData,
    /**
     * 查询礼品接口(只返回有效的)
     */
    BBQHTTPRequestTypeGetJiFenGiftData,
    /**
     * 查询老师收到的指定虚拟礼物列表
     */
    BBQHTTPRequestTypeGetGiverRecord,
    /**
     * 礼品兑换接口
     */
    BBQHTTPRequestTypeExchangeGift,
    /**
     * 拍照提醒
     */
    BBQHTTPRequestTypePhotoRemind,
    /**
     * 每日报告提醒
     */
    BBQHTTPRequestTypeDailyReport,
    /**
     *  宝宝某个月的报告
     */
    BBQHTTPRequestTypeBabyDailyReportByMonth,
    /**
     *  班级某月报告记录情况
     */
    BBQHTTPRequestTypeClassDailyReportMonthData,
    /**
     * 获得学校下班级的信息接口
     */
    BBQHTTPRequestTypeGetClassList,
    /**
     * 获得帮助中心信息接口
     */
    BBQHTTPRequestTypeGetHelpList,
    /**
     * 删除亲友
     */
    BBQHTTPRequestTypeDeleteFriend,
    /**
     * 修改亲友信息
     */
    BBQHTTPRequestTypeUpdateFriendData,
    /**
     * 获取用户积分历史记录接口
     */
    BBQHTTPRequestTypeGetJiFenDetail,
    /**
     * 获取用户乐豆历史记录接口
     */
    BBQHTTPRequestTypeGetLeDouHistory,
    /**
     * 获取老师当天提醒的任务数接口(老师角色首页用)
     */
    BBQHTTPRequestTypeGetRemindTaskNum,
    /**
     * 获取当天刷卡数接口
     */
    BBQHTTPRequestTypeGetCurrentDayShuaKaNum,
    
    /**
     *  云之讯发送手机短信验证码接口
     */
    BBQHTTPRequestTypeSendVerifyCode,
    /**
     *  修改宝宝信息
     */
    BBQHTTPRequestTypeUpdateBabyInfo,
    /**
     *  登录
     */
    BBQHTTPRequestTypeLogin,
    /**
     * 添加乐豆订单
     */
    BBQHTTPRequestTypeBuyLedou,
    /**
     * 更新订单状态
     */
    BBQHTTPRequestTypeUpdateOrderStatue,
    /**
     * 获取亲子包
     */
    BBQHTTPRequestTypeGetQZK,
    /**
     * 购买亲子卡
     */
    BBQHTTPRequestTypeBuyQZK,
    /**
     * iOS 添加乐豆订单
     */
    BBQHTTPRequestTypeAddiOSLeDouOrder,
    /**
     * iOS 支付订单更新
     */
    BBQHTTPRequestTypeiOSUpdateOrder,
    /**
     * 礼物
     */
    BBQHTTPRequestTypeGiftAndUserInfo,
    /**
     * 赠送虚拟礼物
     */
    BBQHTTPRequestTypeSendGift,
    /**
     * 发布公告
     */
    BBQHTTPRequestTypeCreateAnnouncement,
    /**
     * 获取公告栏目
     */
    BBQHTTPRequestTypeGetAnnouncementType,
    
    /**
     *  每日报告选择项
     */
    BBQHTTPRequestTypeDailyReportOptions,
    /**
     *  获取班级未在校宝宝列表
     */
    BBQHTTPRequestTypeBabyNotAtSchool,
    /**
     *  添加每日报告
     */
    BBQHTTPRequestTypeAddDailyReport,
    /**
     *  请求成长书预览
     */
    BBQHTTPRequestTypeCZSyulan,
    /**
     *  获取每日报告
     */
    BBQHTTPRequestTypeGetDailyReport,
    /**
     *  获取关注列表
     */
    BBQHTTPRequestTypeGetAttentionList,
    /**
     *  获取省份城市地区
     */
    BBQHTTPRequestTypeGetPlace,
    /**
     *  获取学校和班级列表
     */
    BBQHTTPRequestTypeGetSchool,
    /**
     *  创建宝宝
     */
    BBQHTTPRequestTypeCreateBaobao,
    /**
     *  删除和宝宝的关系
     */
    BBQHTTPRequestTypeCancelBaobao,
    /**
     *  登录后验证邀请码
     */
    BBQHTTPRequestTypeYQM,
    /**
     * 获得加入班级申请列表
     */
    BBQHTTPRequestTypeGetInviteList,
    /**
     * 老师审核申请加入班级
     */
    BBQHTTPRequestTypeInviteAudit,
    /**
     * 宝宝申请加入班级
     */
    BBQHTTPRequestTypeIntoClass,
    /**
     * 启动广告页面
     */
    BBQHTTPRequestTypeAdvertisementLogin,
    /**
     *  上传宝宝封面
     */
    BBQHTTPRequestTypeBaobaoCover,
    /**
     *  获取宝宝详情
     */
    BBQHTTPRequestTypeBaobaoDetail,
    /**
     *  获取宝宝详情
     */
    BBQHTTPRequestTypeAdvertisementCZS,
    /**
     *  查询新手任务状态
     */
    BBQHTTPRequestTypeGetTaskStatus,
    /**
     *  获取成长值数据接口
     */
    BBQHTTPRequestTypeGetGRADE,
    /**
     *  上报用户行为接口
     */
    BBQHTTPRequestTypeUploadAction,
    /**
     *  获取写给未来的你
     */
    BBQHTTPRequestTypeGetFuture,
    /**
     *  发表写给未来的你
     */
    BBQHTTPRequestTypeAddFuture,
};
typedef NS_ENUM(NSUInteger, BBQRefreshType) {
    BBQRefreshTypePullDown,
    BBQRefreshTypePullUp = 2,
};

@interface BBQHTTPRequest : NSObject

+ (void)queryWithType:(BBQHTTPRequestType)requestType param:(NSDictionary *)param constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block  successHandler:(void (^)(AFHTTPRequestOperation *operation, NSDictionary *responseObject, bool apiSuccess))success errorHandler:(void (^)(NSDictionary *responseObject))error failureHandler:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure successMessage:(NSString *)successMessage errorMessage:(NSString *)errorMessage;

+ (void)queryWithType:(BBQHTTPRequestType)requestType param:(NSDictionary *)param successHandler:(void (^)(AFHTTPRequestOperation *operation, NSDictionary *responseObject, bool apiSuccess))success errorHandler:(void (^)(NSDictionary *responseObject))error failureHandler:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
@end
