//
//  GroupCell.m
//  BBQ
//
//  Created by anymuse on 15/7/23.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "GroupCell.h"

@implementation GroupCell

- (void)awakeFromNib {
  self.userHeadView.layer.masksToBounds = YES;
  self.userHeadView.layer.cornerRadius =
      CGRectGetHeight(self.userHeadView.frame) / 2.0;

  self.vipLabel.layer.masksToBounds = YES;
  self.vipLabel.layer.cornerRadius = CGRectGetHeight(self.vipLabel.frame) / 2.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  // Configure the view for the selected state
}

@end
