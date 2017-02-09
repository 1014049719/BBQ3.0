//
//  BBQInviteAuditCell.m
//  BBQ
//
//  Created by anymuse on 15/11/27.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQInviteAuditCell.h"
#import "BBQInviteModel.h"
#import "BBQInviteBaobaoData.h"
@interface BBQInviteAuditCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *agreeButton;
@property (weak, nonatomic) IBOutlet UIButton *refuseButton;
@property (weak, nonatomic) IBOutlet UILabel *statuslabel;

@end

@implementation BBQInviteAuditCell

-(void)setCurBaobao:(BBQInviteModel *)curBaobao{
    _curBaobao = curBaobao;
    self.nameLabel.text = [NSString stringWithFormat:@"%@申请加入",curBaobao.baobaodata.username];
    if ([curBaobao.invStatus isEqualToString:@"0"]) {
        self.agreeButton.hidden = NO;
        self.refuseButton.hidden = NO;
        self.statuslabel.hidden = YES;
    }else{
        self.agreeButton.hidden = YES;
        self.refuseButton.hidden = YES;
        self.statuslabel.hidden = NO;
        if ([curBaobao.invStatus isEqualToString:@"1"]) {
            self.statuslabel.text = @"已通过";
        }else{
            self.statuslabel.text = @"已拒绝";
        }
    }
    if ([curBaobao.baobaodata.avartar hasPrefix:@"http://"]) {
        [self.iconView setImageWithURL:[NSURL URLWithString:curBaobao.baobaodata.avartar] placeholder:Placeholder_avatar];
    } else {
        [self.iconView setImage:[UIImage imageWithContentsOfFile:curBaobao.baobaodata.avartar]];
    }
}
- (void)awakeFromNib {
    self.iconView.layer.cornerRadius = self.iconView.bounds.size.width/2.0;
    self.iconView.clipsToBounds = YES;
    self.iconView.userInteractionEnabled = YES;
    [self.iconView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapIconView)]];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.agreeButton.layer.cornerRadius = 15;
    self.refuseButton.layer.cornerRadius = 15;
}
- (IBAction)agree {
    if ([_delegate respondsToSelector:@selector(inviteAuditCell:DidClickButton:status:)]){
       [_delegate inviteAuditCell:self DidClickButton:self.curBaobao status:@"1" ];
    }
    
}
- (IBAction)refuse {
    if ([_delegate respondsToSelector:@selector(inviteAuditCell:DidClickButton:status:)]){
        [_delegate inviteAuditCell:self DidClickButton:self.curBaobao status:@"-1" ];
    }
}

-(void)tapIconView{
    if ([_delegate respondsToSelector:@selector(inviteAuditCell:tapIconView:)]) {
        [_delegate inviteAuditCell:self tapIconView:self.curBaobao];
    }
}
@end
