//
//  BBQChooseDateViewController.m
//  BBQ
//
//  Created by 朱琨 on 15/10/19.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQChooseDateViewController.h"
#import "BBQCalendar.h"
#import <Masonry.h>

@interface BBQChooseDateViewController () <FSCalendarDataSource,
                                           FSCalendarDelegate>

@property(strong, nonatomic) FSCalendar *calendar;

@end

@implementation BBQChooseDateViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  self.view.layer.masksToBounds = YES;
  self.view.layer.cornerRadius = 5;
  [self setupCalendar];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  UITapGestureRecognizer *gestureRecognizer =
      [[UITapGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(dismiss)];
  [self.transitioningBackgroundView addGestureRecognizer:gestureRecognizer];
  self.transitioningBackgroundView.userInteractionEnabled = YES;
}

- (void)dismiss {
  [self.vc dismissViewControllerAnimated:YES completion:nil];
}

- (void)setupCalendar {
  self.calendar = [[BBQCalendar alloc] initWithType:BBQCalendarTypeChooseDate];
  self.calendar.delegate = self;
  self.calendar.dataSource = self;
  [self.view addSubview:self.calendar];
  [self.calendar mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self.view);
  }];
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date {
  if (self.block) {
    self.block(date);
  }
  [self dismiss];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little
 preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
