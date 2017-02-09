//
//  CreatToDynamicViewController.h
//  BBQ
//
//  Created by wth on 15/8/14.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CreatDynamicTypeBlock)(NSString *);

@interface CreatToDynamicViewController : BBQBaseViewController

@property(copy,nonatomic)CreatDynamicTypeBlock block;

@end
