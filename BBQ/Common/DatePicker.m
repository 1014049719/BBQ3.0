//
//  DatePicker.m
//  BBQ
//
//  Created by slovelys on 15/7/29.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "DatePicker.h"
#import <DateTools.h>

@implementation DatePicker

- (void)awakeFromNib {
  self.frame = CGRectMake(0, kScreenHeight - 250, kScreenWidth, 190);

}

- (IBAction)sureButtonEvent:(id)sender {
  NSDate *selected = [_datePicker date];

  
    if (_dpType == BBQDatePickerTypeCreateLeave) {
        if (self.datePickerCallBack) {
            self.datePickerCallBack([selected formattedDateWithFormat:@"yyyy-MM-dd HH:00:00"]);
        }
    } else {
        if (self.datePickerCallBack) {
            self.datePickerCallBack([selected formattedDateWithFormat:@"yyyy-MM-dd"]);
        }
    }

  [UIView animateWithDuration:0.5
                   animations:^{

                     [self removeFromSuperview];

                   }];
  self.datePickerIsOn = NO;
}

- (IBAction)cancelButtonEvent:(id)sender {
  [UIView animateWithDuration:0.5
                   animations:^{

                     [self removeFromSuperview];

                   }];
  self.datePickerIsOn = NO;
}
@end
