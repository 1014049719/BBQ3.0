//
//  BabyDynamicCell.h
//  BBQ
//
//  Created by 朱琨 on 15/8/2.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DynamicView.h"

@protocol DynamicCellDelegate <NSObject>
@optional
- (void)didClickShareButtonAtIndexPath:(NSIndexPath *)indexPath;
- (void)didClickGiftViewAtIndexPath:(NSIndexPath *)indexPath;
- (void)didClickGiftButtonAtIndexPath:(NSIndexPath *)indexPath;
- (void)didClickCommentLabelAtIndexPath:(NSIndexPath *)indexPath atIndex:(NSInteger)index;
- (void)didLongPressCommentLabelAtIndexPath:(NSIndexPath *)indexPath atIndex:(NSInteger)index;
- (void)didTapCommentLabelAtIndexPath:(NSIndexPath *)indexPath atIndex:(NSInteger)index;
- (void)didClickBottomCommentButtonAtIndexPath:(NSIndexPath *)indexPath;
- (void)didClickPhoto:(UIImageView *)photo atIndexPath:(NSIndexPath *)indexPath atIndex:(NSInteger)index;
- (void)didClickUserWithID:(NSString *)ID;
- (void)didClickBgViewAtIndexPath:(NSIndexPath *)indexPath;
- (void)didClickCommentButtonAtIndexPath:(NSIndexPath *)indexPath;
- (void)didClickDeleteButtonAtIndexPath:(NSIndexPath *)indexPath;
@end

@class DynaModel;
@interface BabyDynamicCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *middleCommentButton;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (weak, nonatomic) IBOutlet UIView *giftView;
@property (weak, nonatomic) IBOutlet UIImageView *firstTagImageView;
@property (weak, nonatomic) IBOutlet UIButton *bottomCommentButton;
@property (weak, nonatomic) IBOutlet UIButton *giftButton;
@property (weak, nonatomic) IBOutlet UIImageView *fbztxImageView;
@property (weak, nonatomic) IBOutlet UIImageView *giftBorderView;
@property (weak, nonatomic) IBOutlet UIImageView *graphtimeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *warningView;
@property (weak, nonatomic) IBOutlet UILabel *anotherClassNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *classNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *crenicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *datelineLabel;
@property (weak, nonatomic) IBOutlet UILabel *giftTotalCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *graphtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UIView *commentView;
@property (weak, nonatomic) IBOutlet UIView *contentZoneView;
@property (weak, nonatomic) IBOutlet UIView *giftSeparateLine;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UIView *photoView;
@property (weak, nonatomic) IBOutlet UIView *tagView;
@property (weak, nonatomic) id<DynamicCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIView *bgView;

//
@property (strong, nonatomic) DynaModel *model;
//
- (void)cancelAllOperations;
- (void)loadImages;
- (void)hidePopmenu;

@end
