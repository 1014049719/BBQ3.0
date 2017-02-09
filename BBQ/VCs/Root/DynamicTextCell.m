//
//  DynamicTextCell.m
//  BBQ
//
//  Created by anymuse on 15/7/22.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "DynamicTextCell.h"
#import <GCPlaceholderTextView.h>

@implementation DynamicTextCell

- (void)awakeFromNib {
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.dynamicInputView.placeholder = @"宝宝正在干嘛呢？";
  self.dynamicInputView.placeholderColor = [UIColor lightGrayColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
}

@end
