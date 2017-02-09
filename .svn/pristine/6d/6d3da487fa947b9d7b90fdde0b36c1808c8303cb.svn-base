//
//  BBQLeaveListFamilyApi.m
//  BBQ
//
//  Created by slovelys on 15/12/1.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQLeaveListFamilyApi.h"

@interface BBQLeaveListFamilyApi ()

@property (strong, nonatomic) NSDictionary *params;

@end

@implementation BBQLeaveListFamilyApi

- (instancetype)initWithDic:(NSDictionary *)params {
    if (self = [super init]) {
        _params = params;
    }
    return self;
}

- (id)requestArgument {
    return _params;
}

- (NSString *)requestUrl {
#ifdef TARGET_PARENT
    return URL_LEAVE_LIST_FAMILY;
#else
    return URL_LEAVE_LIST_TEACHER;
#endif
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

@end
