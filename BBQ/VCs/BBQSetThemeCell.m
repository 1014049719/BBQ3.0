//
//  BBQSetThemeCell.m
//  BBQ
//
//  Created by slovelys on 15/12/21.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQSetThemeCell.h"

@implementation BBQSetThemeCell

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.selectedImgView.highlighted = selected;
}

@end
