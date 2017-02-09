//
//  BBQDeleteRelativeApi.m
//  BBQ
//
//  Created by 朱琨 on 15/11/16.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQDeleteRelativeApi.h"

@interface BBQDeleteRelativeApi ()

@property (copy, nonatomic) NSNumber *uid;

@end

@implementation BBQDeleteRelativeApi

- (instancetype)initWithUid:(NSNumber *)uid {
    if (self = [super init]) {
        _uid = uid;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_DELETE_RELATIVE;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{
             @"baobaouid": TheCurBaoBao.uid,
             @"uid": _uid
             };
}

@end
