//
//  BBQIntroductionViewController.m
//  BBQ
//
//  Created by 朱琨 on 15/10/26.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQIntroductionViewController.h"
#import "SMPageControl.h"
#import <NYXImagesKit/NYXImagesKit.h>

#import "LoginViewController.h"
#import "RegistViewController.h"
#import "BBQNewLoginViewController.h"

#import <Masonry.h>
#import "WelcomeVcl4.h"

@interface BBQIntroductionViewController ()

@property(strong, nonatomic) UIButton *registerBtn, *loginBtn;
@property(strong, nonatomic) SMPageControl *pageControl;
@property(strong, nonatomic) NSMutableDictionary *iconsDict, *tipsDict, *bgDict;

@end

@implementation BBQIntroductionViewController

- (instancetype)init {
  self = [super init];
  if (self) {
    self.numberOfPages = 4;

    _iconsDict = [@{
      @"0_image" : @"intro_icon_0",
      @"1_image" : @"intro_icon_1",
      @"2_image" : @"intro_icon_2",
      @"3_image" : @"intro_icon_3",
    } mutableCopy];
    _tipsDict = [@{
      @"0_image" : @"intro_tip_0",
      @"1_image" : @"intro_tip_1",
      @"2_image" : @"intro_tip_2",
      @"3_image" : @"intro_tip_3",
    } mutableCopy];
    _bgDict = [@{
      @"0_image" : @"intro_bg_0",
      @"1_image" : @"intro_bg_1",
      @"2_image" : @"intro_bg_2",
      @"3_image" : @"intro_bg_3",
    } mutableCopy];
  }
  return self;
}

- (NSString *)imageKeyForIndex:(NSInteger)index {
  return [NSString stringWithFormat:@"%ld_image", (long)index];
}

- (NSString *)viewKeyForIndex:(NSInteger)index {
  return [NSString stringWithFormat:@"%ld_view", (long)index];
}

#pragma mark - Life Cycle
- (void)viewDidLoad {
  [super viewDidLoad];
  [self configureViews];
  [self configureAnimations];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault
                                              animated:YES];
}

#pragma mark Super
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self animateCurrentFrame];
    NSInteger nearestPage = floorf(self.pageOffset + 0.5);
    self.pageControl.currentPage = nearestPage;
   
    if (nearestPage==3 ) {

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            WelcomeVcl4 *vc = [WelcomeVcl4 new];
            [self presentViewController:vc animated:YES completion:nil];
        });
    }
}


#pragma Views
- (void)configureViews {
//  [self configureButtonsAndPageControl];

    [self addSMPagecontrol];
    
  CGFloat scaleFactor = 1.0;
  CGFloat desginHeight = 667.0; // iPhone6 的设计尺寸
  if (!kDevice_Is_iPhone6 && !kDevice_Is_iPhone6Plus) {
    scaleFactor = kScreen_Height / desginHeight;
  }

  for (int i = 0; i < self.numberOfPages; i++) {
    NSString *imageKey = [self imageKeyForIndex:i];
    NSString *viewKey = [self viewKeyForIndex:i];
    NSString *iconImageName = [self.iconsDict objectForKey:imageKey];
    NSString *tipImageName = [self.tipsDict objectForKey:imageKey];
    NSString *bgImageName = self.bgDict[imageKey];

    if (iconImageName) {
      UIImage *iconImage = [UIImage imageNamed:iconImageName];
      if (iconImage) {
        iconImage = scaleFactor != 1.0 ? [iconImage scaleByFactor:scaleFactor]
                                       : iconImage;
        UIImageView *iconView = [[UIImageView alloc] initWithImage:iconImage];
        iconView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:iconView];
        [self.iconsDict setObject:iconView forKey:viewKey];
      }
    }

    if (tipImageName) {
      UIImage *tipImage = [UIImage imageNamed:tipImageName];
      if (tipImage) {
        tipImage = scaleFactor != 1.0 ? [tipImage scaleByFactor:scaleFactor]
                                      : tipImage;
        UIImageView *tipView = [[UIImageView alloc] initWithImage:tipImage];
        tipView.tintColor = [UIColor redColor];
        [self.contentView addSubview:tipView];
        [self.tipsDict setObject:tipView forKey:viewKey];
      }
    }

    if (bgImageName) {
      UIImage *bgImage = [UIImage imageNamed:bgImageName];
      if (bgImage) {
        bgImage =
            scaleFactor != 1.0 ? [bgImage scaleByFactor:scaleFactor] : bgImage;
        UIImageView *bgView = [[UIImageView alloc] initWithImage:bgImage];
        bgView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:bgView];
        [self.contentView sendSubviewToBack:bgView];
        [self.bgDict setObject:bgView forKey:viewKey];
      }
    }
  }
}

