//
//  RightChooseCell.m
//  BBQ
//
//  Created by 朱琨 on 15/8/12.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "RightChooseCell.h"

@implementation RightChooseCell

- (void)awakeFromNib {
  self.headImageView.layer.masksToBounds = YES;
  self.headImageView.layer.cornerRadius =
      CGRectGetHeight(self.headImageView.frame) / 2.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  // Configure the view for the selected state
}

@end
