//
//  DetailCommentCell.h
//  BBQ
//
//  Created by anymuse on 15/7/21.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MLLinkLabel.h>

@protocol DetailCommentCellDelegate <NSObject>

@optional

- (void)didClickCommentButtonAtIndexPath:(NSIndexPath *)indexPath;
- (void)didLongPressCommentLabelAtIndexPath:(NSIndexPath *)indexPath;
- (void)didClickUserWithID:(NSNumber *)ID;

@end

@interface DetailCommentCell : UITableViewCell <MLLinkLabelDelegate>
@property (weak, nonatomic) id<DetailCommentCellDelegate> delegate;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (weak, nonatomic) IBOutlet UIImageView *replierHeadView;
@property (weak, nonatomic) IBOutlet UILabel *replierNicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet MLLinkLabel *contentLabel;

@property (strong, nonatomic) Comment *model;

- (void)loadImages;


@end
