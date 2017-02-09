//
//  LeDouPayTableViewController.h
//  BBQ
//
//  Created by wth on 15/7/22.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^leDouBlock)(int no, int ledou);

@interface LeDouPayTableViewController : UITableViewController

@property(strong,nonatomic)leDouBlock block;

- (void)reloadCzdata:(NSArray *)schema_cztype;

//成长书开通状态
@property(assign,nonatomic)int czsState_Value;

@end
