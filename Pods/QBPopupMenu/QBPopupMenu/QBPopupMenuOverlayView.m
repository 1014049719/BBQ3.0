//
//  QBPopupMenuOverlayView.m
//  QBPopupMenu
//
//  Created by Tanaka Katsuma on 2013/11/24.
//  Copyright (c) 2013年 Katsuma Tanaka. All rights reserved.
//

#import "QBPopupMenuOverlayView.h"

#import "QBPopupMenu.h"

@implementation QBPopupMenuOverlayView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];

  if (self) {
    self.backgroundColor = [UIColor clearColor];
  }

  return self;
}

- (nullable UIView *)hitTest:(CGPoint)point
                   withEvent:(nullable UIEvent *)event {
  UIView *hitView = [super hitTest:point withEvent:event];
  if (self == hitView) {
    [self.popupMenu dismissAnimated:YES];
    [self removeFromSuperview];
    return nil;
  }
  return hitView;
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touch = [touches anyObject];
//    UIView *view = touch.view;
//
//    if (view == self) {
//        // Close popup menu
//        [self.popupMenu dismissAnimated:YES];
//        [self removeFromSuperview];
//    }
//}

@end
