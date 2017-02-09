//
//  SelectFriendsTableViewController.h
//  BBQ
//
//  Created by wth on 15/7/28.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^friendsBlock)(NSArray *arr);

@interface SelectFriendsTableViewController : UITableViewController

@property(copy, nonatomic)friendsBlock block;

- (void)reloadData:(NSArray *)data;

@end
