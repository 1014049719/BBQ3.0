//
//  Common.h
//  NoteBook
//
//  Created by wangsc on 10-9-16.
//  Copyright 2010 ND. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <AssetsLibrary/AssetsLibrary.h>


@interface CommonFunc : NSObject
{
    
}

+ (NSString*)getStreamTypeByExt:(NSString *)strExt;




+ (NSString *)osVersionString;

//获取应用程序版本号
+(NSString *)getAppVersion;
//获取开发版本号
+(NSString *)getDevelopVersion;
//获取应用名称
+(NSString *)getAppName;


//家园E线
+(NSString*)getAppAddressWithAppCode:(NSString*)sAppCode;
//资源图片
+(NSString*)getResourceNameWithAppCode:(NSString*)appCode;

+(int)getBtnTagWithCode:(NSString*)sCode;
+(NSString *)getAppCodeWithBtnTag:(int)tag;

/// 时间处理
+ (NSString *)compareTime:(NSString *)time;
/// 弹出提示
+ (void)showAlertView:(NSString *)string;

+ (void)checkPostDataWifiOnly;
/// 获取公告栏目
+ (void)getAnnouncementType;
/// 扫描相册
+ (void)explorePhotoFromGroup:(ALAssetsGroup *)group;

@end


