//
//  RootTabBar.h
//  JYEX
//
//  Created by anymuse on 15/7/16.
//  Copyright © 2015年 广州洋基. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonClickBlock)(UIButton *);

@interface RootTabBar : UITabBar 

@property (strong, nonatomic) UIButton *middleButton;
@property (strong, nonatomic) ButtonClickBlock buttonBlock;
@property (strong, nonatomic) UIImageView *legoImgView;

@end
