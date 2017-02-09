//
//  BBQNewUploadCell.m
//  BBQ
//
//  Created by slovelys on 15/10/13.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQNewUploadCell.h"

@implementation BBQNewUploadCell

- (void)setSelected:(BOOL)selected {
  [super setSelected:selected];
  self.chooseView.highlighted = selected;
}

@end
