//
//  BBQadvertisementModel.h
//  BBQ
//
//  Created by wth on 15/12/9.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface BBQadvertisementModel : NSObject<MJKeyValue>

/** "id":记录id  */
@property(nonatomic,strong) NSString *advid;
/** "pagePic":启动页图片地址 */
@property(nonatomic,strong) NSString *pagePic;
/** "pageUrl":启动页跳转url, */
@property(nonatomic,strong) NSString *pageUrl;
/** "showTime":显示秒数, */
@property(nonatomic,strong) NSString *showTime;
/** "appType":0-家长端、1-教师端、2-园长端 */
@property(nonatomic,strong) NSString *appType;
/** isDefault */
@property(nonatomic,strong) NSString *isDefault;

@end
