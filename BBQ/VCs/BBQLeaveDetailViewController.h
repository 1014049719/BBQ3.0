//
//  BBQLeaveDetailViewController.h
//  BBQ
//
//  Created by slovelys on 15/12/3.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^leaveDetailBlock)(BOOL isDeleteLeave);

@interface BBQLeaveDetailViewController : BBQBaseViewController

@property (assign, nonatomic) int sid;

@property (copy, nonatomic) leaveDetailBlock block;

@end
