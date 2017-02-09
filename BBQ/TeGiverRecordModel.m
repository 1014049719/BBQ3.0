//
//  TeGiverRecordModel.m
//  BBQ
//
//  Created by slovelys on 15/8/12.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "TeGiverRecordModel.h"

@implementation TeGiverRecordModel

- (instancetype)initWithDic:(NSDictionary *)dic {
  if (self = [super init]) {
    self.nickName = pickJsonStrValue(dic, @"nickname");
    self.giftCount = pickJsonStrValue(dic, @"giftcount");
    self.giftID = pickJsonStrValue(dic, @"giftid");
    self.dateLine = pickJsonStrValue(dic, @"dateline");
    self.fbztx = pickJsonStrValue(dic, @"fbztx");

    self.imgUrl = pickJsonStrValue(dic, @"imgurl");
    self.giftName = pickJsonStrValue(dic, @"giftname");
    self.groupKey = pickJsonStrValue(dic, @"groupkey");
    self.gxid = pickJsonStrValue(dic, @"gxid");
    self.gxname = pickJsonStrValue(dic, @"gxname");
    self.baobaoname = pickJsonStrValue(dic, @"baobaoname");
  }
  return self;
}

@end
