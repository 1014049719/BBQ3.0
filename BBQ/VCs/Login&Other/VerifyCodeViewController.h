//
//  VerifyCodeViewController.h
//  JYEX
//
//  Created by 朱琨 on 15/7/4.
//  Copyright © 2015年 广州洋基. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BBQVerifyCodeType) {
    BBQVerifyCodeTypeNormal,
    BBQVerifyCodeTypeLogin,
};

@interface VerifyCodeViewController : BBQBaseViewController

@property (assign, nonatomic) BBQVerifyCodeType type;

@end
