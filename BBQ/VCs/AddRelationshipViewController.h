//
//  AddRelationshipViewController.h
//  BBQ
//
//  Created by slovelys on 15/7/27.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^RelativeCallBack)(NSString *);

@interface AddRelationshipViewController : BBQBaseViewController

@property (nonatomic,copy) RelativeCallBack block;

@end
