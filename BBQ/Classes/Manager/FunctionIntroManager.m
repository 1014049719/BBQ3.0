//
//  FunctionIntroManager.m
//  Coding_iOS
//
//  Created by Ease on 15/8/6.
//  Copyright (c) 2015年 Coding. All rights reserved.
//

#define kIntroPageKey @"intro_page_version"
#define kIntroPageNum 3

#import "FunctionIntroManager.h"
#import "EAIntroView.h"
#import "SMPageControl.h"
#import <NYXImagesKit/NYXImagesKit.h>
#import <MYBlurIntroductionView.h>
#import "WelcomeVcl4.h"
#import <Masonry.h>

@implementation FunctionIntroManager
#pragma mark EAIntroPage

+ (void)showIntroPage {
  if (![self needToShowIntro]) {
    return;
  }
  //    NSMutableArray *pages = [NSMutableArray new];
  //    for (int index = 0; index < kIntroPageNum; index ++) {
  //        EAIntroPage *page = [self p_pageWithIndex:index];
  //        [pages addObject:page];
  //    }
  //    if (pages.count <= 0) {
  //        return;
  //    }
  //    EAIntroView *introView = [[EAIntroView alloc]
  //    initWithFrame:kScreen_Bounds andPages:pages];
  //    introView.backgroundColor = [UIColor whiteColor];
  //    introView.swipeToExit = YES;
  //    introView.scrollView.bounces = YES;

  //    introView.skipButton = [self p_skipButton];
  //    introView.skipButtonY = 20.f +
  //    CGRectGetHeight(introView.skipButton.frame);
  //    introView.skipButtonAlignment = EAViewAlignmentCenter;

  //    if (pages.count <= 1) {
  //        introView.pageControl.hidden = YES;
  //    }else{
  //        introView.pageControl = [self p_pageControl];
  //        introView.pageControlY = 10.f +
  //        CGRectGetHeight(introView.pageControl.frame);
  //    }
  //    [introView showFullscreen];
  [self showIntro];
  [self markHasBeenShowed];
}

+ (BOOL)needToShowIntro {
  //    return YES;
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSString *preVersion = [defaults stringForKey:kIntroPageKey];
  BOOL needToShow = ![preVersion isEqualToString:kVersion];
  return needToShow;
}

+ (void)markHasBeenShowed {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setValue:kVersion forKey:kIntroPageKey];
  [defaults synchronize];
}

#pragma mark private M
+ (UIPageControl *)p_pageControl {
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

  SMPageControl *pageControl = [SMPageControl new];
  pageControl.pageIndicatorImage = pageIndicatorImage;
  pageControl.currentPageIndicatorImage = currentPageIndicatorImage;
  [pageControl sizeToFit];
  return (UIPageControl *)pageControl;
}

//+ (UIButton *)p_skipButton{
//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,
//    kScreen_Width*0.7, 60)];
//    button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
//    [button setTitle:@"立即体验" forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor colorWithHexStringString:@"0x3bbd79"]
//    forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor colorWithHexStringString:@"0x1b9d59"]
//    forState:UIControlStateHighlighted];
//    return button;
//}
//
//+ (EAIntroPage *)p_pageWithIndex:(NSInteger)index{
//    NSString *imageName = [NSString stringWithFormat:@"intro_page%ld",
//    (long)index];
//    if (kDevice_Is_iPhone6Plus) {
//        imageName = [imageName stringByAppendingString:@"_ip6+"];
//    }else if (kDevice_Is_iPhone6){
//        imageName = [imageName stringByAppendingString:@"_ip6"];
//    }else if (kDevice_Is_iPhone5){
//        imageName = [imageName stringByAppendingString:@"_ip5"];
//    }else{
//        imageName = [imageName stringByAppendingString:@"_ip4"];
//    }
//    UIImage *image = [UIImage imageNamed:imageName];
//    UIImageView *imageView;
//    if (!image) {
//        imageView = [UIImageView new];
//        imageView.backgroundColor = [UIColor randomColor];
//    }else{
//        imageView = [[UIImageView alloc] initWithImage:image];
//    }
//    imageView.contentMode = UIViewContentModeScaleAspectFill;
//    imageView.clipsToBounds = YES;
//    EAIntroPage *page = [EAIntroPage pageWithCustomView:imageView];
//    return page;
//}

