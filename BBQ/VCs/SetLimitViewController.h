//
//  SetLimitViewController.h
//  BBQ
//
//  Created by wth on 15/7/28.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RelativeModel.h"


typedef void(^LimitCallback)(RelativeModel *);
@interface SetLimitViewController : BBQBaseViewController


@property (strong, nonatomic) RelativeModel *relativeModel;

@property (strong, nonatomic) LimitCallback block;

@end
