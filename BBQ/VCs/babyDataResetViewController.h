//
//  babyDataResetViewController.h
//  BBQ
//
//  Created by wth on 15/7/29.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BBQBabyDataResetType) {
    BBQBabyDataResetTypeNormal,
    BBQBabyDataResetTypeLogin,
};

@interface babyDataResetViewController : BBQBaseViewController

@property (assign, nonatomic) BBQBabyDataResetType type;

@property (strong, nonatomic) BBQBabyModel *baby;

@end
