//
//  BBQCreateLeaveApi.m
//  BBQ
//
//  Created by slovelys on 15/12/2.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQCreateLeaveApi.h"

@interface BBQCreateLeaveApi ()

@property (copy, nonatomic) NSString *baobaouid;
@property (copy, nonatomic) NSString *classuid;
@property (copy, nonatomic) NSString *schoolid;
@property (copy, nonatomic) NSString *dotime_s;
@property (copy, nonatomic) NSString *dotime_e;
@property (copy, nonatomic) NSString *content;
@property (assign, nonatomic) int type;

@property (strong, nonatomic) NSDictionary *dic;

@end

@implementation BBQCreateLeaveApi



- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        _dic = dic;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_CREATE_LEAVE;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return _dic;
}

@end
