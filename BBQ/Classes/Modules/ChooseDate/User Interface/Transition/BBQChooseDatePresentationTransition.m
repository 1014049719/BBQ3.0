//
//  BBQChooseDatePresentationTransition.m
//  BBQ
//
//  Created by 朱琨 on 15/10/19.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQChooseDatePresentationTransition.h"
#import "BBQChooseDateViewController.h"

@implementation BBQChooseDatePresentationTransition

- (NSTimeInterval)transitionDuration:
    (id<UIViewControllerContextTransitioning>)transitionContext {
  return 0.3;
}

- (void)animateTransition:
    (id<UIViewControllerContextTransitioning>)transitionContext {
  UIViewController *fromVC = [transitionContext
      viewControllerForKey:UITransitionContextFromViewControllerKey];
  BBQChooseDateViewController *toVC = [transitionContext
      viewControllerForKey:UITransitionContextToViewControllerKey];

  UIView *blurView = [[UIView alloc]
      initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
  blurView.backgroundColor = [UIColor blackColor];
  blurView.alpha = 0;
  toVC.transitioningBackgroundView = blurView;

  UIView *containerView = [transitionContext containerView];
  [containerView addSubview:fromVC.view];
  [containerView addSubview:blurView];
  [containerView addSubview:toVC.view];

  CGRect toViewFrame =
      CGRectMake(0.0f, 0.0f, kScreenWidth - 30, kScreenHeight * 0.6);
  toVC.view.frame = toViewFrame;

  //    CGPoint finalCenter = CGPointMake(fromVC.view.bounds.size.width / 2,
  //    20.0f + toViewFrame.size.height / 2);
  CGPoint finalCenter = fromVC.view.center;
  toVC.view.center = CGPointMake(finalCenter.x, finalCenter.y - 1000.0f);

  [UIView animateWithDuration:[self transitionDuration:transitionContext]
      animations:^{
        toVC.view.center = finalCenter;
        blurView.alpha = 0.5f;
      }
      completion:^(BOOL finished) {
        toVC.view.center = finalCenter;
        [transitionContext completeTransition:YES];
      }];

  //    [UIView
  //     animateWithDuration:[self transitionDuration:transitionContext]
  //     delay:0.0f
  //     usingSpringWithDamping:1.0f
  //     initialSpringVelocity:0.5f
  //     options:UIViewAnimationOptionCurveLinear |
  //     UIViewAnimationOptionAllowAnimatedContent
  //     animations:^{
  //
  //     } completion:^(BOOL finished) {
  //
  //     }];
}

@end
