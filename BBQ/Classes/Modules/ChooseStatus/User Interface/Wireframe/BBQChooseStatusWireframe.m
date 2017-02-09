//
//  BBQChooseStatusWireframe.m
//  DailyReportDemo
//
//  Created by 朱琨 on 15/10/8.
//  Copyright © 2015年 gzxlt. All rights reserved.
//

#import "BBQChooseStatusWireframe.h"
#import "BBQChooseStatusViewController.h"
#import "BBQChooseStatusInteractor.h"
#import "BBQChooseStatusPresenter.h"

@interface BBQChooseStatusWireframe ()

@property(strong, nonatomic)
    BBQChooseStatusViewController *chooseStatusViewController;
@property(strong, nonatomic) BBQChooseStatusPresenter *presenter;
@property(strong, nonatomic) UINavigationController *presentedNC;

@end

static NSString *const kChooseStatusViewControllerIdentifier =
    @"ChooseStatusVC";

@implementation BBQChooseStatusWireframe

- (void)presentChooseStatusControllerFromWindow:(UIWindow *)window {
  UINavigationController *nc = [UINavigationController new];
  window.rootViewController = nc;
  [self presentChooseStatusControllerFromNavigationController:nc];
}

- (void)presentChooseStatusControllerFromNavigationController:
    (UINavigationController *)nc {
  BBQChooseStatusViewController *vc =
      [self chooseStatusViewControllerFromStoryboard];

  vc.flag = self.flag;
  vc.classuid = self.classuid;

  BBQChooseStatusInteractor *interactor = [BBQChooseStatusInteractor new];
  BBQChooseStatusPresenter *presenter = [BBQChooseStatusPresenter new];

  vc.eventHandler = presenter;

  presenter.interactor = interactor;
  presenter.wireframe = self;

  interactor.output = presenter;

  self.presentedNC = nc;

  [nc pushViewController:vc animated:YES];
}

- (BBQChooseStatusViewController *)chooseStatusViewControllerFromStoryboard {
  UIStoryboard *sb = [self dailyReportStoryboard];
  return [sb instantiateViewControllerWithIdentifier:
                 kChooseStatusViewControllerIdentifier];
}

- (UIStoryboard *)dailyReportStoryboard {
  return [UIStoryboard storyboardWithName:@"DailyReport"
                                   bundle:[NSBundle mainBundle]];
}

- (void)presentChooseStatusControllerFromViewController:
    (UIViewController *)viewController {
}

- (void)presentEditWordsController {
}

@end
