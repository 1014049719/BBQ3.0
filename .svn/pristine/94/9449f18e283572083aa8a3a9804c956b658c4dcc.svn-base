//
//  BBQDeleteDynamicApi.m
//  BBQ
//
//  Created by 朱琨 on 15/11/16.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQDeleteDynamicApi.h"

@interface BBQDeleteDynamicApi ()

@property (copy, nonatomic) NSString *guid;

@end

@implementation BBQDeleteDynamicApi

- (instancetype)initWithGuid:(NSString *)guid {
    if (self = [super init]) {
        _guid = guid;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_DELETE_DYNA;
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
