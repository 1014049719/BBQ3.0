//
//  ResetUserDataTableViewController.h
//  BBQ
//
//  Created by wth on 15/8/11.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h> 

typedef NS_ENUM(NSInteger, BBQResetUserDataType) {
    BBQResetUserDataTypeNormal = 1,
    BBQResetUserDataTypeLogin,
    BBQResetUserDataTypeRegist,
};

@interface ResetUserDataTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIButton *headerBtn;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (assign, nonatomic) BBQResetUserDataType resetType;
- (IBAction)sureBtnEvent:(UIButton *)sender;

@end
