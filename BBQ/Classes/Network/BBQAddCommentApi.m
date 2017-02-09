//
//  BBQAddCommentApi.m
//  BBQ
//
//  Created by 朱琨 on 15/12/8.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQAddCommentApi.h"

@interface BBQAddCommentApi ()

@property (strong, nonatomic) Comment *comment;

@end

@implementation BBQAddCommentApi

- (instancetype)initWithComment:(Comment *)comment {
    if (self = [super init]) {
        _comment = comment;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_ADD_COMMENT;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{
             @"cguid": _comment.cguid ?: @"",
             @"guid": _comment.guid ?: @"",
             @"isreplay": _comment.isreplay ? @1 : @0,
             @"reuid": _comment.reuid ?: @"",
             @"content": _comment.content ?: @"",
             @"schoolname": _comment.schoolname ?: @"",
             @"classname": _comment.classname ?: @"",
             @"groupkey": _comment.groupkey,
             @"gxid": _comment.gxid ?: @"",
             @"gxname": _comment.gxname ?: @"",
             @"baobaoname": _comment.baobaoname ?: @"",
             @"regxname": _comment.regxname ?: @""
             };
}

@end
