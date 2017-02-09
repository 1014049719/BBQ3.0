//
//  BBQErrorView.h
//  BBQ
//
//  Created by 朱琨 on 15/12/23.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBQErrorView : UIView

@property (copy, nonatomic) void (^reloadBlock)();

@end
