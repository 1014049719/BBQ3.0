//
//  BBQFetchAllCommentApi.m
//  BBQ
//
//  Created by 朱琨 on 15/11/16.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQFetchAllCommentApi.h"

@interface BBQFetchAllCommentApi ()

@property (copy, nonatomic) NSString *guid;

@end

@implementation BBQFetchAllCommentApi

- (instancetype)initWithGuid:(NSString *)guid {
    if (self = [super init]) {
        _guid = guid;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_QUERY_COMMENT;
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
