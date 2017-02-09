//
//  BBQAutoCreateAccountLoginApi.m
//  BBQ
//
//  Created by slovelys on 15/11/23.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQAutoCreateAccountLoginApi.h"

@interface BBQAutoCreateAccountLoginApi ()

@property (assign, nonatomic) int authtype;
@property (copy, nonatomic) NSString *openid;
@property (copy, nonatomic) NSString *nickname;
@property (copy, nonatomic) NSString *avartarurl;
@property (copy, nonatomic) NSString *access_token;
@property (copy, nonatomic) NSString *opuser;

@end

@implementation BBQAutoCreateAccountLoginApi

- (instancetype)initWithAuthtype:(int)authtype opuser:(NSString *)opuser openid:(NSString *)openid nickname:(NSString *)nickname avartarurl:(NSString *)avartarurl access_token:(NSString *)access_token {
    if (self = [super init]) {
        _authtype = authtype;
        _openid = openid;
        _nickname = nickname;
        _avartarurl = avartarurl;
        _access_token = access_token;
        _opuser = opuser;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_CREATEACCOUNT_LOGIN;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{
             @"authtype" : @(_authtype),
             @"opuser" : _opuser,
             @"openid" : _openid,
             @"nickname" : _nickname,
             @"avartarurl" : _avartarurl,
             @"access_token" : _access_token,
             @"appid" : BBQ_APPID,
             @"appname" : [UIApplication sharedApplication].appBundleName,
             @"appver" : [UIApplication sharedApplication].appVersion,
             @"appsource" : @"App Store",
             @"ostype" : [UIDevice currentDevice].systemName,
             @"osver" : [UIDevice currentDevice].systemVersion,
             @"phonetype" : [UIDevice currentDevice].machineModelName,
             @"token" : [BBQLoginManager sharedManager].token,
             @"network" : [self currentNetworkStatus]
             };
}

@end
