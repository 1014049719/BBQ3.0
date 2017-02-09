//
//  CityPicker.h
//  BBQ
//
//  Created by slovelys on 15/8/10.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityPickerModel.h"

typedef void(^cityPickerCallBack)(CityPickerModel *);

@interface CityPicker : UIView <UIPickerViewDataSource, UIPickerViewDelegate>



@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (copy, nonatomic) cityPickerCallBack cityPickerBlock;

- (IBAction)cancelBtnEvent:(id)sender;

- (IBAction)sureBtnEvent:(id)sender;

@end
