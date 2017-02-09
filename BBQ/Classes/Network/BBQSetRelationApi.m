//
//  BBQSetRelationApi.m
//  BBQ
//
//  Created by 朱琨 on 15/11/13.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQSetRelationApi.h"

@interface BBQSetRelationApi ()

@property (copy, nonatomic) NSNumber *gxid;
@property (copy, nonatomic) NSString *gxname;
@property (copy, nonatomic) NSString *nickname;
@property (copy, nonatomic) NSNumber *uid;

@end

@implementation BBQSetRelationApi

- (instancetype)initWithGxID:(NSNumber *)gxid gxname:(NSString *)gxname nickname:(NSString *)nickname baobaouid:(NSNumber *)uid {
    if (self = [super init]) {
        _gxid = gxid;
        _gxname = gxname;
        _nickname = nickname;
        _uid = uid;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_UPDATE_RELATION;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{
             @"gx": _gxid,
             @"gxname": _gxname,
             @"nickname": _nickname,
             @"baobaouid": _uid
             };
}

@end
