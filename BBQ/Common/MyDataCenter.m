//
//  MyDataCenter.m
//  BBQ
//
//  Created by wth on 15/9/10.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "MyDataCenter.h"

static MyDataCenter *dataCenter = nil;

@implementation MyDataCenter

+ (MyDataCenter *)defaultCenter {

  if (dataCenter == nil) {
    dataCenter = [[MyDataCenter alloc] init];
  }

  return dataCenter;
}

@end
