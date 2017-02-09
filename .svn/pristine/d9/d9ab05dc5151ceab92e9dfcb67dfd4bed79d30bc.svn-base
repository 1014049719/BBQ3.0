//
//  BBQDeleteLeaveApi.m
//  BBQ
//
//  Created by slovelys on 15/12/3.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQDeleteLeaveApi.h"

@interface BBQDeleteLeaveApi ()

@property (assign, nonatomic) int sid;

@end

@implementation BBQDeleteLeaveApi

- (instancetype)initWithSid:(int)sid {
    if (self = [super init]) {
        _sid = sid;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_DELETE_LEAVE;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{
             @"sid" : @(_sid)
             };
}

@end