+ (void)showIntro {
  UIWindow *window = [UIApplication sharedApplication].keyWindow;
#ifdef TARGET_PARENT
//  WelcomeVcl4 *vc = [WelcomeVcl4 new];
//  [window.rootViewController addChildViewController:vc];
//  [window.rootViewController.view addSubview:vc.view];
//  [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
//    make.edges.equalTo(window.rootViewController.view);
//  }];
#elif TARGET_TEACHER
    
    MYIntroductionPanel *panel1 =
    [[MYIntroductionPanel alloc] initWithFrame:kScreen_Bounds
                                      nibNamed:@"WelcomePage1"];
    MYIntroductionPanel *panel2 =
    [[MYIntroductionPanel alloc] initWithFrame:kScreen_Bounds
                                      nibNamed:@"WelcomePage2"];
    MYIntroductionPanel *panel3 =
    [[MYIntroductionPanel alloc] initWithFrame:kScreen_Bounds
                                      nibNamed:@"WelcomePage3"];
    
    NSArray *panels = @[panel1, panel2, panel3 ];
    
    MYBlurIntroductionView *introductionView =
    [[MYBlurIntroductionView alloc] initWithFrame:kScreen_Bounds];
    //    introductionView.delegate = self;
    
    // introductionView.LanguageDirection = MYLanguageDirectionRightToLeft;
    
    // Build the introduction with desired panels
    [introductionView buildIntroductionWithPanels:panels];
    
    // Add the introduction to your view
    //    [self.view addSubview:introductionView];
    
    if (introductionView.superview != window) {
        [window addSubview:introductionView];
    } else {
        [window bringSubviewToFront:introductionView];
    }
#elif TARGET_MASTER
    MYIntroductionPanel *panel1 =
      [[MYIntroductionPanel alloc] initWithFrame:kScreen_Bounds
                                        nibNamed:@"WelcomePage1"];
  MYIntroductionPanel *panel2 =
      [[MYIntroductionPanel alloc] initWithFrame:kScreen_Bounds
                                        nibNamed:@"WelcomePage_Master2"];
  MYIntroductionPanel *panel3 =
      [[MYIntroductionPanel alloc] initWithFrame:kScreen_Bounds
                                        nibNamed:@"WelcomePage_Master3"];
    
    NSArray *panels = @[panel1, panel2, panel3 ];
    
    MYBlurIntroductionView *introductionView =
    [[MYBlurIntroductionView alloc] initWithFrame:kScreen_Bounds];
    //    introductionView.delegate = self;
    
    // introductionView.LanguageDirection = MYLanguageDirectionRightToLeft;
    
    // Build the introduction with desired panels
    [introductionView buildIntroductionWithPanels:panels];
    
    // Add the introduction to your view
    //    [self.view addSubview:introductionView];
    
    if (introductionView.superview != window) {
        [window addSubview:introductionView];
    } else {
        [window bringSubviewToFront:introductionView];
    }
#endif
 
 
    
}


+ (UIView *)windowView {
  UIView *selectedView;

  NSEnumerator *frontToBackWindows =
      [UIApplication.sharedApplication.windows reverseObjectEnumerator];
  for (UIWindow *window in frontToBackWindows) {
    BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
    BOOL windowIsVisible = !window.hidden && window.alpha > 0;
    BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;

    if (windowOnMainScreen && windowIsVisible && windowLevelNormal) {
      selectedView = window;
      break;
    }
  }
  return selectedView;
}

@end
