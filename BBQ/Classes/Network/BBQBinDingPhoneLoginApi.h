//
//  BBQBinDingPhoneLoginApi.h
//  BBQ
//
//  Created by slovelys on 15/11/23.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "YTKRequest.h"

typedef NS_ENUM(NSInteger, BBQBindingMobileType) {
    BBQBindingMobileTypeBeforeLogin = 0,
    BBQBindingMobileTypeAfterLogin,
};

@interface BBQBinDingPhoneLoginApi : YTKRequest

- (instancetype)initWithAuthtype:(int)authtype opuser:(NSString *)opuser openid:(NSString *)openid nickname:(NSString *)nickname avartarurl:(NSString *)avartarurl access_token:(NSString *)access_token mobile:(NSString *)mobile yzcode:(NSString *)yzcode type:(BBQBindingMobileType)type;

@end
