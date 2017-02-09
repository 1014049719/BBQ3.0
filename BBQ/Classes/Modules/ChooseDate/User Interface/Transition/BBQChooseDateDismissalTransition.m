//
//  BBQChooseDateDismissalTransition.m
//  BBQ
//
//  Created by 朱琨 on 15/10/19.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQChooseDateDismissalTransition.h"
#import "BBQChooseDateViewController.h"

@implementation BBQChooseDateDismissalTransition

- (NSTimeInterval)transitionDuration:
    (id<UIViewControllerContextTransitioning>)transitionContext {
  return 0.5;
}

- (void)animateTransition:
    (id<UIViewControllerContextTransitioning>)transitionContext {
  BBQChooseDateViewController *fromVC = [transitionContext
      viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIViewController *toVC = [transitionContext
      viewControllerForKey:UITransitionContextToViewControllerKey];

  CGPoint finalCenter =
      CGPointMake(160.0f, (fromVC.view.bounds.size.height / 2) - 1000.0f);

  [UIView animateWithDuration:[self transitionDuration:transitionContext]
      animations:^{
        fromVC.view.center = finalCenter;
        fromVC.transitioningBackgroundView.alpha = 0.0f;
      }
      completion:^(BOOL finished) {
        [fromVC.view removeFromSuperview];
        [transitionContext completeTransition:YES];
        [[UIApplication sharedApplication].keyWindow addSubview:toVC.view];
      }];
  //
  //
  //    [UIView
  //     animateWithDuration:[self transitionDuration:transitionContext]
  //     delay:0.0f
  //     usingSpringWithDamping:0.64f
  //     initialSpringVelocity:0.22f
  //     options:UIViewAnimationOptionCurveEaseIn |
  //     UIViewAnimationOptionAllowAnimatedContent
  //     animations:^{
  //         fromVC.view.center = finalCenter;
  //         fromVC.transitioningBackgroundView.alpha = 0.0f;
  //     } completion:^(BOOL finished) {
  //         [fromVC.view removeFromSuperview];
  //         [transitionContext completeTransition:YES];
  //         [[UIApplication sharedApplication].keyWindow addSubview:toVC.view];
  //     }];
}

@end
