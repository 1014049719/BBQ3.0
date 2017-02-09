//
//  BBQBabyStatusModel.m
//  BBQ
//
//  Created by 朱琨 on 15/10/18.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQBabyStatusModel.h"

@implementation BBQBabyStatusModel

- (instancetype)init {
  self = [super init];
  if (self) {
    self.selected = YES;
    self.expand = NO;
    self.selectedStatus = 0;
  }
  return self;
}

@end
