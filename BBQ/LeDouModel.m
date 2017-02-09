//
//  LeDouModel.m
//  BBQ
//
//  Created by slovelys on 15/8/18.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "LeDouModel.h"

@implementation LeDouModel

- (instancetype)initWithDic:(NSDictionary *)dic {
  self = [super init];
  if (self) {
    self.ldCount = pickJsonStrValue(dic, @"ldcount");
    self.desc = pickJsonStrValue(dic, @"desc");
    self.dateLine = pickJsonStrValue(dic, @"dateline");
  }
  return self;
}

@end
