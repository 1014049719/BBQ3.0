//
//  LeDouPayCell.m
//  BBQ
//
//  Created by mwt on 15/7/27.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "LeDouPayCell.h"

@implementation LeDouPayCell

- (void)awakeFromNib {
  // Initialization code

  self.LeDou_zhekouLabel.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  //图片的highlight状态
  self.selectImageView.highlighted = selected;
}

@end