//- (void)configureButtonsAndPageControl {
//  //    Button
//  UIColor *darkColor = [UIColor colorWithHexString:@"ff6440"];
//  CGFloat buttonWidth = kScreen_Width * 0.4;
//  CGFloat buttonHeight = kScaleFrom_iPhone5_Desgin(38);
//  CGFloat paddingToCenter = kScaleFrom_iPhone5_Desgin(10);
//  CGFloat paddingToBottom = kScaleFrom_iPhone5_Desgin(20);
//
//  self.registerBtn = ({
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button addTarget:self
//                  action:@selector(registerBtnClicked)
//        forControlEvents:UIControlEventTouchUpInside];
//
//    button.backgroundColor = darkColor;
//    button.titleLabel.font = [UIFont boldSystemFontOfSize:20];
//    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [button setTitle:@"注册" forState:UIControlStateNormal];
//
//    button.layer.masksToBounds = YES;
//    button.layer.cornerRadius = buttonHeight / 2;
//    button;
//  });
//  self.loginBtn = ({
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button addTarget:self
//                  action:@selector(loginBtnClicked)
//        forControlEvents:UIControlEventTouchUpInside];
//
//    button.backgroundColor = darkColor;
//    button.titleLabel.font = [UIFont boldSystemFontOfSize:20];
//    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [button setTitle:@"登录" forState:UIControlStateNormal];
//
//    button.layer.masksToBounds = YES;
//    button.layer.cornerRadius = buttonHeight / 2;
//    button;
//  });
//
//  [self.view addSubview:self.registerBtn];
//  [self.view addSubview:self.loginBtn];
//
//  [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//    make.size.mas_equalTo(CGSizeMake(buttonWidth, buttonHeight));
//    make.right.equalTo(self.view.mas_centerX).offset(-paddingToCenter);
//    make.bottom.equalTo(self.view).offset(-paddingToBottom);
//  }];
//  [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//    make.size.mas_equalTo(CGSizeMake(buttonWidth, buttonHeight));
//    make.left.equalTo(self.view.mas_centerX).offset(paddingToCenter);
//    make.bottom.equalTo(self.view).offset(-paddingToBottom);
//  }];
//
//
//}

//添加pageControl
-(void)addSMPagecontrol{

    //    PageControl
    UIImage *pageIndicatorImage = [UIImage imageNamed:@"intro_dot_unselected"];
    UIImage *currentPageIndicatorImage =
    [UIImage imageNamed:@"intro_dot_selected"];
    
    if (!kDevice_Is_iPhone6 && !kDevice_Is_iPhone6Plus) {
        CGFloat desginWidth = 375.0; // iPhone6 的设计尺寸
        CGFloat scaleFactor = kScreen_Width / desginWidth;
        pageIndicatorImage = [pageIndicatorImage scaleByFactor:scaleFactor];
        currentPageIndicatorImage =
        [currentPageIndicatorImage scaleByFactor:scaleFactor];
    }
    
    self.pageControl = ({
        SMPageControl *pageControl = [[SMPageControl alloc] init];
        pageControl.numberOfPages = self.numberOfPages;
        pageControl.userInteractionEnabled = NO;
        pageControl.pageIndicatorImage = pageIndicatorImage;
        pageControl.currentPageIndicatorImage = currentPageIndicatorImage;
        [pageControl sizeToFit];
        pageControl.currentPage = 0;
        pageControl;
    });
    
    [self.view addSubview:self.pageControl];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(
                              CGSizeMake(kScreen_Width, kScaleFrom_iPhone5_Desgin(20)));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view)
        .offset(-kScaleFrom_iPhone5_Desgin(28));
    }];
}


