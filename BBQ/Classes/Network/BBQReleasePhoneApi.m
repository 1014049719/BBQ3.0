//
//  BBQReleasePhone.m
//  BBQ
//
//  Created by slovelys on 15/11/27.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQReleasePhoneApi.h"

@interface BBQReleasePhoneApi ()

@property (copy, nonatomic) NSString *mobile;
@property (copy, nonatomic) NSString *yzm;

@end

@implementation BBQReleasePhoneApi

- (id)initWithMobile:(NSString *)mobile yzm:(NSString *)yzm {
    if (self = [super init]) {
        _mobile = mobile;
        _yzm = yzm;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_MOD_BINDINGPHONE;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{
             @"mobile": _mobile,
             @"yzm" : _yzm
             };
}

@end
