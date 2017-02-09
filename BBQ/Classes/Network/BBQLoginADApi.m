//
//  BBQLoginADApi.m
//  BBQ
//
//  Created by 朱琨 on 16/1/11.
//  Copyright © 2016年 bbq. All rights reserved.
//

#import "BBQLoginADApi.h"

@interface BBQLoginADApi ()

@property (copy, nonatomic) NSString *appType;

@end

@implementation BBQLoginADApi

- (instancetype)initWithAppType:(NSString *)type {
    if (self = [super init]) {
        _appType = type;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_AdvertisementLogin;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{
             @"appType": _appType
             };
}


@end
