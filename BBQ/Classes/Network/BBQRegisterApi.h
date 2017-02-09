//
//  BBQRegisterApi.h
//  BBQ
//
//  Created by 朱琨 on 15/11/12.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "YTKRequest.h"

@interface BBQRegisterApi : YTKRequest

- (instancetype)initWithUsername:(NSString *)username password:(NSString *)password;

@end
