//
//  BBQBindingPhoneViewController.h
//  BBQ
//
//  Created by slovelys on 15/11/20.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQBaseViewController.h"

typedef void(^bdCallBack)(void);

typedef NS_ENUM(NSUInteger, BBQBindingPhoneType) {
    BBQBindingPhoneTypeNormal = 1,
    BBQBindingPhoneTypeModify,
};

@interface BBQBindingPhoneViewController : BBQBaseViewController

@property (assign, nonatomic) BBQLoginType loginType;
@property (assign, nonatomic) BBQBindingPhoneType bdtype;
@property (copy, nonatomic) bdCallBack blcok;

@end
