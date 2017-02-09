//
//  BabyRootViewController.m
//  JYEX
//
//  Created by anymuse on 15/7/16.
//  Copyright © 2015年 广州洋基. All rights reserved.
//

#import "AppDelegate.h"
#import "BabyNavBar.h"
#import "BabyPageViewController.h"
#import "BabyRootViewController.h"
#import "BabySideBar.h"
#import "GiftViewController.h"

#import "UploadViewController.h"
#import "MenuView.h"
#import "BBQIndicatorBar.h"
#import <MHBlurTutorialsViewController.h>
#import "ResetPassKeyTableViewController.h"
#import "babyDataResetViewController.h"
#import "userModifyTableViewController.h"
#include "DynamicCreateTableViewController.h"
#include "MessageViewController.h"
#import <Masonry.h>
#import "babyDatatShowViewController.h"
#import "userModifyTableViewController.h"
#import <UINavigationController+FDFullscreenPopGesture.h>
#import <UINavigationBar+Awesome.h>
#import <UIButton+YYWebImage.h>

@interface BabyRootViewController () <UIActionSheetDelegate, MenuViewDelegate>

@property(assign, nonatomic) BOOL isBabySideBarShowing;
@property(assign, nonatomic) CGFloat babySideBarWidth;
@property(strong, nonatomic) BabyPageViewController *pageVC;
@property(strong, nonatomic) BabySideBar *babySideBar;
@property(weak, nonatomic) IBOutlet UILabel *classNameLabel;
@property(weak, nonatomic) IBOutlet UILabel *schoolNameLabel;

@property(strong, nonatomic) NSArray *navBarLabels;
@property(strong, nonatomic) NSMutableArray *babyHeadImageViewArray;
@property(strong, nonatomic) UILabel *currentLabel;
@property(strong, nonatomic) UIView *babySideBarBlurView;
@property(strong, nonatomic) UIView *blurView;
@property(weak, nonatomic) IBOutlet BabyNavBar *babyNavBar;
@property(weak, nonatomic) IBOutlet UIButton *headButton;
@property(weak, nonatomic) IBOutlet UIButton *inviteButton;
@property(weak, nonatomic) IBOutlet UILabel *babyNameLabel;
@property(weak, nonatomic) IBOutlet UILabel *babyAgeLabel;
@property(strong, nonatomic) MenuView *menuView;

@property(weak, nonatomic) IBOutlet BBQIndicatorBar *indicatorBar;

@property(assign, nonatomic) int updategxflag;
@property(assign, nonatomic) int updatebaobaoflag;
@property(weak, nonatomic) IBOutlet NSLayoutConstraint *indicatorBarTopCons;

@end

@implementation BabyRootViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
  [super viewDidLoad];
  self.babySideBarWidth = kScreenWidth * 0.6;
  self.babyHeadImageViewArray = [NSMutableArray array];
  APPDelegate.babyHeadCenter = self.headButton.center;
  APPDelegate.inviteButton = self.inviteButton;

  UITapGestureRecognizer *nameTap = [[UITapGestureRecognizer alloc]
      initWithTarget:self
              action:@selector(checkCurrentBabyInfo)];
  [self.babyNameLabel addGestureRecognizer:nameTap];

  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(completeRelationship:)
             name:kNeedCompleteRelationship
           object:nil];

  self.headButton.layer.masksToBounds = YES;
  self.headButton.layer.borderWidth = 2;
  self.headButton.layer.borderColor = [UIColor whiteColor].CGColor;
  self.headButton.layer.cornerRadius =
      CGRectGetHeight(self.headButton.frame) / 2.0;

  self.indicatorBar.topCons = self.indicatorBarTopCons;
  self.indicatorBar.vc = self;
  [self setUpNavBar];
}

- (BOOL)fd_prefersNavigationBarHidden {
  return YES;
}

- (void)refreshInviteBtn {
  self.inviteButton.hidden = (TheCurBaoBao.qx == BBQAuthorityTypeNormal) ||
                             (TheCurBaoBao.qx == BBQAuthorityTypeUndefined);
}

- (void)viewWillAppear:(BOOL)animated {
  [self.navigationController setNavigationBarHidden:YES animated:animated];
  [super viewWillAppear:animated];
  [self refreshInviteBtn];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [self.babySideBar dismissSideBar];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self refreshEntireData];
}

- (void)completeRelationship:(NSNotification *)notification {
  NSDictionary *userInfo = notification.userInfo;
  userModifyTableViewController *vc = [self.storyboard
      instantiateViewControllerWithIdentifier:@"userModifyTabVcl"];
  vc.baobao = userInfo[@"data"];
  [self.navigationController pushViewController:vc animated:YES];
}

- (void)setUpNavBar {
  self.menuView = [[MenuView alloc] initWithMneuViewStyle:MenuViewStyleLine
                                                AndTitles:@[
                                                  @"宝宝",
                                                  @"班级",
                                                  @"幼儿园",
                                                  @"成长书",
                                                  @"亲友团",
                                                  @"成长报告"
                                                ]];
  self.menuView.delegate = self;
  self.menuView.frame = CGRectMake(65, 0, kScreenWidth - 65,
                                   CGRectGetHeight(self.babyNavBar.frame));
  [self.babyNavBar addSubview:self.menuView];
}

