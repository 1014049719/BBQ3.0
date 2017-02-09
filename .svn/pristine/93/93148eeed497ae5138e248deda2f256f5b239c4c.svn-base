//
//  BBQFetchAppointedDynamicApi.m
//  BBQ
//
//  Created by 朱琨 on 15/11/16.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQFetchAppointedDynamicApi.h"

@interface BBQFetchAppointedDynamicApi ()

@property (copy, nonatomic) NSString *guid;

@end

@implementation BBQFetchAppointedDynamicApi

- (instancetype)initWithGuid:(NSString *)guid {
    if (self = [super init]) {
        _guid = guid;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_QUERY_SPECIFY_DYNA;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{
             @"guid": _guid
             };
}

@end
