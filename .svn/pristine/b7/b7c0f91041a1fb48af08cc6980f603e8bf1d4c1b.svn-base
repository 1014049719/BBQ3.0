//
//  BBQCalendar.m
//  BBQ
//
//  Created by 朱琨 on 15/10/13.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQCalendar.h"
#import "NSDate+FSExtension.h"
#import <DateTools.h>
#import "FSCalendarDynamicHeader.h"
#import "FSCalendarAppearance+BBQCalendarAppearance.h"

@interface BBQCalendar () <UIScrollViewDelegate, FSCalendarDelegate>

@property(strong, nonatomic) UIButton *leftButton;
@property(strong, nonatomic) UIButton *rightButton;

@end

@implementation BBQCalendar

- (instancetype)initWithType:(BBQCalendarType)type {
  if (self = [super init]) {
    _type = type;
    //        if (type == BBQCalendarTypeDailyReport) {
    NSString *leftButtonImage =
        type == BBQCalendarTypeDailyReport ? @"calendar_left" : @"xiaoyou";
    NSString *rightButtonImage =
        type == BBQCalendarTypeDailyReport ? @"calendar_right" : @"xiaozuo";
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setImage:[UIImage imageNamed:leftButtonImage]
                forState:UIControlStateNormal];
    [leftButton addTarget:self
                   action:@selector(scrollCalendar:)
         forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftButton];

    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setImage:[UIImage imageNamed:rightButtonImage]
                 forState:UIControlStateNormal];
    [rightButton addTarget:self
                    action:@selector(scrollCalendar:)
          forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightButton];

    leftButton.frame =
        CGRectMake(type == BBQCalendarTypeDailyReport ? 0 : 15,
                   FSCalendarStandardHeaderHeight / 2.0 - 12, 24, 24);
    rightButton.frame =
        CGRectMake(type == BBQCalendarTypeDailyReport ? kScreenWidth - 30 - 24
                                                      : kScreenWidth - 30 - 39,
                   FSCalendarStandardHeaderHeight / 2.0 - 12, 24, 24);
    self.leftButton = leftButton;
    self.rightButton = rightButton;
    [self setupAppearance];
  }
  return self;
}

- (void)setupAppearance {
  self.appearance.adjustsFontSizeToFitContentSize = NO;
  self.appearance.eventColor = [UIColor clearColor];
  self.appearance.titleEventColor = [UIColor blackColor];
  self.appearance.headerDateFormat = @"yyyy年MMM";
  self.appearance.headerMinimumDissolvedAlpha = 0.0;
  self.appearance.headerTitleColor = [UIColor colorWithHexString:@"ff6440"];

  //    self.appearance.useVeryShortWeekdaySymbols = YES;
  self.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;

  self.appearance.titleFont = [UIFont systemFontOfSize:16];
  self.appearance.headerTitleFont = [UIFont systemFontOfSize:17];
  self.appearance.todayColor = [UIColor colorWithHexString:@"ff6440"];
  self.appearance.weekdayTextColor = [UIColor whiteColor];

  self.firstWeekday = 2;
  self.layer.cornerRadius = 5;
  self.layer.masksToBounds = YES;
  if (self.type == BBQCalendarTypeDailyReport) {
    self.appearance.selectionColor = [UIColor whiteColor];
    self.appearance.titleSelectionColor = [UIColor lightGrayColor];
    self.appearance.titleDefaultColor = [UIColor lightGrayColor];
    self.backgroundColor = [UIColor clearColor];
  } else {
    self.appearance.selectionColor = [UIColor lightGrayColor];
    self.appearance.titleSelectionColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor whiteColor];
    self.appearance.titleWeekendColor = [UIColor lightGrayColor];
  }
}

- (void)scrollCalendar:(UIButton *)button {

  CGPoint currentOffset = self.collectionView.contentOffset;
  self.leftButton.userInteractionEnabled = NO;
  self.rightButton.userInteractionEnabled = NO;
  if (button == self.leftButton) {
    [self.collectionView
        setContentOffset:CGPointMake(currentOffset.x - self.width,
                                     currentOffset.y)
                animated:YES];
  } else {
    [self.collectionView
        setContentOffset:CGPointMake(currentOffset.x + self.width,
                                     currentOffset.y)
                animated:YES];
  }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
  self.leftButton.userInteractionEnabled = YES;
  self.rightButton.userInteractionEnabled = YES;

  [self willChangeValueForKey:@"currentPage"];
  self.currentPage =
      [self.minimumDate dateByAddingMonths:scrollView.contentOffset.x /
                                              scrollView.width]
          .fs_dateByIgnoringTimeComponents;
  [self currentPageDidChange];
  [self didChangeValueForKey:@"currentPage"];
}

- (void)drawRect:(CGRect)rect {
  [super drawRect:rect];
  if (self.type == BBQCalendarTypeDailyReport) {
    UILabel *label = self.weekdays.firstObject;
    UIBezierPath *path = [UIBezierPath
        bezierPathWithRoundedRect:CGRectMake(0, CGRectGetMinY(label.frame),
                                             CGRectGetWidth(self.frame),
                                             CGRectGetHeight(label.frame))
                byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft
                      cornerRadii:CGSizeMake(5, 5)];
    [[UIColor colorWithHexString:@"ff6440"] setFill];
    [path fill];

    path = [UIBezierPath
        bezierPathWithRoundedRect:CGRectMake(0, CGRectGetMaxY(label.frame),
                                             CGRectGetWidth(self.frame),
                                             CGRectGetMaxY(self.frame) -
                                                 CGRectGetMaxY(label.frame))
                byRoundingCorners:UIRectCornerBottomLeft |
                                  UIRectCornerBottomRight
                      cornerRadii:CGSizeMake(5, 5)];
    [[UIColor whiteColor] setFill];
    [path fill];
  } else if (self.type == BBQCalendarTypeChooseDate) {
    UILabel *label = self.weekdays.firstObject;
    UIBezierPath *path = [UIBezierPath
        bezierPathWithRect:CGRectMake(-10, CGRectGetMinY(label.frame),
                                      CGRectGetWidth(self.frame) + 20,
                                      CGRectGetHeight(label.frame))];
    [[UIColor colorWithHexString:@"ff6440"] setFill];
    [path fill];
  }
}

@end
