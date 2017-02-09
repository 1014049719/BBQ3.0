//
//  BBQUrlArgumentsFilter.m
//  BBQ
//
//  Created by 朱琨 on 15/11/12.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQUrlArgumentsFilter.h"
#import "YTKNetworkPrivate.h"

@implementation BBQUrlArgumentsFilter {
    NSDictionary *_arguments;
}

+ (instancetype)filterWithArguments:(NSDictionary *)arguments {
    return [[self alloc] initWithArguments:arguments];
}

- (instancetype)initWithArguments:(NSDictionary *)arguments {
    self = [super init];
    if (self) {
        _arguments = arguments;
    }
    return self;
}

- (NSString *)filterUrl:(NSString *)originUrl withRequest:(YTKBaseRequest *)request {
    return [YTKNetworkPrivate urlStringWithOriginUrlString:originUrl appendParameters:_arguments];
}


@end
