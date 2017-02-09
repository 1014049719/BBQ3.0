//
//  ChoosePhotoAmountViewController.m
//  BBQ
//
//  Created by 朱琨 on 15/7/24.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "ChoosePhotoAmountViewController.h"

@interface ChoosePhotoAmountViewController ()

@property(strong, nonatomic) UIButton *lastButton;

@end

static NSInteger const kButtonBaseTag = 1000;
@implementation ChoosePhotoAmountViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.lastButton =
      (UIButton *)[self.view viewWithTag:self.currentChoice + kButtonBaseTag];
  self.lastButton.selected = YES;
}
- (IBAction)didMakeAChoice:(UIButton *)button {
  button.selected = YES;
  if (self.lastButton != button) {
    if (!self.lastButton) {
      self.lastButton = button;
      return;
    }
    self.lastButton.selected = NO;
    self.lastButton = button;
  }
  if (self.block) {
    self.block(self.lastButton.tag - kButtonBaseTag);
  }
}

#pragma mark - Life Cycle

@end
