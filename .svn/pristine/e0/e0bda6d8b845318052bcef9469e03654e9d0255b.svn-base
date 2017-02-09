//
//  BBQLeaveModifyApi.m
//  BBQ
//
//  Created by slovelys on 15/12/3.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQLeaveModifyApi.h"

@interface BBQLeaveModifyApi ()
@property (assign, nonatomic) int bid;
@property (copy, nonatomic) NSString *dotime_s;
@property (copy, nonatomic) NSString *dotime_e;
@property (copy, nonatomic) NSString *content;
@property (assign, nonatomic) int type;

@end

@implementation BBQLeaveModifyApi

- (instancetype)initWithBid:(int)bid type:(int)type dotime_s:(NSString *)dotime_s dotime_e:(NSString *)dotime_e content:(NSString *)content {
    if (self = [super init]) {
        _bid = bid;
        _type = type;
        _dotime_s = dotime_s;
        _dotime_e = dotime_e;
        _content = content;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_LEAVE_MODIFY;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{
             @"bid" : @(_bid),
             @"type" : @(_type),
             @"dotime_s" : _dotime_s,
             @"dotime_e" : _dotime_e,
             @"content" : _content
             };
}

@end
