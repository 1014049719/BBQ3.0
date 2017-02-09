//
//  BBQDynamicTableViewController.h
//  BBQ
//
//  Created by 朱琨 on 15/11/23.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQTableViewController.h"
#import "BBQDynamicViewModel.h"

@interface BBQDynamicTableViewController : BBQTableViewController

- (instancetype)initWithViewModel:(BBQDynamicViewModel *)viewModel;
#ifdef TARGET_MASTER
+ (instancetype)viewControllerForMasterTab;
#endif

@end
