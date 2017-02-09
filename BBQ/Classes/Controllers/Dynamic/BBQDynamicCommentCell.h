//
//  BBQDynamicCommentCell.h
//  BBQ
//
//  Created by 朱琨 on 15/11/26.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQDynamicCommentLayout.h"

extern NSString * const kDynamicCommentCellIdentifier;

@protocol BBQDynamicCellDelegate;

@interface BBQDynamicCommentCell : UITableViewCell

@property (weak, nonatomic) id<BBQDynamicCellDelegate> delegate;
@property (strong, nonatomic) BBQDynamicCommentLayout *layout;

@property (strong, nonatomic) UIImageView *avatar;
@property (strong, nonatomic) YYLabel *contentLabel;

@end
