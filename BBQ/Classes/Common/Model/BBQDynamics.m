//
//  BBQDynamics.m
//  BBQ
//
//  Created by 朱琨 on 15/10/28.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQDynamics.h"

@implementation BBQDynamics

+ (instancetype)dynamicsWithType:(DynamicType)dynamicType {
  BBQDynamics *dynamics = [BBQDynamics new];
  dynamics.dynamicType = dynamicType;
  dynamics.isLoading = NO;
  dynamics.canLoadMore = NO;
  dynamics.willLoadMore = NO;
  return dynamics;
}

- (void)configWithDynamics:(NSArray *)responseA {
}

- (NSDictionary *)toParams {
  NSMutableDictionary *params =
      [[NSMutableDictionary alloc] initWithCapacity:9];
  return params;
}

@end
