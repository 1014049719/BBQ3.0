//
//  CheckTools.h
//  JYEX
//
//  Created by anymuse on 15/7/15.
//  Copyright (c) 2015年 广州洋基. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckTools : NSObject
#pragma mark - 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber;
#pragma mark - 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password;
#pragma mark - 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName : (NSString *) userName;
#pragma mark - 正则匹配用户身份证号
+ (BOOL)checkUserIdCard: (NSString *) idCard;
#pragma mark - 正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber : (NSString *) number;
#pragma mark - 正则匹配URL
+ (BOOL)checkURL : (NSString *) url;
@end
