//
//  BabySideBar.h
//  BBQ
//
//  Created by anymuse on 15/8/6.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BabySideBarWillAnimateBlock)();
typedef void(^BabySideBarDidFinishAnimatingBlock)();
typedef void(^BabySideBarCheckBabyBlock)(NSInteger index);

@interface BabySideBar : UIScrollView

@property (assign, nonatomic) BOOL isShowing;
@property (assign, nonatomic) CGFloat barWitdh;
@property (copy, nonatomic) BabySideBarDidFinishAnimatingBlock finishAnimationBlock;
@property (copy, nonatomic) BabySideBarWillAnimateBlock willAnimateBlock;
@property (copy, nonatomic) BabySideBarCheckBabyBlock checkBabyBlock;

- (void)dismissSideBar;
- (void)showSideBar;
- (void)loadBabyData;

@end
