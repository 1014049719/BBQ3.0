//
//  BBQChooseDateViewController.h
//  BBQ
//
//  Created by 朱琨 on 15/10/19.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BBQDidSelectDateBlock)(NSDate *date);

@interface BBQChooseDateViewController : BBQBaseViewController

@property (copy, nonatomic) BBQDidSelectDateBlock block;
@property (nonatomic, strong) UIView *transitioningBackgroundView;
@property (strong, nonatomic) UIViewController *vc;

@end
