//
//  UploadStatusBar.m
//  BBQ
//
//  Created by anymuse on 15/7/24.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "UploadStatusBar.h"

@implementation UploadStatusBar

- (instancetype)init {
  if (self = [super init]) {
  }
  return self;
}

+ (instancetype)sharedInstance {
  static UploadStatusBar *statusBar = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    statusBar = [[UploadStatusBar alloc] init];
  });
  return statusBar;
}

@end
