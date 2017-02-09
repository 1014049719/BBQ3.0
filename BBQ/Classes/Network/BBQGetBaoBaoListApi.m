//
//  BBQGetBaoBaoListApi.m
//  BBQ
//
//  Created by slovelys on 15/12/29.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQGetBaoBaoListApi.h"

@interface BBQGetBaoBaoListApi ()

@property (copy, nonatomic) NSNumber *classid;

@end

@implementation BBQGetBaoBaoListApi

- (instancetype)initWithClassid:(NSNumber *)classid {
    if (self = [super init]) {
        _classid  = classid;
    }
    return self;
}

- (NSInteger)cacheTimeInSeconds {
    return 1 * 60;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{
             @"classid" : _classid ?: @""
             };
}

- (NSString *)requestUrl {
    return URL_GET_BAOBAO_LIST;
}

@end
