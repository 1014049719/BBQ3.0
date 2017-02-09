//
//  BBQOperationTableViewCell.h
//  BBQ
//
//  Created by anymuse on 15/12/30.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBQOperationExpand.h"
@class BBQOperationTableViewCell;
@protocol BBQOperationTableViewCellDelegate <NSObject>

@optional
- (void)operationTableViewCellDidDelete:(BBQOperationTableViewCell *)cell index:(NSInteger)index ;
- (void)operationTableViewCellImageButtonClick:(BBQOperationTableViewCell *)cell index:(NSInteger)index ;
- (void)operationTableViewCell:(BBQOperationTableViewCell *)cell getdesc:(NSString *)descStr index:(NSInteger)index ;
- (void)operationTableViewCell:(BBQOperationTableViewCell *)cell keyBoardWithIndex:(NSInteger)index ;

@end
@interface BBQOperationTableViewCell : UITableViewCell
@property (nonatomic, weak) id<BBQOperationTableViewCellDelegate> delegate;
@property (nonatomic, strong) BBQOperationExpand *expand;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
