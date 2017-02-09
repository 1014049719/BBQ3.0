//
//  BBQBaseTableView.m
//  BBQ
//
//  Created by 朱琨 on 15/11/17.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQBaseTableView.h"

@implementation BBQBaseTableView

- (void)awakeFromNib {
    [self configureSelf];
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self configureSelf];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureSelf];
    }
    
    return self;
}

- (void)configureSelf {
    self.delaysContentTouches = NO;
    self.canCancelContentTouches = YES;
    self.backgroundColor = UIColorHex(f5f5f5);
    self.backgroundView.backgroundColor = UIColorHex(f5f5f5);
//    // Remove touch delay (since iOS 8)
//    UIView *wrapView = self.subviews.firstObject;
//    // UITableViewWrapperView
//    if (wrapView && [NSStringFromClass(wrapView.class) hasSuffix:@"WrapperView"]) {
//        for (UIGestureRecognizer *gesture in wrapView.gestureRecognizers) {
//            // UIScrollViewDelayedTouchesBeganGestureRecognizer
//            if ([NSStringFromClass(gesture.class) containsString:@"DelayedTouchesBegan"] ) {
//                gesture.enabled = NO;
//                break;
//            }
//        }
//    }
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    if ( [view isKindOfClass:[UIControl class]]) {
        return YES;
    }
    return [super touchesShouldCancelInContentView:view];
}

@end
