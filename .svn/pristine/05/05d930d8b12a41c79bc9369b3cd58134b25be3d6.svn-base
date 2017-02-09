//
//  BBQDynamicCommentCell.m
//  BBQ
//
//  Created by 朱琨 on 15/11/26.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQDynamicCommentCell.h"

NSString *const kDynamicCommentCellIdentifier = @"DynamicCommentCell";

@implementation BBQDynamicCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        _avatar = [UIImageView new];
        [self.contentView addSubview:_avatar];
        CALayer *avatarBorder = [CALayer layer];
        avatarBorder.frame = _avatar.bounds;
        avatarBorder.borderWidth = CGFloatFromPixel(1);
        avatarBorder.borderColor = [UIColor colorWithWhite:0.000 alpha:0.090].CGColor;
        avatarBorder.cornerRadius = _avatar.height / 2;
        avatarBorder.shouldRasterize = YES;
        avatarBorder.rasterizationScale = kScreenScale;
        [_avatar.layer addSublayer:avatarBorder];
        
        _contentLabel = [YYLabel new];
        _contentLabel.exclusiveTouch = YES;
        _contentLabel.displaysAsynchronously = YES;
        _contentLabel.ignoreCommonProperties = YES;
        _contentLabel.fadeOnAsynchronouslyDisplay = NO;
        _contentLabel.fadeOnHighlight = NO;
        _contentLabel.lineBreakMode = NSLineBreakByClipping;
        [self.contentView addSubview:_contentLabel];
    }
    return self;
}

- (void)setLayout:(BBQDynamicCommentLayout *)layout {
    _layout = layout;
    _layout.delegate = self.delegate;
    self.height = layout.height;
    self.contentView.height = layout.height;
    if (layout.style == BBQDynamicStyleTimeline) {
        _avatar.size = CGSizeMake(24, 24);
        _avatar.top = 7.5;
        [_avatar setImageWithURL:[NSURL URLWithString:layout.comment.fbztx] placeholder:Placeholder_avatar
                         options:kNilOptions
                         manager:[BBQDynamicHelper avatarImageManager]
                        progress:nil
                       transform:nil
                      completion:nil];
        _contentLabel.textLayout = layout.textLayout;
        _contentLabel.size = CGSizeMake(kDynamicCellContentWidth - 31.5, layout.height);
        _contentLabel.left = _avatar.right + 7.5;
    }
}

@end
