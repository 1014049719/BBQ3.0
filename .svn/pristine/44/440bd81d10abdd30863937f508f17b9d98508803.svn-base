//
//  BBQChangePasswordWithCodeApi.m
//  BBQ
//
//  Created by 朱琨 on 15/11/16.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQChangePasswordWithCodeApi.h"
#import "DES.h"

@interface BBQChangePasswordWithCodeApi ()

@property (copy, nonatomic) NSString *number;
@property (copy, nonatomic) NSString *code;
@property (copy, nonatomic) NSString *password;

@end

@implementation BBQChangePasswordWithCodeApi

- (instancetype)initWithPhoneNumber:(NSString *)number code:(NSString *)code password:(NSString *)password {
    if (self = [super init]) {
        _number = number;
        _code = code;
        _password = [DES encryptStr:password];
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_UPDATE_PASSWORD_BY_YZCODE_ENCRYPT;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{
             @"mobile": _number,
             @"yzcode": _code,
             @"newpassword": _password,
             @"newpassword2": _password,
             };
}
@end
