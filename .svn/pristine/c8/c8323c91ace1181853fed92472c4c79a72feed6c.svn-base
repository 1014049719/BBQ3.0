//
//  BBQDynamicCell.h
//  BBQ
//
//  Created by 朱琨 on 15/11/17.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQDynamicLayout.h"
#import "BBQControl.h"
#import "BBQDynamicHelper.h"

@class BBQDynamicCell, BBQDynamicCommentCell;
extern NSString * const kDynamicCellIdentifier;

@protocol BBQDynamicCellDelegate <NSObject>

@optional
- (void)didClickUserWithID:(NSNumber *)uid;
- (void)cell:(BBQDynamicCell *)cell didClickMediaAtIndex:(NSInteger)index;
- (void)cell:(BBQDynamicCell *)cell didClickCommentCell:(BBQDynamicCommentCell *)commentCell;
- (void)cell:(BBQDynamicCell *)cell didLongPressCommentCell:(BBQDynamicCommentCell *)commentCell;
- (void)didClickShareButtonWithCell:(BBQDynamicCell *)cell;
- (void)didClickFuncButton:(UIButton *)button withCell:(BBQDynamicCell *)cell;
- (void)didClickCommentButtonWithCell:(BBQDynamicCell *)cell;
- (void)didClickDeleteButtonWithCell:(BBQDynamicCell *)cell;
- (void)didClickEditButtonWithCell:(BBQDynamicCell *)cell;
- (void)didClickGiftButtonWithCell:(BBQDynamicCell *)cell;
- (void)didClickWhiteSpaceWithCell:(BBQDynamicCell *)cell;
- (void)didClickGiftViewWithCell:(BBQDynamicCell *)cell;

@end

@interface BBQDynamicDateView : UIView

@property (strong, nonatomic) YYLabel *dateLabel;

@end

@interface BBQDynamicProfileView : UIView

@property (strong, nonatomic) UIImageView *avatarView;
@property (strong, nonatomic) UIActivityIndicatorView *indicator;
@property (strong, nonatomic) UIView *warningView;
@property (strong, nonatomic) YYLabel *nameLabel;
@property (strong, nonatomic) YYLabel *sourceLabel;
@property (strong, nonatomic) YYLabel *postTimeLabel;
@property (weak, nonatomic) BBQDynamicCell *cell;
@property (strong, nonatomic) UIView *themeBar;

@end

@interface BBQDynamicTagView : UIView

@property (strong, nonatomic) UIView *topBarView;
@property (strong, nonatomic) UIView *tagImageView;
@property (strong, nonatomic) YYLabel *tagLabel;

@end

@interface BBQDynamicGiftView : UIView

@property (strong, nonatomic) YYLabel *totalCountLabel;
@property (strong, nonatomic) UIImageView *bgView;
@property (copy, nonatomic) NSArray *giftViews;
@property (copy, nonatomic) NSArray *countLabels;
@property (copy, nonatomic) NSArray *avatarViews;
@property (weak, nonatomic) BBQDynamicCell *cell;

- (void)setWithLayout:(BBQDynamicLayout *)layout;

@end

@interface BBQDynamicToolbarView : UIView

@property (strong, nonatomic) UIButton *shareButton;
@property (strong, nonatomic) UIButton *commentButton;
@property (strong, nonatomic) CALayer *topLine;
@property (weak, nonatomic) BBQDynamicCell *cell;

@end

@interface BBQDynamicView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) BBQDynamicDateView *dateView;
@property (strong, nonatomic) BBQDynamicProfileView *profileView;
@property (strong, nonatomic) BBQDynamicTagView *tagView;
@property (strong, nonatomic) YYLabel *textLabel;
@property (copy, nonatomic) NSArray *mediaViews;
@property (strong, nonatomic) UIButton *giftButton;
@property (strong, nonatomic) UIButton *funcButton;
@property (strong, nonatomic) BBQDynamicGiftView *giftView;
@property (strong, nonatomic) UITableView *commentTableView;
@property (strong, nonatomic) BBQDynamicToolbarView *toolbarView;
@property (strong, nonatomic) BBQDynamicLayout *layout;
@property (weak, nonatomic) BBQDynamicCell *cell;

- (void)showDateView:(BOOL)show;

@end

@interface BBQDynamicCell : UITableViewCell

@property (weak, nonatomic) id<BBQDynamicCellDelegate> delegate;
@property (strong, nonatomic) BBQDynamicView *dynamicView;
@property (strong, nonatomic) Dynamic *dynamic;
@property (strong, nonatomic) BBQDynamicLayout *layout;

@end
