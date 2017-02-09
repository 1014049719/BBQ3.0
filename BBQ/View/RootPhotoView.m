//
//  RootPhotoView.m
//  BBQ
//
//  Created by anymuse on 15/7/24.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "RootPhotoView.h"
#import "AppDelegate.h"

@interface RootPhotoView ()

@property(strong, nonatomic) UIView *blur;

@end

@implementation RootPhotoView

- (instancetype)init {
  if (self = [super init]) {
  }
  return self;
}

- (void)addBlurView {
}

+ (instancetype)sharedInstance {
  static RootPhotoView *photoView = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    photoView = [[RootPhotoView alloc] init];
  });
  return photoView;
}

- (void)showInView:(UIView *)view {
}

@end
