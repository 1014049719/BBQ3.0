//
//  BabyDailyReportModel.m
//  BBQ
//
//  Created by anymuse on 15/8/15.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "BabyDailyReportModel.h"

@implementation BabyDailyReportModel

- (instancetype)initWithDictionary:(NSDictionary *)dic {
  if (self = [super init]) {
    self.classuid = dic[@"classuid"];
    self.baobaouid = dic[@"baobaouid"];
    self.datetime = dic[@"datetime"];
    self.zaocan = dic[@"zaocan"];
    self.zhongcan = dic[@"zhongcan"];
    self.wushui = dic[@"wushui"];
    self.heshui = dic[@"heshui"];
    self.qingxu = dic[@"qingxu"];
    self.qt = dic[@"qt"];
    self.jkzk = dic[@"jkzk"];
    self.xxzd = dic[@"xxzd"];
  }
  return self;
}

@end
