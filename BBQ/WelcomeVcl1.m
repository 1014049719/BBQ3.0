//
//  WelcomeVcl1.m
//  BBQ
//
//  Created by wth on 15/10/9.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "WelcomeVcl1.h"

@interface WelcomeVcl1 ()

@property(weak, nonatomic) IBOutlet UIImageView *imageView1;
@property(weak, nonatomic) IBOutlet NSLayoutConstraint *topSpace1;

@end

@implementation WelcomeVcl1

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib
}

//动画（要写在此处，不然不管用）
- (void)updateViewConstraints {
  [super updateViewConstraints];

  self.topSpace1.constant = 114;

  [UIView animateWithDuration:1
                   animations:^{
                     [self.view layoutIfNeeded];
                   }];
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
