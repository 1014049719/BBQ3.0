//
//  BBQRegisterApi.m
//  BBQ
//
//  Created by 朱琨 on 15/11/12.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQRegisterApi.h"
#import "DES.h"

@interface BBQRegisterApi ()

@property (copy, nonatomic) NSString *username;
@property (copy, nonatomic) NSString *password;

@end

@implementation BBQRegisterApi

- (instancetype)initWithUsername:(NSString *)username password:(NSString *)password {
    if (self = [super init]) {
        _username = username;
//        _password = [DES encryptStr:password];
        _password = password;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_REGISTER;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{
             @"username": _username,
             @"password": _password
             };
}

@end
