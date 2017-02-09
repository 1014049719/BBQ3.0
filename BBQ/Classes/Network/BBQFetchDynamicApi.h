//
//  BBQFetchDynamicApi.h
//  BBQ
//
//  Created by 朱琨 on 15/11/16.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "YTKRequest.h"

@interface BBQFetchDynamicApi : YTKRequest

@property (copy, nonatomic) NSDictionary *params;

- (instancetype)initWithParams:(NSDictionary *)params;

@end
