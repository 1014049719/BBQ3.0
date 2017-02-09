//
//  DynamicPageViewController.h
//  BBQ
//
//  Created by wth on 15/8/11.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^pageViewBlock)(NSInteger);

@interface DynamicPageViewController : UIPageViewController

@property(strong,nonatomic)pageViewBlock block;

-(void)MovetoPageOfIndex:(NSInteger)idx;

@end
