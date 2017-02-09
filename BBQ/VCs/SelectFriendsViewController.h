//
//  SelectFriendsViewController.h
//  BBQ
//
//  Created by wth on 15/7/28.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef float (^caculateMoneyBlock)(int num);
typedef void (^payMoneyBlock)(NSArray *arr);

@interface SelectFriendsViewController : BBQBaseViewController

@property(strong,nonatomic)  caculateMoneyBlock block;

@property(strong,nonatomic)  payMoneyBlock payblock;

@property (copy, nonatomic) NSString *productID;

@property (assign, nonatomic) int ledouNum;

@property (copy, nonatomic) NSString *price;

@end
