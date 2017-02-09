//
//  TeRemindPhotoModel.m
//  BBQ
//
//  Created by slovelys on 15/8/14.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "TeRemindPhotoModel.h"

@implementation TeRemindPhotoModel

- (instancetype)initWithDic:(NSDictionary *)dic {
  if (self = [super init]) {
    self.uid = pickJsonStrValue(dic, @"uid");
    self.baobaoName = pickJsonStrValue(dic, @"baobaoname");
    self.qzkbz = pickJsonStrValue(dic, @"qzkbz");
    self.flag = pickJsonStrValue(dic, @"flag");
    self.pic_num1 = pickJsonStrValue(dic, @"pic_num1");

    self.pic_num2 = pickJsonStrValue(dic, @"pic_num2");
    self.pic_num3 = pickJsonStrValue(dic, @"pic_num3");
    self.finished = pickJsonStrValue(dic, @"finished");
    self.dateLine = pickJsonStrValue(dic, @"dateline");
    self.avatar = pickJsonStrValue(dic, @"avatar");
    self.mark = pickJsonStrValue(dic, @"mark");
  }
  return self;
}

@end
