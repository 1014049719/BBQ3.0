//
//  BlurView.h
//  BBQ
//
//  Created by anymuse on 15/7/23.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BlurViewBlock)();
@interface BlurView : UIView

@property (strong, nonatomic) BlurViewBlock touchBlock;

+ (instancetype)sharedInstance;
- (void)showBlurView;
- (void)hideBlurView;
- (void)hideBlurViewImmediately;
- (void)showTransparencyViewInView:(UIView *)view;

@end
