//
//  WelcomeVcl4.m
//  BBQ
//
//  Created by wth on 15/10/18.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "WelcomeVcl4.h"
#import "BBQNewLoginViewController.h"
#import "LoginViewController.h"

@interface WelcomeVcl4 ()

//彩球
@property(weak, nonatomic) IBOutlet UIImageView *CaiqiuImageView;

//灰球
@property(weak, nonatomic) IBOutlet UIImageView *huiqiuImageview;

//文字
@property(weak, nonatomic) IBOutlet UIImageView *WenziImageView;

//进入
@property(weak, nonatomic) IBOutlet UIButton *JinruImageview;
@property(weak, nonatomic) IBOutlet NSLayoutConstraint *Layout_jinru_bottom;

//成长书封面
@property(weak, nonatomic) IBOutlet UIImageView *CZS_bookImageView;

@end

@implementation WelcomeVcl4

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.

  _CZS_bookImageView.alpha = 0;
  _huiqiuImageview.alpha = 0;
  _WenziImageView.alpha = 0;
  _JinruImageview.alpha = 0;

  CGRect Frame = _huiqiuImageview.frame;
  Frame.origin.x -= 50;
  Frame.size.width += 100;
  Frame.size.height += 100;
  _huiqiuImageview.alpha = 0;
  //    Frame=CGRectMake(100, 100, 100, 100);

  [UIView animateWithDuration:1
      animations:^{

        _huiqiuImageview.frame = Frame;
        _huiqiuImageview.alpha = 1;
      }
      completion:^(BOOL finished) {

          dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
              _huiqiuImageview.highlighted = YES;
          });
          //文字
          [self SetWenzi];
      }];
}

- (void)SetWenzi {

  _WenziImageView.alpha = 0;

  [UIView animateWithDuration:1.5
      animations:^{
        _WenziImageView.alpha = 1;
        //        _WenziImageView.frame=Frame;
      }
      completion:^(BOOL finished) {

          //进入
          //            [self SetJinru];
      }];
}

- (void)SetJinru {

  _JinruImageview.alpha = 0;
  CGRect Frame = _JinruImageview.frame;
  Frame.origin.y -= 78;

  [UIView animateWithDuration:1.5
      animations:^{
        _JinruImageview.alpha = 1;
        _JinruImageview.frame = Frame;
      }
      completion:^(BOOL finished){

      }];
}

- (void)updateViewConstraints {
  [super updateViewConstraints];

  //显示文字
  _JinruImageview.alpha = 1;
  self.Layout_jinru_bottom.constant = 35;

  [UIView animateWithDuration:1.5
      delay:1
      options:UIViewAnimationOptionLayoutSubviews
      animations:^{

        [_JinruImageview layoutIfNeeded];

      }
      completion:^(BOOL finished) {

        if (finished) {

          [UIView animateWithDuration:0.5
              delay:0
              options:UIViewAnimationOptionLayoutSubviews
              animations:^{

                _WenziImageView.alpha = 0;
                _CZS_bookImageView.alpha = 1;
              }
              completion:^(BOOL finished) {

                [self changeWenzi];
              }];
        }
      }];
}

- (void)changeWenzi {

  [UIView animateWithDuration:0.4
                   animations:^{

                     [_WenziImageView
                         setImage:[UIImage imageNamed:@"人生传记.png"]];
                     _WenziImageView.alpha = 1;
                   }];
}

//进入事件
- (IBAction)JinruBtnClick:(id)sender {

    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
#ifdef TARGET_PARENT
    BBQNewLoginViewController *vc =
    [sb instantiateViewControllerWithIdentifier:@"NewLoginVC"];
    UINavigationController *nav =
    [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
#else
    LoginViewController *vc =
    [sb instantiateViewControllerWithIdentifier:@"LoginMain"];
    //    vc.showDismissButton = YES;
    
    UINavigationController *nav =
    [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
#endif
    
}
- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
