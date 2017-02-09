//
//  BBQInviteManageViewController.m
//  BBQ
//
//  Created by anymuse on 15/11/26.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQInviteManageViewController.h"
#import "BBQTeacherInvitePageViewController.h"

@interface BBQInviteManageViewController ()
//当前选中button
@property(strong, nonatomic) UIButton *currentBtn;
//滑动红线
@property(weak, nonatomic) IBOutlet UIImageView *redLineImageView;
// PageVcl
@property(strong, nonatomic) BBQTeacherInvitePageViewController *dynamicPageVcl;

@end

@implementation BBQInviteManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = (UIButton *)[self.view viewWithTag:10];
    button.selected = YES;
    [button.titleLabel setFont:[UIFont systemFontOfSize:17]];
    self.currentBtn = button;
}

//上方选择按钮
- (IBAction)selsctBtnClick:(UIButton *)sender {
    
    for (int i = 0; i < 3; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:10 + i];
        btn.selected = NO;
        [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    }
    
    sender.selected = YES;
    self.currentBtn = sender;
    [UIView animateWithDuration:0.15
                     animations:^{
                         
                         [sender.titleLabel setFont:[UIFont systemFontOfSize:17]];
                     }];
    
    [self popRedLine];
    //自动滑动下面的pageVcl
   [self.dynamicPageVcl MovetoPageOfIndex:sender.tag - 10];
}
- (void)popRedLine {
    
    CGRect frame = _redLineImageView.frame;
    frame.origin.x = _currentBtn.frame.origin.x;
    
    [UIView animateWithDuration:0.3
                          delay:0
         usingSpringWithDamping:0.9
          initialSpringVelocity:0.7
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         self.redLineImageView.frame = frame;
                     }
                     completion:^(BOOL finished) {
                         nil;
                     }];
}
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.dynamicPageVcl =
    (BBQTeacherInvitePageViewController *)segue.destinationViewController;
    
    // pageVcl传值改变选定按钮
    WS(weakSelf)
    self.dynamicPageVcl.block = ^(NSInteger index) {
        for (int i = 0; i < 3; i++) {
            UIButton *btn = (UIButton *)[weakSelf.view viewWithTag:10 + i];
            btn.selected = NO;
            [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        }
        
        UIButton *button = (UIButton *)[weakSelf.view viewWithTag:10 + index];
        button.selected = YES;
        [UIView animateWithDuration:0
                         animations:^{
                             
                             [button.titleLabel setFont:[UIFont systemFontOfSize:17]];
                         }];
        weakSelf.currentBtn = button;
        
       [weakSelf popRedLine];
    };
}

@end
