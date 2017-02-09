//
//  BBQSpinnerView.h
//  BBQ
//
//  Created by 朱琨 on 15/12/23.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBQSpinnerView : UIView

@property (nonatomic, readonly) CAShapeLayer *circleLayer;
@property (nonatomic) BOOL isAnimating;

/*!
 * Force the start of the animation. When an app is closed the animatin is stopped but `isAnimating` is still at `YES`.
 */
- (void)forceBeginRefreshing;

/*!
 * Start the animation if `isAnimating` is at `NO`
 */
- (void)beginRefreshing;

/*!
 * Stop the animation
 */
- (void)endRefreshing;


@end
