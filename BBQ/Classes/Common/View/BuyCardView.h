//
//  BuyCardView.h
//  BBQ
//
//  Created by anymuse on 15/7/24.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppMacro.h"


@interface BuyCardView : UIView

@property (assign, nonatomic) ChosedPayWay payWay;
@property (strong, nonatomic) UIButton *confirmButton;

- (void)showBuyCardViewWithPrice:(float)price;
- (void)hideSelf;

@end
