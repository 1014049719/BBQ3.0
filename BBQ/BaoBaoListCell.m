//
//  BaoBaoListCell.m
//  BBQ
//
//  Created by slovelys on 15/8/10.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "BaoBaoListCell.h"

@implementation BaoBaoListCell

- (void)awakeFromNib {
    self.headView.layer.masksToBounds = YES;
    self.headView.layer.cornerRadius = CGRectGetHeight(self.headView.frame) / 2.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  // Configure the view for the selected state
}

@end
