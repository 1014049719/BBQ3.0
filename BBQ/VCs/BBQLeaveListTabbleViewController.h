//
//  BBQLeaveListTabbleViewController.h
//  BBQ
//
//  Created by slovelys on 15/11/30.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQTableViewController.h"

@interface BBQLeaveListTabbleViewController : BBQTableViewController
/// json接收的数据，传给后台的参数
@property (strong, nonatomic) NSDictionary *params;

@end
