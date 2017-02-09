//
//  BBQReleaseBindingApi.m
//  BBQ
//
//  Created by slovelys on 15/11/26.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQReleaseBindingApi.h"

@interface BBQReleaseBindingApi ()

@property (assign, nonatomic) int authtype;

@end

@implementation BBQReleaseBindingApi

- (id)initWithAuthtype:(int)authtype {
    if (self = [super init]) {
        _authtype = authtype;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_RELEASE_BINDING;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{
             @"authtype": @(_authtype),
             
             };
}

@end
