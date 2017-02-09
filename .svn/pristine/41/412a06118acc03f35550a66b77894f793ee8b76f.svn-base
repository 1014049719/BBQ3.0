//
//  BBQLoginApi.h
//  BBQ
//
//  Created by 朱琨 on 15/11/13.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "YTKRequest.h"

typedef NS_ENUM(NSInteger, BBQLoginType) {
    BBQLoginTypeNormal,
    BBQLoginTypeWeChat,
    BBQLoginTypeQQ,
    BBQLoginTypeAutoCreateWithWeChat,
    BBQLoginTypeAutoCreateWithQQ,
    BBQLoginTypeBindingPhoneWithWeChat,
    BBQLoginTypeBindingPhoneWithQQ
};

@interface BBQLoginApi : YTKRequest

- (instancetype)initWithUsername:(NSString *)username password:(NSString *)password type:(BBQLoginType)type;

@end
