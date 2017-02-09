//
//  BBQGetClassListApi.m
//  BBQ
//
//  Created by slovelys on 15/12/29.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQGetClassListApi.h"

@interface BBQGetClassListApi ()

@property (copy, nonatomic) NSString *schoolid;

@end

@implementation BBQGetClassListApi

- (instancetype)initWithSchoolid:(NSString *)schoolid {
    if (self = [super init]) {
        _schoolid = schoolid;
    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{
             @"schoolid" : (_schoolid ? _schoolid : @"0")
             };
}

- (NSString *)requestUrl {
    return URL_GET_CLASS_LIST;
}

@end
