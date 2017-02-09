//
//  HelpViewController.h
//  BBQ
//
//  Created by wth on 15/8/4.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DataSourceBlock)(NSArray *,NSInteger);

@interface HelpViewController : BBQBaseViewController

@property(copy,nonatomic)DataSourceBlock dataSourceBlock;

@end
