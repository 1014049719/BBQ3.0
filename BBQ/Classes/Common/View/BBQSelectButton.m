//
//  BBQSelectButton.m
//  BBQ
//
//  Created by slovelys on 15/12/10.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQSelectButton.h"

@implementation BBQSelectButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageEdgeInsets = UIEdgeInsetsMake(0, self.titleLabel.frame.size.width, 0, -self.titleLabel.frame.size.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.imageView.frame.size.width, 0, self.imageView.frame.size.width);
    [self layoutIfNeeded];
}

@end
