//
//  TeJiFenDetailModel.m
//  BBQ
//
//  Created by slovelys on 15/8/18.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "TeJiFenDetailModel.h"

@implementation TeJiFenDetailModel

- (instancetype)initWithDic:(NSDictionary *)dic {
  self = [super init];
  if (self) {
    self.desc = pickJsonStrValue(dic, @"desc");
    self.jifen = pickJsonStrValue(dic, @"jifen");
    self.dateLine = pickJsonStrValue(dic, @"dateline");
  }
  return self;
}

@end
