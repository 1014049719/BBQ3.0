//
//  BBQAttentionCell.m
//  BBQ
//
//  Created by wenjing on 15/11/19.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQAttentionCell.h"
#import <DateTools.h>
@interface BBQAttentionCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *attachLabel;
@property (weak, nonatomic) IBOutlet UIImageView *choicedView;
@end

@implementation BBQAttentionCell
-(void)setCurBaobao:(BBQBabyModel *)curBaobao {
    _curBaobao = curBaobao;
    self.nameLabel.text = curBaobao.realname;
    if ([curBaobao.uid isEqualToNumber:TheCurBaoBao.uid]){
        self.choicedView.hidden = NO;
        self.nameLabel.textColor = [UIColor redColor];
    }
    else{
        self.choicedView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    if ([curBaobao.birthday  isEqual:@0]) {
        self.attachLabel.text = @"0岁";
    } else {
        self.attachLabel.text = [CommonFunc getAgeWithYear:curBaobao.birthyear.intValue
                                                     month:curBaobao.birthmonth.intValue
                                                       day:curBaobao.birthday.intValue];
    }
    if ([curBaobao.avartar hasPrefix:@"http://"]) {
        [self.iconView setImageWithURL:[NSURL URLWithString:curBaobao.avartar] placeholder:Placeholder_avatar];
    } else {
        [self.iconView setImage:[UIImage imageWithContentsOfFile:curBaobao.avartar]];
    }
}
- (void)awakeFromNib {
    self.iconView.layer.cornerRadius = 20;
    self.iconView.clipsToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


@end
