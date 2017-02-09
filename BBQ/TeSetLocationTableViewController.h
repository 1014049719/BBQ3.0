//
//  TeSetLocationTableViewController.h
//  BBQ
//
//  Created by wth on 15/8/10.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeJiFenModel.h"

typedef void(^exChangeGiftCallBack)(NSString *);

@interface TeSetLocationTableViewController : UITableViewController

@property (strong, nonatomic) TeJiFenModel *jiFenModel;

@property (copy, nonatomic) exChangeGiftCallBack callBackJiFenBlock;

@end
