//
//  HelpViewController.m
//  BBQ
//
//  Created by wth on 15/8/4.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "HelpViewController.h"
#import "helpPageViewController.h"
#import "MenuView.h"

@interface HelpViewController () <MenuViewDelegate>

//当前选中button
@property(strong, nonatomic) UIButton *currentBtn;
//滑动红线
@property(weak, nonatomic) IBOutlet UIImageView *redLineImageView;

@property(weak, nonatomic) IBOutlet UIView *TopNavBarView;

@property(strong, nonatomic) MenuView *menuView;

// PageVcl
@property(strong, nonatomic) helpPageViewController *PageVcl;

//顶部按钮数组
@property(strong, nonatomic) NSArray *topBtnArr;

@end

@implementation HelpViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.

  WS(weakSelf)
  self.PageVcl.getTopArrblock = ^(NSArray *Arr) {

    weakSelf.topBtnArr = Arr;

    //创建顶部按钮
    [weakSelf setTopNavBar];
  };
}

- (void)setTopNavBar {

  self.menuView = [[MenuView alloc] initWithMneuViewStyle:MenuViewStyleLine
                                                AndTitles:self.topBtnArr];
  self.menuView.delegate = self;
  self.menuView.frame =
      CGRectMake(0, 0, kScreenWidth, CGRectGetHeight(self.TopNavBarView.frame));
  [self.TopNavBarView addSubview:self.menuView];
}

#pragma mark - 手势点击切换NavBar
- (void)MenuViewDelegate:(MenuView *)menuview WithIndex:(NSInteger)index {

  NSLog(@"点击了。。。。。。%ld", (long)index);
  //自动滑动下面的pageVcl
  [self.PageVcl moveToPageOfIndex:index];
}

//上方选择按钮
//- (IBAction)selsctBtnClick:(UIButton *)sender {
//
//    for (int i=0; i<4; i++) {
//        UIButton *btn=(UIButton *)[self.view viewWithTag:10+i];
//        btn.selected=NO;
//    }
//
//    sender.selected=YES;
//    self.currentBtn=sender;
//
//    [self popRedLine];
//
//    //自动滑动下面的pageVcl
//    [self.PageVcl moveToPageOfIndex:sender.tag-10];
//    NSLog(@"%ld",(long)sender.tag);
//}
//-(void)popRedLine{
//
//    CGRect frame=_redLineImageView.frame;
//    frame.origin.x=_currentBtn.frame.origin.x;
//
//    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.65
//    initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseOut
//    animations:^{
//
//        self.redLineImageView.frame=frame;
//    } completion:^(BOOL finished) {
//        nil;
//    }];
//
//}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

  self.PageVcl = (helpPageViewController *)segue.destinationViewController;

  WS(weakSelf)
  self.PageVcl.block = ^(NSInteger idx, CGFloat offset) {
    [weakSelf.menuView SelectedBtnMoveToCenterWithIndex:idx WithRate:offset];
  };
}

@end
