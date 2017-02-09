//
//  BBQSetNameViewController.h
//  BBQ
//
//  Created by wenjing on 15/11/24.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "MTABaseViewController.h"
typedef void (^ReturnTextBlock)(NSString *showText);

@interface BBQSetNameViewController : BBQBaseViewController

@property (nonatomic, copy) ReturnTextBlock returnTextBlock;
@property (nonatomic, copy) NSString *nameStr;

- (void)returnText:(ReturnTextBlock)block;

@end
