//
//  RelativeModel.m
//  BBQ
//
//  Created by slovelys on 15/7/24.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "RelativeModel.h"
#import "CommonJson.h"

@implementation RelativeModel

- (id)initWithDic:(NSDictionary *)dic {
  if (self = [super init]) {
    self.uid = pickJsonStrValue(dic, @"uid");
    self.userName = pickJsonStrValue(dic, @"username");
    self.avatar = pickJsonStrValue(dic, @"avatar");
    self.nickName = pickJsonStrValue(dic, @"nickname");
    self.visit_count = pickJsonStrValue(dic, @"visit_count");

    self.visit_dateline = pickJsonIntValue(dic, @"visit_dateline");
    self.gxid = pickJsonStrValue(dic, @"gxid");
    self.gxName = pickJsonStrValue(dic, @"gxname");
    self.qzb_flag = pickJsonStrValue(dic, @"qzb_flag");
    self.qx = pickJsonStrValue(dic, @"qx");

    self.isMainJiaZhang = pickJsonStrValue(dic, @"ismainjiazhang");
    self.fbdt_num = pickJsonStrValue(dic, @"fbdt_num");
    self.pic_num = pickJsonStrValue(dic, @"pic_num");
    self.ledou_num = pickJsonStrValue(dic, @"ledou_num");
  }
  return self;
}

- (id)copyWithZone:(NSZone *)zone {
  RelativeModel *newObj = [[[self class] allocWithZone:zone] init];

  newObj.uid = [NSMutableString stringWithString:self.uid];
  newObj.userName = [NSMutableString stringWithString:self.userName];
  newObj.avatar = [NSMutableString stringWithString:self.avatar];
  newObj.nickName = [NSMutableString stringWithString:self.nickName];
  newObj.visit_count = [NSMutableString stringWithString:self.visit_count];

  newObj.visit_dateline = self.visit_dateline;
  newObj.gxid = [NSMutableString stringWithString:self.gxid];
  newObj.gxName = [NSMutableString stringWithString:self.gxName];
  newObj.qzb_flag = [NSMutableString stringWithString:self.qzb_flag];
  newObj.qx = [NSMutableString stringWithString:self.qx];

  newObj.isMainJiaZhang =
      [NSMutableString stringWithString:self.isMainJiaZhang];
  newObj.fbdt_num = [NSMutableString stringWithString:self.fbdt_num];
  newObj.pic_num = [NSMutableString stringWithString:self.pic_num];
  newObj.ledou_num = [NSMutableString stringWithString:self.ledou_num];

  return newObj;
}

@end
