//
//  DatePicker.h
//  BBQ
//
//  Created by slovelys on 15/7/29.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BBQDatePickerType) {
    BBQDatePickerTypeNormal = 1,
    BBQDatePickerTypeCreateLeave,
};

typedef void(^datePickerBlock)(NSString *);

@interface DatePicker : UIView
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (assign, nonatomic) BBQDatePickerType dpType;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
/// 是否已经加载datePicker的标识, 防止重复加载
@property (assign, nonatomic) BOOL datePickerIsOn;

- (IBAction)sureButtonEvent:(id)sender;
- (IBAction)cancelButtonEvent:(id)sender;

@property (copy, nonatomic) datePickerBlock datePickerCallBack;

@end
