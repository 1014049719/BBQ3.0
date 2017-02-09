//
//  BBQCreateBBCell.h
//  BBQ
//
//  Created by anymuse on 16/1/12.
//  Copyright © 2016年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BBQCreateBBCell;
@protocol BBQCreateBBCellDelegate <NSObject>

@optional
- (void)createBBCell:(BBQCreateBBCell *)cell DidClickViewWithTag:(NSInteger)tag;

@end
@interface BBQCreateBBCell : UITableViewCell
@property (nonatomic, weak) id<BBQCreateBBCellDelegate> delegate;
@end
