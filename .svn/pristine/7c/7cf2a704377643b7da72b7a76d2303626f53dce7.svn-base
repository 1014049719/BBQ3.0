//
//  BBQLoadingView.m
//  BBQ
//
//  Created by 朱琨 on 15/12/23.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQLoadingView.h"
#import "BBQSpinnerView.h"

@interface BBQLoadingView ()

@property (weak, nonatomic) IBOutlet BBQSpinnerView *spinner;

@end

@implementation BBQLoadingView

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview) {
        [_spinner beginRefreshing];
    } else {
        [_spinner endRefreshing];
    }
}



@end
