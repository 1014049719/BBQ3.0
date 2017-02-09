//
//  BBQFetchDynamicApi.m
//  BBQ
//
//  Created by 朱琨 on 15/11/16.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQFetchDynamicApi.h"

@interface BBQFetchDynamicApi ()


@end

@implementation BBQFetchDynamicApi

- (instancetype)initWithParams:(NSDictionary *)params {
    if (self = [super init]) {
        _params = params;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_QUERY_DYNA;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return _params;
}

@end
