//
//  BBQCalendar.h
//  BBQ
//
//  Created by 朱琨 on 15/10/13.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <FSCalendar/FSCalendar.h>

typedef NS_ENUM(NSUInteger, BBQCalendarType) {
    BBQCalendarTypeDailyReport,
    BBQCalendarTypeChooseDate,
};

@interface BBQCalendar : FSCalendar <FSCalendarDelegate>

@property (assign, nonatomic) BBQCalendarType type;

- (instancetype)initWithType:(BBQCalendarType)type;
@end