- (void)refreshEntireData {
  self.inviteButton.hidden = (TheCurBaoBao.qx == BBQAuthorityTypeNormal) ||
                             (TheCurBaoBao.qx == BBQAuthorityTypeUndefined);
  self.babyNameLabel.text = TheCurBaoBao.sRealname;
  if (TheCurBaoBao.birthyear == 0) {
    self.babyAgeLabel.text = nil;
  } else {
    self.babyAgeLabel.text = [CommonFunc getAgeWithYear:TheCurBaoBao.birthyear
                                                  month:TheCurBaoBao.birthmonth
                                                    day:TheCurBaoBao.birthday];
  }
  self.classNameLabel.text = TheCurBaoBao.strClassName;
  self.schoolNameLabel.text = TheCurBaoBao.strSchoolName;

  if ([TheCurBaoBao.avatar hasPrefix:@"http://"]) {
    [self.headButton
        setBackgroundImageWithURL:[NSURL URLWithString:TheCurBaoBao.avatar]
                  forState:UIControlStateNormal
               placeholder:[UIImage imageNamed:@"placeholder_panda"]
                   options:YYWebImageOptionSetImageWithFadeAnimation
                completion:^(UIImage *image, NSURL *url,
                             YYWebImageFromType from, YYWebImageStage stage,
                             NSError *error){

                }];
  } else {
    [self.headButton
        setImage:[UIImage imageWithContentsOfFile:TheCurBaoBao.avatar]
        forState:UIControlStateNormal];
  }
}

#pragma mark - 手势点击切换NavBar
- (void)MenuViewDelegate:(MenuView *)menuview WithIndex:(NSInteger)index {
  [self changeInfo:index];
  [self.pageVC moveToPageOfIndex:index];
}
#pragma mark - 修改Label显示信息
- (void)changeInfo:(NSInteger)index {
  if (index == 0 || index == 3 || index == 4 || index == 5) {
    self.babyAgeLabel.hidden = NO;
    self.babyNameLabel.hidden = NO;
    self.classNameLabel.hidden = YES;
    self.schoolNameLabel.hidden = YES;
  } else if (index == 1) {
    self.babyAgeLabel.hidden = YES;
    self.babyNameLabel.hidden = YES;
    self.classNameLabel.hidden = NO;
    self.schoolNameLabel.hidden = YES;
  } else if (index == 2) {
    self.babyAgeLabel.hidden = YES;
    self.babyNameLabel.hidden = YES;
    self.classNameLabel.hidden = YES;
    self.schoolNameLabel.hidden = NO;
  }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"BabyPageViewSegue"]) {
    self.pageVC = (BabyPageViewController *)segue.destinationViewController;
    self.pageVC.babyRootVC = self;
    self.pageVC.menuView = self.menuView;
    WS(weakSelf)
    self.pageVC.block = ^(NSInteger idx, CGFloat offset) {
      [weakSelf changeInfo:idx];
      [weakSelf.menuView SelectedBtnMoveToCenterWithIndex:idx WithRate:offset];
    };
  } else if ([segue.identifier isEqualToString:@"GiftSegue"]) {
    GiftViewController *gvc = segue.destinationViewController;
    gvc.guid = sender;
  } else if ([segue.identifier isEqualToString:@"BabyRootToBabyInfoSegue"]) {
    babyDatatShowViewController *vc = segue.destinationViewController;
    vc.baby = TheGlobal.m_arrBaobaoData[[sender integerValue]];
  }
}

#pragma mark - Select Baby
- (IBAction)didTapOnHead:(id)sender {
    [self performSegueWithIdentifier:@"pushToAttentionList"
                              sender:sender];
//  if (!self.babySideBar) {
//    self.babySideBar = [[BabySideBar alloc]
//        initWithFrame:CGRectMake(-self.babySideBarWidth,
//                                 CGRectGetMaxY(self.babyNavBar.frame),
//                                 self.babySideBarWidth,
//                                 kScreenHeight -
//                                     CGRectGetMaxY(self.babyNavBar.frame))];
//    WS(weakSelf)
//    self.babySideBar.willAnimateBlock = ^{
//      weakSelf.headButton.userInteractionEnabled = NO;
//    };
//    self.babySideBar.finishAnimationBlock = ^{
//      weakSelf.headButton.userInteractionEnabled = YES;
//    };
//    self.babySideBar.checkBabyBlock = ^(NSInteger index) {
//      [weakSelf performSegueWithIdentifier:@"BabyRootToBabyInfoSegue"
//                                    sender:@(index)];
//
//    };
//  }
//
//  if (self.babySideBar.isShowing) {
//    [self.babySideBar dismissSideBar];
//  } else {
//    [self.babySideBar showSideBar];
//  }
}

- (void)checkCurrentBabyInfo {
  [self performSegueWithIdentifier:@"BabyRootToBabyInfoSegue"
                            sender:@([TheGlobal.m_arrBaobaoData
                                       indexOfObject:TheCurBaoBao])];
}

@end
