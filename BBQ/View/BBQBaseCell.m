//
//  BBQBaseCell.m
//  BBQ
//
//  Created by 朱琨 on 15/11/17.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQBaseCell.h"

@implementation BBQBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        for (UIView *view in self.subviews) {
//            if([view isKindOfClass:[UIScrollView class]]) {
//                ((UIScrollView *)view).delaysContentTouches = NO; // Remove touch delay for iOS 7
//                break;
//            }
//        }
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundView.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

@end
