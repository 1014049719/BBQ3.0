//
//  BBQShareDynamicApi.m
//  BBQ
//
//  Created by 朱琨 on 15/11/16.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQShareDynamicApi.h"

@interface BBQShareDynamicApi ()

@property (copy, nonatomic) NSString *guid;
@property (copy, nonatomic) NSNumber *sharetype;
@property (copy, nonatomic) NSNumber *uid;

@end

@implementation BBQShareDynamicApi

- (instancetype)initWithGuid:(NSString *)guid sharetype:(NSNumber *)type baobaouid:(NSNumber *)uid {
    if (self = [super init]) {
        _guid = guid;
        _sharetype = type;
        _uid = uid;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_SHARE_DYNA;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{
             @"guid": _guid,
             @"sharetype": _sharetype,
             @"baobaouid": _uid
             };
}
@end
