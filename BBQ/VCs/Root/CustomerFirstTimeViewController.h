//
//  CustomerFirstTimeViewController.h
//  BBQ
//
//  Created by wth on 15/8/30.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^firstTimeBlock)(NSString *);

@interface CustomerFirstTimeViewController : BBQBaseViewController

@property(copy,nonatomic)firstTimeBlock firstTimeblock;

@end
