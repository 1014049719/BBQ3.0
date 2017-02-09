//
//  DetailHeaderCell.h
//  BBQ
//
//  Created by 朱琨 on 15/8/5.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dynamic.h"
#import "DynamicView.h"

@protocol DetailHeaderCellDelegate <NSObject>

- (void)didClickMediaAtIndex:(NSInteger)index;
- (void)didClickPhoto:(UIImageView *)photo atIndex:(NSInteger)index;
- (void)didClickGiftView;
- (void)didClickGiftButton;
- (void)didClickUserWithID:(NSNumber *)ID;

@end

@interface DetailHeaderCell : UITableViewCell
@property (weak, nonatomic) id<DetailHeaderCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *fbztxImageView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *datelineLabel;
@property (weak, nonatomic) IBOutlet UILabel *classnameLabel;
@property (weak, nonatomic) IBOutlet UIView *contentZoneView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *photoView;
@property (weak, nonatomic) IBOutlet UIButton *giftButton;

@property (strong, nonatomic) Dynamic *model;

@property (weak, nonatomic) IBOutlet UIView *giftView;
@property (weak, nonatomic) IBOutlet UILabel *giftTotalCountLabel;
@property (weak, nonatomic) IBOutlet UIView *giftSeparateLine;
@property (weak, nonatomic) IBOutlet UILabel *graphtimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *graphtimeImageView;

@property (weak, nonatomic) IBOutlet UIImageView *giftBorderView;
- (void)loadImages;

@end
