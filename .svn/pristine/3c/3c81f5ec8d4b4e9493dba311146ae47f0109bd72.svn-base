//
//  CityPicker.m
//  BBQ
//
//  Created by slovelys on 15/8/10.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "CityPicker.h"

@interface CityPicker ()

@property(strong, nonatomic) NSArray *data;
/// 省
@property(strong, nonatomic) NSArray *province;
/// 市
@property(strong, nonatomic) NSArray *city;
/// 区
@property(strong, nonatomic) NSArray *area;

@property(strong, nonatomic) CityPickerModel *model;

@end

@implementation CityPicker

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {

  self.frame = CGRectMake(0, kScreenHeight - 250, kScreenWidth, 190);

  NSString *path =
      [[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];
  self.province = [[NSArray alloc] initWithContentsOfFile:path];
  self.city = [[self.province objectAtIndex:0] objectForKey:@"cities"];
  self.area = [[self.city objectAtIndex:0] objectForKey:@"areas"];

  self.pickerView.showsSelectionIndicator = YES;
  self.pickerView.dataSource = self;
  self.pickerView.delegate = self;

  _model = [[CityPickerModel alloc] init];
  _model.provice = @"北京";
  _model.city = @"通州";
  _model.area = @"";
}

// 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
  return 3;
}

// 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
  switch (component) {
  case 0: {
    return self.province.count;
  } break;

  case 1: {
    return self.city.count;
  } break;

  case 2: {
    return self.area.count;
  } break;

  default:

    return 0;

    break;
  }
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {

  switch (component) {
  case 0:
    return [[_province objectAtIndex:row] objectForKey:@"state"];
    break;
  case 1:
    return [[_city objectAtIndex:row] objectForKey:@"city"];
    break;
  case 2:
    if ([_area count] > 0) {
      return [_area objectAtIndex:row];
      break;
    }
  default:
    return @"";
    break;
  }
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {

  switch (component) {
  case 0:
    _city = [[_province objectAtIndex:row] objectForKey:@"cities"];
    [self.pickerView selectRow:0 inComponent:1 animated:YES];
    [self.pickerView reloadComponent:1];

    _area = [[_city objectAtIndex:0] objectForKey:@"areas"];
    [self.pickerView selectRow:0 inComponent:2 animated:YES];
    [self.pickerView reloadComponent:2];

    self.model.provice = [[_province objectAtIndex:row] objectForKey:@"state"];
    self.model.city = [[_city objectAtIndex:0] objectForKey:@"city"];
    if ([_area count] > 0) {
      self.model.area = [_area objectAtIndex:0];
    } else {
      self.model.area = @"";
    }
    break;
  case 1:
    _area = [[_city objectAtIndex:row] objectForKey:@"areas"];
    [self.pickerView selectRow:0 inComponent:2 animated:YES];
    [self.pickerView reloadComponent:2];

    self.model.city = [[_city objectAtIndex:row] objectForKey:@"city"];
    if ([_area count] > 0) {
      self.model.area = [_area objectAtIndex:0];
    } else {
      self.model.area = @"";
    }
    break;
  case 2:
    if ([_area count] > 0) {
      self.model.area = [_area objectAtIndex:row];
    } else {
      self.model.area = @"";
    }
    break;
  default:
    break;
  }
}

- (IBAction)cancelBtnEvent:(id)sender {
  [UIView animateWithDuration:0.5
                   animations:^{

                     [self removeFromSuperview];

                   }];
}

- (IBAction)sureBtnEvent:(id)sender {
  if (self.cityPickerBlock) {
    self.cityPickerBlock(_model);
  }
  [UIView animateWithDuration:0.5
                   animations:^{

                     [self removeFromSuperview];

                   }];
}
@end
