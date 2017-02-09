//
//  GroupModel.m
//  BBQ
//
//  Created by slovelys on 15/7/24.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "GroupModel.h"

@implementation GroupModel

- (id)initWithDic:(NSDictionary *)dic {
  if (self = [super init]) {
    self.num = pickJsonStrValue(dic, @"num");
    self.maxNum = pickJsonStrValue(dic, @"maxnum");

    NSArray *arr = [dic objectForKey:@"qyarr"];
    NSMutableArray *qyAry = [NSMutableArray arrayWithCapacity:0];
    if (arr && [arr isKindOfClass:[NSArray class]]) {
      for (NSDictionary *tempDic in arr) {
        RelativeModel *model = [[RelativeModel alloc] initWithDic:tempDic];
        [qyAry addObject:model];
      }
    }
    self.qyArr = qyAry;
  }
  return self;
}

@end
