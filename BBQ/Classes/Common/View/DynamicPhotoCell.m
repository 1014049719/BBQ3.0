//
//  DynamicPhotoCell.m
//  BBQ
//
//  Created by anymuse on 15/7/22.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "DynamicPhotoCell.h"

@implementation DynamicPhotoCell

- (void)awakeFromNib {
  // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  // Configure the view for the selected state
}

// add
- (BOOL)canBecomeFirstResponder {
  return YES;
}

@end
