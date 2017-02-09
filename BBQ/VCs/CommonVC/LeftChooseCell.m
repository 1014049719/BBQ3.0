//
//  LeftChooseCell.m
//  BBQ
//
//  Created by 朱琨 on 15/8/12.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "LeftChooseCell.h"

@implementation LeftChooseCell

- (void)awakeFromNib {
  // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  if (selected) {

    self.contentView.backgroundColor = [UIColor whiteColor];
  } else {

    self.contentView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
  }
}

@end
