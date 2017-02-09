//
//  BBQNewTaskTableViewCell.h
//  BBQ
//
//  Created by anymuse on 15/12/23.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BBQNewTaskTableViewCell;
@protocol BBQNewTaskTableViewCellDelegate <NSObject>

@optional
- (void)newTaskTableViewCell:(BBQNewTaskTableViewCell *)cell taskno:(NSInteger)taskno ;

@end

@interface BBQNewTaskTableViewCell : UITableViewCell
@property(nonatomic,assign)NSInteger taskno;
@property (nonatomic, weak) id<BBQNewTaskTableViewCellDelegate> delegate;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
