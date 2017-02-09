//
//  FSCalendarAppearance+BBQCalendarAppearance.m
//  BBQ
//
//  Created by 朱琨 on 15/10/13.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "FSCalendarAppearance+BBQCalendarAppearance.h"
#import <objc/runtime.h>
#import "FSCalendarAppearance.h"
#import "FSCalendarDynamicHeader.h"

@implementation FSCalendarAppearance (BBQCalendarAppearance)

- (UIColor *)titleEventColor {
  UIColor *color = objc_getAssociatedObject(self, _cmd);
  if (!color) {
    color = self.titleColors[@(FSCalendarCellStateEvent)];
    objc_setAssociatedObject(self, _cmd, color,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  }
  return color;
}

- (void)setTitleEventColor:(UIColor *)titleEventColor {
  if (titleEventColor) {
    objc_setAssociatedObject(self, @selector(titleEventColor), titleEventColor,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.titleColors[@(FSCalendarCellStateEvent)] = titleEventColor;
  } else {
    [self.titleColors removeObjectForKey:@(FSCalendarCellStateEvent)];
  }
  [self.calendar.collectionView.visibleCells
      makeObjectsPerformSelector:@selector(setNeedsLayout)];
}

@end
