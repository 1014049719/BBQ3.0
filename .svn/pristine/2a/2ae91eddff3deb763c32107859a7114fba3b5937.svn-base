//
//  BBQBinDingPhoneLoginApi.m
//  BBQ
//
//  Created by slovelys on 15/11/23.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQBinDingPhoneLoginApi.h"

@interface BBQBinDingPhoneLoginApi ()

@property (assign, nonatomic) int authtype;
@property (copy, nonatomic) NSString *openid;
@property (copy, nonatomic) NSString *nickname;
@property (copy, nonatomic) NSString *avartarurl;
@property (copy, nonatomic) NSString *access_token;
@property (copy, nonatomic) NSString *mobile;
@property (copy, nonatomic) NSString *yzcode;
@property (copy, nonatomic) NSString *opuser;
@property (assign, nonatomic) BBQBindingMobileType type;

@end

@implementation BBQBinDingPhoneLoginApi

- (instancetype)initWithAuthtype:(int)authtype opuser:(NSString *)opuser openid:(NSString *)openid nickname:(NSString *)nickname avartarurl:(NSString *)avartarurl access_token:(NSString *)access_token mobile:(NSString *)mobile yzcode:(NSString *)yzcode type:(BBQBindingMobileType)type {
    if (self = [super init]) {
        _authtype = authtype;
        _openid = openid;
        _nickname = nickname;
        _avartarurl = avartarurl;
        _access_token = access_token;
        _mobile = mobile;
        _yzcode = yzcode;
        _opuser = opuser;
        _type = type;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_PHONENUMBER_LOGIN;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    if (_type == BBQBindingMobileTypeBeforeLogin) {
        return @{
                 @"authtype" : @(_authtype),
                 @"opuser" : _opuser,
                 @"openid" : _openid,
                 @"nickname" : _nickname,
                 @"avartarurl" : _avartarurl,
                 @"access_token" : _access_token,
                 @"mobile" : _mobile,
                 @"yzcode" : _yzcode,
                 @"appid" : JYEX_APPID,
                 @"appname" : [UIApplication sharedApplication].appBundleName,
                 @"appver" : [UIApplication sharedApplication].appVersion,
                 @"appsource" : @"App Store",
                 @"ostype" : [UIDevice currentDevice].systemName,
                 @"osver" : [UIDevice currentDevice].systemVersion,
                 @"phonetype" : [UIDevice currentDevice].machineModelName,
                 @"token" : _GLOBAL.m_token,
                 @"network" : [self currentNetworkStatus]
                 };
    } else {
        return @{
                 @"authtype" : @(_authtype),
                 @"opuser" : _opuser,
                 @"openid" : _openid,
                 @"nickname" : _nickname,
                 @"avartarurl" : _avartarurl,
                 @"access_token" : _access_token,
                 @"mobile" : _mobile,
                 @"appid" : JYEX_APPID,
                 @"appname" : [UIApplication sharedApplication].appBundleName,
                 @"appver" : [UIApplication sharedApplication].appVersion,
                 @"appsource" : @"App Store",
                 @"ostype" : [UIDevice currentDevice].systemName,
                 @"osver" : [UIDevice currentDevice].systemVersion,
                 @"phonetype" : [UIDevice currentDevice].machineModelName,
                 @"token" : _GLOBAL.m_token,
                 @"network" : [self currentNetworkStatus]
                 };
    }
    
}

- (NSString *)currentNetworkStatus {
    NSString *network = @"";
    switch (
            [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus) {
        case AFNetworkReachabilityStatusUnknown: {
            network = @"UnKnown";
            break;
        }
        case AFNetworkReachabilityStatusNotReachable: {
            network = @"NotReachable";
            break;
        }
        case AFNetworkReachabilityStatusReachableViaWWAN: {
            network = @"2G/3G/4G";
            break;
        }
        case AFNetworkReachabilityStatusReachableViaWiFi: {
            network = @"Wi-Fi";
            break;
        }
        default: { break; }
    }
    return network;
}

@end
