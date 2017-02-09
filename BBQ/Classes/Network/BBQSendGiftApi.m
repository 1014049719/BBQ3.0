//
//  BBQSendGiftApi.m
//  BBQ
//
//  Created by 朱琨 on 15/12/22.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQSendGiftApi.h"

@interface BBQSendGiftApi ()

@property (strong, nonatomic) Gift *gift;

@end

@implementation BBQSendGiftApi

- (instancetype)initWithGift:(Gift *)gift {
    if (self = [super init]) {
        _gift = gift;
    }
    return self;
}

- (NSString *)requestUrl {
    return URL_SEND_GIFT;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    NSDictionary *giftdata = @{
                               @"giftid": _gift.giftid ?: @"",
                               @"giftname": _gift.giftname ?: @"",
                               @"giftcount": _gift.giftcount ?: @""
                               };
    return @{
             @"guid": _gift.guid ?: @"",
             @"giftdata": @[giftdata],
             @"schoolname": _gift.schoolname ?: @"",
             @"classname": _gift.classname ?: @"",
             @"groupkey": _gift.groupkey ?: @"",
             @"gxid": _gift.gxid ?: @"",
             @"gxname": _gift.gxname ?: @"",
             @"baobaoname": _gift.baobaoname ?: @""
             };
}

@end
