//
//  BBQDynamicViewModel.h
//  BBQ
//
//  Created by 朱琨 on 15/11/17.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dynamic.h"
#import "BBQTableViewController.h"
#import "BBQDynamicCommentCell.h"

@class BBQDynamicTableViewController;
@protocol BBQDynamicCellDelegate;

@interface BBQDynamicViewModel : NSObject <UITableViewDataSource, BBQTableViewControllerDelegate>

@property (copy, readonly, nonatomic) NSNumber *baobaouid;
@property (copy, readonly, nonatomic) NSNumber *classuid;
@property (copy, readonly, nonatomic) NSNumber *schoolid;
@property (copy, readonly, nonatomic) NSString *navTitle;
@property (weak, nonatomic) BBQDynamicTableViewController<BBQDynamicCellDelegate> *viewController;
@property (assign, readonly, nonatomic) BBQDynamicGroupType groupType;
@property (strong, nonatomic) Dynamic *curDynamic;

+ (instancetype)viewModelWithObject:(id)object;
//某个宝宝的动态
+ (instancetype)viewModelForBaby:(NSNumber *)baobaouid;
//某个班级所有宝宝的动态
+ (instancetype)viewModelForBabiesInClass:(NSNumber *)classuid;
//某个学校所有宝宝的动态
+ (instancetype)viewModelForBabiesInSchool:(NSNumber *)schoolid;
//某个班级的班级动态
+ (instancetype)viewModelForClass:(NSNumber *)classuid inSchool:(NSNumber *)schoolid;
//某个学校所有班级的班级动态
+ (instancetype)viewmodelForClassesInSchool:(NSNumber *)schoolid;
//某个学校的学校动态
+ (instancetype)viewModelForSchool:(NSNumber *)schoolid;

- (instancetype)initWithGroupType:(BBQDynamicGroupType)groupType baobaouid:(NSNumber *)baobaouid classuid:(NSNumber *)classuid schoolid:(NSNumber *)schoolid;

- (void)handleDateViewForCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)addComment:(Comment *)comment withDynamic:(Dynamic *)dynamic;
- (void)deleteComment:(Comment *)comment withDynamic:(Dynamic *)dynamic;
- (void)deleteDynamic:(Dynamic *)dynamic;

@end
