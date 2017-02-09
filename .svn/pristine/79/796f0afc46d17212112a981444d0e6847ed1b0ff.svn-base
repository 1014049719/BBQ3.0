//
//  BBQChangePasswordApi.m
//  BBQ
//
//  Created by 朱琨 on 15/11/16.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQChangePasswordApi.h"
#import "DES.h"

@interface BBQChangePasswordApi ()

@property (copy, nonatomic) NSString *oldPassword;
@property (copy, nonatomic) NSString *password;

@end

@implementation BBQChangePasswordApi

- (instancetype)initWithOldPassword:(NSString *)old newPassword:(NSString *)newWord {
    if (self = [super init]) {
        _oldPassword = [DES encryptStr:old];
        _password = [DES encryptStr:newWord];
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_UPDATE_PASSWORD_ENCRYPT;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{
             @"oldpassword": _oldPassword,
             @"newpassword": _password
             };
}

@end