#pragma mark Animations
- (void)configureAnimations {
  [self configureTipAndTitleViewAnimations];
}

- (void)configureTipAndTitleViewAnimations {
  for (int index = 0; index < self.numberOfPages; index++) {
    NSString *viewKey = [self viewKeyForIndex:index];
    UIView *iconView = [self.iconsDict objectForKey:viewKey];
    UIView *tipView = [self.tipsDict objectForKey:viewKey];
    UIView *bgView = self.bgDict[viewKey];
    if (iconView) {
      [self keepView:iconView
             onPages:@[ @(index + 1), @(index) ]
             atTimes:@[ @(index - 1), @(index) ]];

      [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kScreen_Height / 7);
        make.height.equalTo(kScreen_Height / 3);
      }];
      //            if (index == 0) {
      //                [self keepView:iconView onPages:@[@(index +1), @(index)]
      //                atTimes:@[@(index - 1), @(index)]];
      //
      //                [iconView mas_makeConstraints:^(MASConstraintMaker
      //                *make) {
      //                    make.top.mas_equalTo(kScreen_Height/7);
      //                }];
      //            }else{
      //                [self keepView:iconView onPage:index];
      //
      //                [iconView mas_makeConstraints:^(MASConstraintMaker
      //                *make) {
      //                    make.centerY.mas_equalTo(-kScreen_Height/6);
      //                }];
      //            }
      IFTTTAlphaAnimation *iconAlphaAnimation =
          [IFTTTAlphaAnimation animationWithView:iconView];
      [iconAlphaAnimation addKeyframeForTime:index - 0.5 alpha:0.f];
      [iconAlphaAnimation addKeyframeForTime:index alpha:1.f];
      [iconAlphaAnimation addKeyframeForTime:index + 0.5 alpha:0.f];
      [self.animator addAnimation:iconAlphaAnimation];
    }
    if (tipView) {
      [self keepView:tipView
             onPages:@[ @(index + 1), @(index), @(index - 1) ]
             atTimes:@[ @(index - 1), @(index), @(index + 1) ]];

      IFTTTAlphaAnimation *tipAlphaAnimation =
          [IFTTTAlphaAnimation animationWithView:tipView];
      [tipAlphaAnimation addKeyframeForTime:index - 0.5 alpha:0.f];
      [tipAlphaAnimation addKeyframeForTime:index alpha:1.f];
      [tipAlphaAnimation addKeyframeForTime:index + 0.5 alpha:0.f];
      [self.animator addAnimation:tipAlphaAnimation];

      [tipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconView.mas_bottom)
            .offset(kScaleFrom_iPhone5_Desgin(45));
      }];
    }

    if (bgView) {
      //            [self keepView:bgView onPages:@[@(index +1), @(index),
      //            @(index-1)] atTimes:@[@(index - 1), @(index), @(index +1)]];
      //            [self keepView:bgView onPages:@[@(index +1), @(index)]
      //            atTimes:@[@(index - 1), @(index)]];
      [self keepView:bgView onPages:@[ @(index) ] atTimes:@[ @(index) ]];
      //            IFTTTAlphaAnimation *bgAlphaAnimation = [IFTTTAlphaAnimation
      //            animationWithView:bgView];
      //            [bgAlphaAnimation addKeyframeForTime:index -0.5 alpha:0.f];
      //            [bgAlphaAnimation addKeyframeForTime:index alpha:1.f];
      //            [bgAlphaAnimation addKeyframeForTime:index +0.5 alpha:0.f];
      //            [self.animator addAnimation:bgAlphaAnimation];

      [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.view);
        make.centerY.equalTo(self.view);
      }];
    }
  }
}

#pragma mark Action
- (void)registerBtnClicked {
  UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
  RegistViewController *vc =
      [sb instantiateViewControllerWithIdentifier:@"RegisterVC"];
  UINavigationController *nav =
      [[UINavigationController alloc] initWithRootViewController:vc];
  [self presentViewController:nav animated:YES completion:nil];
}

- (void)loginBtnClicked {
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

@end
