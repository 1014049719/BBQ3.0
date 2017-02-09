//
//  BBQEditWordsModel.m
//  BBQ
//
//  Created by 朱琨 on 15/10/20.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQEditWordsModel.h"

@implementation BBQEditWordsModel

- (instancetype)init {
  self = [super init];
  if (self) {
    self.babyList = [NSMutableArray array];
    self.curSelect = 0;
  }
  return self;
}

@end
