//
//  FriendsCell.m
//  BBQ
//
//  Created by mwt on 15/8/3.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "FriendsCell.h"

@implementation FriendsCell

- (void)awakeFromNib {
  // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  //图片的highlight状态
  self.selectionView.highlighted = selected;
}

@end
