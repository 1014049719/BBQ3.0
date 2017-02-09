//
//  LoadingView.h
//  BBQ
//
//  Created by 朱琨 on 15/9/2.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BBQLoadingViewStatus) {
    BBQLoadingViewStatusLoading,
    BBQLoadingViewStatusNoContent,
    BBQLoadingViewStatusError,
};

typedef void(^BBQLoadButtonBlock)(void);

@interface LoadingView : UIView

@property (copy, nonatomic) BBQLoadButtonBlock buttonBlock;
@property (assign, nonatomic) BBQLoadingViewStatus status;
@property (assign, nonatomic) BOOL isShowing;

- (void)dismiss;
@end
