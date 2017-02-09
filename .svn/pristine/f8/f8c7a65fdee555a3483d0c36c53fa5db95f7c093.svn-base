//
//  BBQNavigationBar.m
//  BBQ
//
//  Created by 朱琨 on 15/8/23.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQNavigationBar.h"

@implementation BBQNavigationBar

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    for (UIView *view in self.subviews) {
      if ([view
              isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
        [view removeFromSuperview];
      }
    }
  }
  return self;
}
@end
