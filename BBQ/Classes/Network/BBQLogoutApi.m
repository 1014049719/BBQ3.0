//
//  BBQLogoutApi.m
//  BBQ
//
//  Created by 朱琨 on 15/11/16.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQLogoutApi.h"

@implementation BBQLogoutApi

- (NSString *)requestUrl {
    return URL_EXIT_LOGIN;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{
             @"token": [BBQLoginManager sharedManager].token,
             @"appid": BBQ_APPID
             };
}

@end
