//
//  BBQDailyReportEditBabyListCell.m
//  BBQ
//
//  Created by 朱琨 on 15/10/20.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQDailyReportEditBabyListCell.h"

@interface BBQDailyReportEditBabyListCell ()
@property(weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property(weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation BBQDailyReportEditBabyListCell

- (void)setModel:(BBQEditWordsBabyListModel *)model {
  _model = model;
  self.nameLabel.text = _model.baby.realname;
}

- (void)setBaby:(BBQBabyModel *)baby {
  _baby = baby;
  self.nameLabel.text = baby.realname;
  self.avatarImageView.layer.masksToBounds = YES;
  self.avatarImageView.layer.cornerRadius =
      CGRectGetHeight(self.avatarImageView.frame) / 2.0;
  [self.avatarImageView
      setImageWithURL:[NSURL URLWithString:_baby.avartar]
             placeholder:Placeholder_avatar
                 options:YYWebImageOptionSetImageWithFadeAnimation
              completion:nil];
}

@end
