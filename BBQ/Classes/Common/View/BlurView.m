//
//  BlurView.m
//  BBQ
//
//  Created by anymuse on 15/7/23.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BlurView.h"

static NSTimeInterval kDurationTime = 0.3;
@implementation BlurView
- (instancetype)init {
  if (self = [super init]) {
    self.backgroundColor = [UIColor blackColor];
    self.alpha = 0.1;
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
  }
  return self;
}

+ (instancetype)sharedInstance {
  static BlurView *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[BlurView alloc] init];
  });
  return sharedInstance;
}

- (void)showTransparencyViewInView:(UIView *)view {
  self.backgroundColor = [UIColor whiteColor];
  [view addSubview:self];
}

- (void)showBlurView {
  [[UIApplication sharedApplication].keyWindow addSubview:self];
  [UIView animateWithDuration:kDurationTime
                   animations:^{
                     self.alpha = 0.4;
                   }];
}

- (void)hideBlurView {
  [UIView animateWithDuration:kDurationTime
      animations:^{
        self.alpha = 0;
      }
      completion:^(BOOL finished) {
        [self hideBlurViewImmediately];
      }];
}

- (void)hideBlurViewImmediately {
  self.touchBlock = nil;
  [self removeFromSuperview];
}

- (nullable UIView *)hitTest:(CGPoint)point
                   withEvent:(nullable UIEvent *)event {
  UIView *hitView = [super hitTest:point withEvent:event];
  if (self == hitView) {
    if (self.touchBlock) {
      self.touchBlock();
    }
    return nil;
  }
  return hitView;
}

@end
