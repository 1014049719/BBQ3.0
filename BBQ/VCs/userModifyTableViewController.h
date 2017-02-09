//
//  userModifyTableViewController.h
//  BBQ
//
//  Created by wth on 15/7/22.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RelativeModel.h"
#import "UserDataModel.h"

typedef NS_ENUM(NSUInteger, BBQModifyUserInfoType) {
    BBQModifyUserInfoTypeNormal,
    BBQModifyUserInfoTypeAddBaby,
    BBQModifyUserInfoTypeLogin,
//    BBQModifyUserInfoTypeComplete,
};

@interface userModifyTableViewController : UITableViewController

@property (assign, nonatomic) BBQModifyUserInfoType type;
/// 保存自定义与宝宝的关系传回的name
@property (copy, nonatomic) NSString *addRelationshipName;

@property (strong, nonatomic) RelativeModel *relativeModel;

@property (strong, nonatomic) UserDataModel *userDataModel;

@property (strong, nonatomic) BBQBabyModel *baobao;

@end
