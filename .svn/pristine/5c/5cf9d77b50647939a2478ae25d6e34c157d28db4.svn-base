//
//  BBQForwardDynamicApi.m
//  BBQ
//
//  Created by 朱琨 on 15/12/23.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQForwardDynamicApi.h"

@interface BBQForwardDynamicApi ()

@property (strong, nonatomic) Dynamic *dynamic;

@end

@implementation BBQForwardDynamicApi

- (instancetype)initWithDynamic:(Dynamic *)dynamic {
    if (self = [super init]) {
        _dynamic = dynamic;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_FORWARD_DYNAMIC;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{
             @"guid": _dynamic.guid,
             @"schoolid": TheCurBaoBao.curSchool.schoolid ?: @"",
             @"classuid": TheCurBaoBao.curClass.classid ?: @"",
             @"baobaouid": TheCurBaoBao.uid ?: @"",
             @"groupkey": TheCurUser.member.groupkey ?: @"",
             @"gxid": TheCurBaoBao.gxid ?: @"",
             @"gxname": TheCurBaoBao.gxname ?: @"",
             @"baobaoname": TheCurBaoBao.realname ?: @""
             };
}

@end
