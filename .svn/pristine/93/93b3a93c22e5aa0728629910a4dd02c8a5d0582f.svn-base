//
//  BBQInviteViewCell.m
//  BBQ
//
//  Created by anymuse on 15/11/30.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQInviteViewCell.h"
@interface BBQInviteViewCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end

@implementation BBQInviteViewCell

-(void)setCurBaobao:(BBQBabyModel *)curBaobao{
    _curBaobao = curBaobao;
    self.nameLabel.text = curBaobao.realname;
    if ([curBaobao.avartar hasPrefix:@"http://"]) {
        [self.iconView setImageWithURL:[NSURL URLWithString:curBaobao.avartar] placeholder:Placeholder_avatar];
    } else {
        [self.iconView setImage:[UIImage imageWithContentsOfFile:curBaobao.avartar]];
    }
}- (void)awakeFromNib {
    self.iconView.layer.cornerRadius = 20;
    self.iconView.clipsToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
