//
//  BBQChangePasswordWithCodeApi.h
//  BBQ
//
//  Created by 朱琨 on 15/11/16.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "YTKRequest.h"

@interface BBQChangePasswordWithCodeApi : YTKRequest

- (instancetype)initWithPhoneNumber:(NSString *)number code:(NSString *)code password:(NSString *)password;

@end
