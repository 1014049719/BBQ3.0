//
//  BBQGetSMSCodeApi.m
//  BBQ
//
//  Created by 朱琨 on 15/11/16.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQGetSMSCodeApi.h"

@interface BBQGetSMSCodeApi ()

@property (copy, nonatomic) NSString *number;
@property (copy, nonatomic) NSNumber *isbind;

@end

@implementation BBQGetSMSCodeApi

- (instancetype)initWithPhoneNumber:(NSString *)number isbind:(NSNumber *)isbind {
    if (self = [super init]) {
        _number = number;
        _isbind = isbind;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_GET_VERIFY_CODE;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{
             @"mobile" : _number,
             @"isbind" : _isbind
             };
}

@end
