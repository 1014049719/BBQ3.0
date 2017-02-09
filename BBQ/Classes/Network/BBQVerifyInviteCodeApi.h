//
//  BBQVerifyInviteCodeApi.h
//  BBQ
//
//  Created by 朱琨 on 15/11/13.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "YTKRequest.h"

@interface BBQVerifyInviteCodeApi : YTKRequest

- (instancetype)initWithInviteCode:(NSString *)code;

@end
