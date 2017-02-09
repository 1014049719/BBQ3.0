//
//  BBQLoginApi.m
//  BBQ
//
//  Created by 朱琨 on 15/11/13.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQLoginApi.h"
#import "DES.h"
#import "BBQLoginManager.h"

@interface BBQLoginApi ()

@property(copy, nonatomic) NSString *username;
@property(copy, nonatomic) NSString *password;
@property (assign, nonatomic) BBQLoginType type;

@end
@implementation BBQLoginApi

- (instancetype)initWithUsername:(NSString *)username
                        password:(NSString *)password type:(BBQLoginType)type {
    if (self = [super init]) {
        _username = username;
        _password = password;
        _type = type;
    }
    return self;
}

- (NSString *)requestUrl {
    switch (_type) {
        case BBQLoginTypeNormal: return URL_LOGIN_3_0;
        case BBQLoginTypeWeChat:
        case BBQLoginTypeQQ: {
            if (![BBQLoginManager isLogin]) {
                return URL_THIRDPARTY_LOGIN;
            }
            return URL_PHONENUMBER_LOGIN;
        }
        case BBQLoginTypeAutoCreateWithWeChat:
        case BBQLoginTypeAutoCreateWithQQ: {
            return URL_CREATEACCOUNT_LOGIN;
        }
        case BBQLoginTypeBindingPhoneWithWeChat:
        case BBQLoginTypeBindingPhoneWithQQ: {
            return URL_PHONENUMBER_LOGIN;
        }
            
    }
    return URL_LOGIN_3_0;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[self mobileInfo]];
    BBQLoginManager *manager = [BBQLoginManager sharedManager];
    NSDictionary *appendedDic;
    switch (_type) {
        case BBQLoginTypeNormal: {
            appendedDic = @{
                            @"username": _username,
                            @"password": _password
                            };
            break;
        }
        case BBQLoginTypeWeChat:
        case BBQLoginTypeQQ:{
            if (![BBQLoginManager isLogin]) {
                appendedDic = @{
                                @"authtype" : @(_type),
                                @"opuser" : manager.opuser ?: @"",
                                @"openid" : manager.openid ?: @"",
                                @"nickname" : manager.nickname ?: @"",
                                @"avartarurl" : manager.avartarurl ?: @"",
                                @"access_token" : manager.access_token ?: @"",
                                };
            } else {
                appendedDic = @{
                                @"authtype" : @(_type),
                                @"mobile" : TheCurUser.member.username,
                                @"opuser" : manager.opuser ?: @"",
                                @"openid" : manager.openid ?: @"",
                                @"nickname" : manager.nickname ?: @"",
                                @"avartarurl" : manager.avartarurl ?: @"",
                                @"access_token" : manager.access_token ?: @"",
                                };
            }
            break;
        }
        case BBQLoginTypeAutoCreateWithWeChat: {
            appendedDic = @{
                            @"authtype" : @(BBQLoginTypeWeChat),
                            @"opuser" : manager.opuser ?: @"",
                            @"openid" : manager.openid ?: @"",
                            @"nickname" : manager.nickname ?: @"",
                            @"avartarurl" : manager.avartarurl ?: @"",
                            @"access_token" : manager.access_token ?: @"",
                            };
            break;
        }
        case BBQLoginTypeAutoCreateWithQQ: {
            appendedDic = @{
                            @"authtype" : @(BBQLoginTypeQQ),
                            @"opuser" : manager.opuser ?: @"",
                            @"openid" : manager.openid ?: @"",
                            @"nickname" : manager.nickname ?: @"",
                            @"avartarurl" : manager.avartarurl ?: @"",
                            @"access_token" : manager.access_token ?: @"",
                            };
            break;
        }
        case BBQLoginTypeBindingPhoneWithWeChat: {
            appendedDic = @{
                            @"authtype" : @(BBQLoginTypeWeChat),
                            @"opuser" : manager.opuser ?: @"",
                            @"openid" : manager.openid ?: @"",
                            @"nickname" : manager.nickname ?: @"",
                            @"avartarurl" : manager.avartarurl ?: @"",
                            @"access_token" : manager.access_token ?: @"",
                            @"mobile": manager.mobile ?: @"",
                            @"yzcode": manager.yzcode
                            };
            break;
        }
        case BBQLoginTypeBindingPhoneWithQQ: {
            appendedDic = @{
                            @"authtype" : @(BBQLoginTypeQQ),
                            @"opuser" : manager.opuser ?: @"",
                            @"openid" : manager.openid ?: @"",
                            @"nickname" : manager.nickname ?: @"",
                            @"avartarurl" : manager.avartarurl ?: @"",
                            @"access_token" : manager.access_token ?: @"",
                            @"mobile": manager.mobile ?: @"",
                            @"yzcode": manager.yzcode
                            };
            break;
        }
    }
    [params addEntriesFromDictionary:appendedDic];
    return params;
}

@end
