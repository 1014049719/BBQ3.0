//
//  UIView+Extension.m
//  黑马微博2期
//
//  Created by apple on 14-10-7.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)setBbqX:(CGFloat)x {
  CGRect frame = self.frame;
  frame.origin.x = x;
  self.frame = frame;
}

- (void)setBbqY:(CGFloat)y {
  CGRect frame = self.frame;
  frame.origin.y = y;
  self.frame = frame;
}

- (CGFloat)bbqX {
  return self.frame.origin.x;
}

- (CGFloat)bbqY {
  return self.frame.origin.y;
}

- (void)setBbqWidth:(CGFloat)width {
  CGRect frame = self.frame;
  frame.size.width = width;
  self.frame = frame;
}

- (void)setBbqHeight:(CGFloat)height {
  CGRect frame = self.frame;
  frame.size.height = height;
  self.frame = frame;
}

- (CGFloat)bbqHeight {
  return self.frame.size.height;
}

- (CGFloat)bbqWidth {
  return self.frame.size.width;
}

- (void)setBbqSize:(CGSize)size {
  CGRect frame = self.frame;
  frame.size = size;
  self.frame = frame;
}

- (CGSize)bbqSize {
  return self.frame.size;
}

- (void)setBbqOrigin:(CGPoint)origin {
  CGRect frame = self.frame;
  frame.origin = origin;
  self.frame = frame;
}

- (CGPoint)bbqOrigin {
  return self.frame.origin;
}

- (void)setBbqCenterX:(CGFloat)centerX {
  CGPoint center = self.center;
  center.x = centerX;
  self.center = center;
}
- (CGFloat)bbqCenterX {
  return self.center.x;
}
- (void)setBbqCenterY:(CGFloat)centerY {
  CGPoint center = self.center;
  center.y = centerY;
  self.center = center;
}
- (CGFloat)bbqCenterY {
  return self.center.x;
}

@end
