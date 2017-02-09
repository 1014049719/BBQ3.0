//
//  BBQVerifyInviteCodeApi.m
//  BBQ
//
//  Created by 朱琨 on 15/11/13.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQVerifyInviteCodeApi.h"

@interface BBQVerifyInviteCodeApi ()

@property (copy, nonatomic) NSString *code;

@end

@implementation BBQVerifyInviteCodeApi

- (instancetype)initWithInviteCode:(NSString *)code {
    if (self = [super init]) {
        _code = code;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_REQUEST_CODE;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{
             @"requestcode": _code
             };
}

//- (id)jsonValidator {
//    return @{
//             @"res": [NSNumber class],
//             @"msg": [NSString class],
//             @"cmdcode": [NSString class],
//             @"data": @{
//                        @"uid": [NSString class],
//                        @"nickname": [NSString class],
//                        @"realname": [NSString class],
//                        @"gender": [NSString class],
//                        @"birthday": [NSString class],
//                        @"birthmonth": [NSString class],
//                        @"birthyear": [NSString class],
//                        @"username": [NSString class],
//                        @"schooluid": [NSString class],
//                        @"classuid": [NSString class],
//                        @"schoolname": [NSString class],
//                        @"classname": [NSString class],
//                        @"gxid": [NSString class],
//                        @"gxname": [NSString class],
//                        @"avartar": [NSString class],
//                        @"qx": [NSString class]
//                        }
//             };
//}


@end
