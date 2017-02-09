//
//  helpPageViewController.h
//  BBQ
//
//  Created by wth on 15/8/4.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ScrollPageBlock)(NSInteger,CGFloat);

//获取顶部栏目
typedef void(^getTopArrBlock)(NSArray *);

@interface helpPageViewController : UIPageViewController

@property (copy, nonatomic) ScrollPageBlock block;
@property(copy,nonatomic)getTopArrBlock getTopArrblock;

- (void)moveToPageOfIndex:(NSInteger)idx;

//Vcl个数
-(void)setDataArr:(int )count;

@end
