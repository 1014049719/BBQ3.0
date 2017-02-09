//
//  BBQBabyPickerViewController.h
//  BBQ
//
//  Created by slovelys on 15/11/30.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^babyPickerCallBack)(BBQBabyModel *);

@interface BBQBabyPickerViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (copy, nonatomic) babyPickerCallBack block;

- (instancetype)initWithSource:(NSArray *)array;

@end
