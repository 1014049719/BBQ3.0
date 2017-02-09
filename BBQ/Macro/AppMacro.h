//
//  AppMacro.h
//  JYEX
//
//  Created by mwt on 15/7/9.
//  Copyright (c) 2015年 广州洋基. All rights reserved.
//

#import <UIKit/UIKit.h>


//动态标志
#define DYNA_FLAG_NORMAL 0   //正常
#define DYNA_FLAG_DELETE 1   //删除

//动态类别
#define DYNA_TYPE_PERSON 1    //个人
#define DYNA_TYPE_CLASS  2    //班级
#define DYNA_TYPE_SCHOOL 3    //幼儿园

//动态上传标志
#define DYNA_NONEED_UPLOAD   0   //不需要上传
#define DYNA_NEED_UPLOAD     1    //需要上传
#define DYNA_UPLOADING       2    //正在上传
#define DYNA_UPLOAD_FINISH   3    //上传成功
#define DYNA_UPLOAD_FAILURE  4    //上传失败 (失败原因在tradetable字段)



//动态编辑标志
#define DYNA_EDITFLAG_ADD_SINGLE    0   //新添加的动态(单个)
#define DYNA_EDITFLAG_ADD_BAT    1   //新添加的动态（批量）

#define DYNA_EDITFLAG_UPDATE_SINGLE 2   //编辑的动态（单个）
#define DYNA_EDITFLAG_UPDATE_BAT 3   //编辑的动态（批量）


//是否为分享的动态
#define DYNA_SHARE_NOSHARE 0   //非分享的动态
#define DYNA_SHARE_ISSHARE 1   //分享过来的动态

//动态来源
#define DYNA_SRC_NORMAL 0   //正常生成的动态
#define DYNA_SRC_PAJS   1   //平安接送动态


//动态附件类型
#define ATTACH_TYPE_PIC    0   //图片
#define ATTACH_TYPE_VIDEO  1   //视频

//附件所在位置
#define ATTACH_POS_LOCAL  0  //本地
#define ATTACH_POS_SERVER 1  //服务器
#define ATTACH_POS_QINIU  2  //七牛


//人员权限(圈主、管理员、普通人员)
#define QX_QUANZHU  1
#define QX_MANAGER  2
#define QX_NORMAL   3


//-------------------------------
//后台服务同步类型
#define BIZ_SYNC_UPLOAD_NOTE  1         //上传笔记  (参数为空)
#define BIZ_SYNC_UPLOAD_JYEX_NOTE 2     //上传家园e线日志
#define BIZ_SYNC_QUERYUPDATENUMBER 3    //查询文章更新数
#define BIZ_SYNC_DOWNLOAD_HTML  4       //下载html文件
#define BIZ_SYNC_AVATAR       5         //同步头像
#define BIZ_SYNC_UPLOAD_DYNA  6         //上传动态
#define BIZ_SYNC_GET_DELETED_DYNA 7     //获取已删除的动态
#define BIZ_SYNC_GetNewMsg 8           //获取新消息数
#define BIZ_SYNC_UPLOAD_SPECIFY_DYNA  9  //上传指定动态


//支付方式
typedef NS_ENUM(NSInteger, ChosedPayWay) {
    ChosedNull,
    ChosedPayWayAlipay,
    ChosedPayWayWX,
};


//支付结果
#define PAYRESULT_NOPAY 0     //未支付
#define PAYRESULT_SUCCESS 1   //支付成功过
#define PAYRESULT_APP_SUCCESS 2  //app已确认
#define PAYRESULT_PAYING 3   //支付中
#define PAYRESULT_FAIL 4  //失败
#define PAYRESULT_CANCEL 5    //取消


//购买类型
#define BUY_QZK    1  //购买亲子卡
#define BUY_LEDOU  2  //购买乐豆


//购买url
//获取虚拟物品信息和个人虚拟物品信息

#ifdef TARGET_PARENT
static NSString * const BUY_QZK_URL = @"bbq://buyqzk";
static NSString * const BUY_LEDOU_URL = @"bbq://buyledou";

#elif TARGET_TEACHER
static NSString * const BUY_QZK_URL = @"bbqteacher://buyqzk";
static NSString * const BUY_LEDOU_URL = @"bbqteacher://buyledou";

#else
static NSString * const BUY_QZK_URL = @"bbqmaster://buyqzk";
static NSString * const BUY_LEDOU_URL = @"bbqmaster://buyledou";

#endif
 
 


//信鸽推送





//上传类型
typedef enum : NSUInteger {
    UploadItemTypePhoto,
    UploadItemTypeVideo,
    UploadItemTypeAll,
} UploadItemType;



