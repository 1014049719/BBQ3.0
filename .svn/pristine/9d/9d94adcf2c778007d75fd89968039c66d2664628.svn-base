//
//  BBQResetXGTokenApi.m
//  BBQ
//
//  Created by 朱琨 on 15/12/14.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQResetXGTokenApi.h"

@interface BBQResetXGTokenApi ()

@property (copy, nonatomic) NSString *oldToken;

@end

@implementation BBQResetXGTokenApi

- (instancetype)initWithOldToken:(NSString *)oldToken {
    if (self = [super init]) {
        _oldToken = oldToken;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_RESET_TOKEN;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{
             @"token_new": [BBQLoginManager sharedManager].token,
             @"token_old": _oldToken,
             @"appid": BBQ_APPID
             };
}

@end
