//
//  CheckTools.m
//  JYEX
//
//  Created by anymuse on 15/7/15.
//  Copyright (c) 2015年 广州洋基. All rights reserved.
//

#import "CheckTools.h"
#import "Dynamic.h"
#import "DES.h"

@implementation CheckTools
#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *)telNumber {
    //    NSString *pattern = @"^1+[3578]+\\d{9}";
    NSString *pattern = @"^1+\\d{10}";
    NSPredicate *pred =
    [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    return isMatch;
}

#pragma 正则匹配用户密码6 - 18位数字和字母组合
+ (BOOL)checkPassword:(NSString *)password {
    //    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    NSString *pattern = @"^\\w{6,16}";
    NSPredicate *pred =
    [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
}

#pragma 正则匹配用户姓名, 20位的中文或英文
+ (BOOL)checkUserName:(NSString *)userName {
    NSString *pattern = @"^[a-zA-Z一-龥]{1,20}";
    NSPredicate *pred =
    [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:userName];
    return isMatch;
}

#pragma 正则匹配用户身份证号15或18位
+ (BOOL)checkUserIdCard:(NSString *)idCard {
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred =
    [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:idCard];
    return isMatch;
}

#pragma 正则匹员工号, 12位的数字
+ (BOOL)checkEmployeeNumber:(NSString *)number {
    NSString *pattern = @"^[0-9]{12}";
    
    NSPredicate *pred =
    [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
}

#pragma 正则匹配URL
+ (BOOL)checkURL:(NSString *)url {
    NSString *pattern = @"^[0-9A-Za-z]{1,50}";
    NSPredicate *pred =
    [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:url];
    return isMatch;
}

+ (BOOL)checkEmptyString:(NSString *)string {
    NSString *pattern = @"^\\s*$";
    NSPredicate *pred =
    [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
}

+ (BOOL)needCompleteBabyInfo {
    return ((TheCurUser.member.groupkey.integerValue == 1) &&
            (TheCurBaoBao.gxid.integerValue < 1 ||
             ![TheCurBaoBao.realname isNotBlank]));
}

+ (BOOL)needCompleteUserInfo {
    return (TheCurBaoBao.gxid.integerValue < 1 && TheCurUser.member.groupkey.integerValue == 1);
}

+ (BOOL)needJumpToAttentionList {
    return (TheCurUser.member.groupkey.integerValue == 1 && !TheCurBaoBao);
}

+ (BOOL)needResetPassword {
    if (TheCurUser.member.groupkey.integerValue != 1 ||
        (TheCurUser.member.groupkey.integerValue == 1 && TheCurBaoBao.qx.integerValue == 1)) {
        NSString *key =
        [@"firstLaunch_" stringByAppendingString:TheCurUser.member.username];
        if (![[NSUserDefaults standardUserDefaults] boolForKey:key] &&
            [TheCurUser.member.password.lowercaseString isEqualToString:[@"123456" md5String]]) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:key];
            [[NSUserDefaults standardUserDefaults] synchronize];
            return YES;
        }
    }
    return NO;
}

+ (BOOL)checkAuthorityWithDynamicModel:(Dynamic *)model {
    if ([model.creuid isEqualToNumber:TheCurUser.member.uid]) {
        return YES;
    }
    if (!model.classuid || [model.classuid.stringValue isEqualToString:@""] ||
        !model.schoolid || [model.schoolid.stringValue isEqualToString:@""]) {
        return NO;
    }
    BOOL authority = NO;
    switch (model.dtype.integerValue) {
        case BBQDynamicGroupTypeBaby: {
            if (TheCurUser.member.groupkey.integerValue == BBQGroupkeyTypeParent &&
                (TheCurBaoBao.qx.integerValue == BBQAuthorityTypeAdmin ||
                 TheCurBaoBao.qx.integerValue == BBQAuthorityTypeManager)) {
                    authority = YES;
                }
        } break;
        case BBQDynamicGroupTypeClass: {
            if (TheCurUser.member.groupkey.integerValue == BBQGroupkeyTypeTeacher &&
                [model.classuid
                 isEqualToNumber:TheCurUser.curClass.classid]) {
                    authority = YES;
                }
        } break;
        case BBQDynamicGroupTypeSchool: {
            if (TheCurUser.member.groupkey.integerValue == BBQGroupkeyTypeMaster &&
                (model.dtype.integerValue == BBQDynamicGroupTypeClass ||
                 model.dtype.integerValue == BBQDynamicGroupTypeSchool) &&
                ([model.schoolid
                  isEqualToNumber:TheCurUser.curSchool.schoolid])) {
                authority = YES;
            }
        } break;
        default:
            break;
    }
    return authority;
}

@end
