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

@property (strong, nonatomic) BBQChooseStatusViewController *chooseStatusViewController;
@property (strong, nonatomic) BBQChooseStatusPresenter *presenter;
@property (strong, nonatomic) UINavigationController *presentedNC;

@end

static NSString * const kChooseStatusViewControllerIdentifier = @"ChooseStatusVC";

@implementation BBQChooseStatusWireframe

- (void)presentChooseStatusControllerFromWindow:(UIWindow *)window {
    UINavigationController* nc = [UINavigationController new];
    window.rootViewController = nc;
    [self presentChooseStatusControllerFromNavigationController:nc];
}

- (void)presentChooseStatusControllerFromNavigationController:(UINavigationController *)nc {
    BBQChooseStatusViewController *vc = [self chooseStatusViewController];
    BBQChooseStatusInteractor *interactor = [BBQChooseStatusInteractor new];
    BBQChooseStatusPresenter *presenter = [BBQChooseStatusPresenter new];
    
    vc.eventHandler = presenter;
    
    presenter.interactor = interactor;
    presenter.wireframe = self;
    
    interactor.output = presenter;
    
    self.presentedNC = nc;
}

- (BBQChooseStatusViewController *)chooseStatusViewControllerFromStoryboard {
    UIStoryboard *sb = [self mainStoryboard];
    return [sb instantiateViewControllerWithIdentifier:kChooseStatusViewControllerIdentifier];
}

- (UIStoryboard *)mainStoryboard {
    return [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
}

- (void)presentChooseStatusControllerFromViewController:(UIViewController *)viewController {
    
}

- (void)presentEditWordsController {
    
}

@end
