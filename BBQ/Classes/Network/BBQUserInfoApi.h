//
//  BBQUserInfoApi.h
//  BBQ
//
//  Created by 朱琨 on 16/1/12.
//  Copyright © 2016年 bbq. All rights reserved.
//

#import "YTKRequest.h"

@interface BBQUserInfoApi : YTKRequest

- (instancetype)initWithUid:(NSNumber *)uid;

@end
