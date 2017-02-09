//
//  BBQDynamicCell.m
//  BBQ
//
//  Created by 朱琨 on 15/11/17.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQDynamicCell.h"
#import "BBQDynamicCommentCell.h"
#import <NYXImagesKit.h>
#import "UIImage+Common.h"
#import "BBQThemeManager.h"

NSString * const kDynamicCellIdentifier = @"DynamicCell";

@implementation BBQDynamicDateView
- (instancetype)initWithFrame:(CGRect)frame {
    frame = CGRectMake(5, kDynamicCellTopMargin, 45, 47);
    self = [super initWithFrame:frame];
    self.layer.contents =
    (__bridge id)[UIImage imageNamed:@"dynamic_date_bg"].CGImage;
    
    _dateLabel = [YYLabel new];
    _dateLabel.size = CGSizeMake(self.width, 35);
    _dateLabel.top = 8;
    _dateLabel.displaysAsynchronously = YES;
    _dateLabel.ignoreCommonProperties = YES;
    _dateLabel.fadeOnHighlight = NO;
    _dateLabel.fadeOnAsynchronouslyDisplay = NO;
    _dateLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_dateLabel];
    return self;
}

@end

@implementation BBQDynamicProfileView {
    BOOL _trackingTouch;
}

- (instancetype)initWithFrame:(CGRect)frame {
    frame =
    CGRectMake(0, kDynamicCellTopMargin, kDynamicCellProfileWidth, kDynamicCellProfileHeight);
    self = [super initWithFrame:frame];
    self.exclusiveTouch = YES;
    _avatarView = [UIImageView new];
    _avatarView.size = CGSizeMake(40, 40);
    _avatarView.origin = CGPointMake(0, 0);
    _avatarView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_avatarView];
    
    if (TheCurUser.themeType == BBQThemeTypeLego) {
        _themeBar = [UIView new];
        _themeBar.layer.contentMode = UIViewContentModeScaleAspectFill;
        _themeBar.layer.contents = (__bridge id)[UIImage imageNamed:@"theme_dynamic_bar"].CGImage;
        _themeBar.width = kScaleFrom_iPhone6_Desgin(380 / 3.0);
        _themeBar.height = kScaleFrom_iPhone6_Desgin(50 / 3.0);
        _themeBar.bottom = self.height;
        _themeBar.right = self.width - 15;
        [self addSubview:_themeBar];
    }
    
    _nameLabel = [YYLabel new];
    _nameLabel.size = CGSizeMake(kDynamicCellNameWidth, 20);
    _nameLabel.left = _avatarView.right + 7.5;
    _nameLabel.top = _avatarView.top + 5;
    _nameLabel.displaysAsynchronously = YES;
    _nameLabel.ignoreCommonProperties = YES;
    _nameLabel.fadeOnAsynchronouslyDisplay = NO;
    _nameLabel.fadeOnHighlight = NO;
    _nameLabel.lineBreakMode = NSLineBreakByClipping;
    _nameLabel.textVerticalAlignment = YYTextVerticalAlignmentTop;
    [self addSubview:_nameLabel];
    
    _sourceLabel = [YYLabel new];
    _sourceLabel.size = CGSizeMake(_nameLabel.width, 15);
    _sourceLabel.left = _nameLabel.left;
    _sourceLabel.bottom = self.height - 7.5;
    _sourceLabel.displaysAsynchronously = YES;
    _sourceLabel.ignoreCommonProperties = YES;
    _sourceLabel.fadeOnAsynchronouslyDisplay = NO;
    _sourceLabel.fadeOnHighlight = NO;
    _sourceLabel.textVerticalAlignment = YYTextVerticalAlignmentBottom;
    [self addSubview:_sourceLabel];
    
    _postTimeLabel = [YYLabel new];
    _postTimeLabel.size = CGSizeMake(150, 15);
    _postTimeLabel.right = kDynamicCellProfileWidth;
    _postTimeLabel.centerY = _avatarView.centerY;
    _postTimeLabel.displaysAsynchronously = YES;
    _postTimeLabel.ignoreCommonProperties = YES;
    _postTimeLabel.fadeOnAsynchronouslyDisplay = NO;
    _postTimeLabel.fadeOnHighlight = NO;
    [self addSubview:_postTimeLabel];
    
    _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _indicator.centerY = _avatarView.centerY;
    _indicator.right = kDynamicCellProfileWidth;
    _indicator.hidden = YES;
    [self addSubview:_indicator];
    
    _warningView = [UIView new];
    _warningView.size = CGSizeMake(20, 20);
    _warningView.centerY = _avatarView.centerY;
    _warningView.right = kDynamicCellProfileWidth;
    _warningView.layer.contents = (__bridge id)[UIImage imageNamed:@"tips_failed"].CGImage;
    _warningView.hidden = YES;
    [self addSubview:_warningView];
    
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    _trackingTouch = NO;
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView:_avatarView];
    if (CGRectContainsPoint(_avatarView.bounds, p)) {
        _trackingTouch = YES;
    }
    p = [t locationInView:_nameLabel];
    if (CGRectContainsPoint(_nameLabel.bounds, p) &&
        _nameLabel.textLayout.textBoundingRect.size.width > p.x) {
        _trackingTouch = YES;
    }
    if (!_trackingTouch) {
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!_trackingTouch) {
        [super touchesEnded:touches withEvent:event];
    } else {
        if ([self.cell.delegate
                                   respondsToSelector:@selector(didClickUserWithID:)] && self.cell.layout.style != BBQDynamicStyleWelcome) {
            [self.cell.delegate didClickUserWithID:self.cell.dynamic.creuid];
        }
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!_trackingTouch) {
        [super touchesCancelled:touches withEvent:event];
    }
}

@end

@implementation BBQDynamicTagView

- (instancetype)initWithFrame:(CGRect)frame {
    frame = CGRectMake(0, 0, kDynamicCellProfileWidth, 0);
    if (self = [super initWithFrame:frame]) {
        _tagImageView = [UIView new];
        _tagImageView.layer.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_tagImageView];
        _topBarView =
        [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 5)];
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:_topBarView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _topBarView.bounds;
        maskLayer.path = path.CGPath;
        maskLayer.shouldRasterize = YES;
        maskLayer.rasterizationScale = [UIScreen mainScreen].scale;
        _topBarView.layer.mask = maskLayer;
        [self addSubview:_topBarView];
        _tagLabel = [YYLabel new];
        _tagLabel.displaysAsynchronously = YES;
        _tagLabel.ignoreCommonProperties = YES;
        _tagLabel.fadeOnAsynchronouslyDisplay = NO;
        _tagLabel.fadeOnHighlight = NO;
        [self addSubview:_tagLabel];
    }
    return self;
}

- (void)setWithLayout:(BBQDynamicLayout *)layout {
    _tagImageView.layer.contents =
    (__bridge id)[UIImage imageNamed:layout.tagPicName].CGImage;
    if (layout.tagType == BBQDynamicTagTypeReport) {
        _tagImageView.frame = CGRectMake(5, 4.5, 22.5, 25);
        _tagLabel.left = _tagImageView.right + 10;
        _tagLabel.top = 10;
        _tagLabel.size = CGSizeMake(kDynamicCellProfileWidth - 46, 16);
        _topBarView.hidden = NO;
        _topBarView.backgroundColor = layout.tagColor;
    } else {
        _topBarView.hidden = YES;
        _tagLabel.top = 15;
        _tagLabel.size = CGSizeMake(kDynamicCellProfileWidth - kDynamicCellPadding * 2 - 24 - 5, layout.tagHeight - 15);
        _tagImageView.size = CGSizeMake(24, 24);
        _tagImageView.left = kDynamicCellPadding;
        _tagImageView.centerY = _tagLabel.centerY;
        _tagLabel.left = _tagImageView.right + 5;
    }
}

@end

@implementation BBQDynamicGiftView

- (instancetype)initWithFrame:(CGRect)frame {
    frame = CGRectMake(kDynamicCellPadding, 0, kDynamicCellContentWidth, 1);
    if (self = [super initWithFrame:frame]) {
        _bgView = [UIImageView new];
        _bgView.size = self.size;
        _bgView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _bgView.image = [[UIImage imageNamed:@"gift_border"] resizableImageWithCapInsets:UIEdgeInsetsMake(30, 50, 30, 40)];
        [self addSubview:_bgView];
        @weakify(self)
        UITapGestureRecognizer *singleTap = [UITapGestureRecognizer bk_recognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
            @strongify(self)
            if ([self.cell.delegate
                 respondsToSelector:
                 @selector(didClickGiftViewWithCell:)]) {
                [self.cell.delegate didClickGiftViewWithCell:self.cell];
            }
        }];
        [self addGestureRecognizer:singleTap];
        
        self.exclusiveTouch = YES;
        _totalCountLabel = [YYLabel new];
        _totalCountLabel.size = CGSizeMake(kDynamicCellContentWidth - 35, 12);
        _totalCountLabel.top = 17;
        _totalCountLabel.left = 12.5;
        _totalCountLabel.displaysAsynchronously = YES;
        _totalCountLabel.ignoreCommonProperties = YES;
        _totalCountLabel.fadeOnAsynchronouslyDisplay = NO;
        _totalCountLabel.fadeOnHighlight = NO;
        [self addSubview:_totalCountLabel];
        
        UIView *arrow = [UIView new];
        arrow.size = CGSizeMake(10, 10);
        arrow.centerY = _totalCountLabel.centerY;
        arrow.right = kDynamicCellContentWidth - 12.5;
        arrow.layer.contentMode = UIViewContentModeScaleAspectFit;
        arrow.layer.contents =
        (__bridge id)[UIImage imageNamed:@"gift_check"].CGImage;
        [self addSubview:arrow];
        
        UIView *line = [UIView new];
        line.backgroundColor = UIColorHex(f0e7c5);
        line.size = CGSizeMake(kDynamicCellContentWidth, 1);
        line.top = _totalCountLabel.bottom + 10;
        [self addSubview:line];
        
        CGFloat giftWidth = kScaleFrom_iPhone6_Desgin(50);
        CGFloat padding = (kDynamicCellContentWidth - 5 - giftWidth * 4) / 5.0;
        NSMutableArray *tempGifts = [NSMutableArray array];
        NSMutableArray *tempLabels = [NSMutableArray array];
        NSMutableArray *tempAvatars = [NSMutableArray array];
        for (NSInteger i = 0; i < 4; i++) {
            UIView *gift = [UIView new];
            gift.contentMode = UIViewContentModeScaleAspectFit;
            gift.frame = CGRectMake(2.5 + padding * (i + 1) + giftWidth * i,
                                    line.bottom + 10, giftWidth, giftWidth);
            [tempGifts addObject:gift];
            [self addSubview:gift];
            
            YYLabel *label = [YYLabel new];
            label.backgroundColor = UIColorHex(ffc000);
            label.size = CGSizeMake(giftWidth * 0.8, 14);
            label.fadeOnHighlight = NO;
            label.displaysAsynchronously = YES;
            label.fadeOnAsynchronouslyDisplay = NO;
            label.layer.cornerRadius = label.height / 2.0;
            label.centerX = gift.centerX;
            label.centerY = gift.bottom;
            label.textAlignment = NSTextAlignmentCenter;
            [tempLabels addObject:label];
            [self addSubview:label];
            
            CGFloat avatarWidth = kScaleFrom_iPhone6_Desgin(29);
            UIView *avatar = [UIView new];
            avatar.layer.contentMode = UIViewContentModeScaleAspectFit;
            avatar.size = CGSizeMake(avatarWidth, avatarWidth);
            avatar.top = label.bottom + 5;
            avatar.centerX = label.centerX;
            [tempAvatars addObject:avatar];
            [self addSubview:avatar];
        }
        _giftViews = tempGifts;
        _countLabels = tempLabels;
        _avatarViews = tempAvatars;
    }
    
    return self;
}

- (void)setWithLayout:(BBQDynamicLayout *)layout {
    for (NSInteger i = 0; i < 4; i++) {
        if (i < layout.dynamic.giftdata.count) {
            [self hideGiftViewAtIndex:i hide:NO];
            Gift *giftModel = layout.dynamic.giftdata[i];
            UIView *gift = _giftViews[i];
            @weakify(gift)
            [gift.layer setImageWithURL:[NSURL URLWithString:giftModel.imgurl] placeholder:[UIImage imageNamed:@"placeholder_gift"] options:YYWebImageOptionSetImageWithFadeAnimation completion:^(UIImage *image, NSURL *url, YYWebImageFromType from, YYWebImageStage stage, NSError *error) {
                @strongify(gift)
                if (error) {
                    gift.layer.contents = (__bridge id)[UIImage imageNamed:@"placeholder_gift"].CGImage;
                }
            }];
            
            UIView *avatar = _avatarViews[i];
            [avatar.layer setImageWithURL:[NSURL URLWithString:giftModel.fbztx] placeholder:Placeholder_avatar options:YYWebImageOptionSetImageWithFadeAnimation manager:[BBQDynamicHelper avatarImageManager] progress:nil transform:nil completion:nil];
            
            NSString *countStr =
            [NSString stringWithFormat:@"+%@", giftModel.giftcount];
            NSMutableAttributedString *text =
            [[NSMutableAttributedString alloc] initWithString:countStr];
            text.font = [UIFont systemFontOfSize:10];
            text.color = [UIColor whiteColor];
            text.alignment = NSTextAlignmentCenter;
            //            YYTextBorder *border = [YYTextBorder new];
            //            border.cornerRadius = 100;
            //            border.fillColor = UIColorHex(ffc000);
            //            text.textBackgroundBorder = border;
            [(YYLabel *)_countLabels[i] setAttributedText:text];
        } else {
            [self hideGiftViewAtIndex:i hide:YES];
        }
    }
    [self hideAvatar:layout.dynamic.dtype.integerValue != BBQDynamicGroupTypeBaby];
}

- (void)hideAvatar:(BOOL)hide {
    for (UIView *avatar in _avatarViews) {
        avatar.hidden = hide;
    }
}

- (void)hideGiftViewAtIndex:(NSInteger)index hide:(BOOL)hide {
    [(UIView *)_giftViews[index] setHidden:hide];
    [(YYLabel *)_countLabels[index] setHidden:hide];
    [(UIView *)_avatarViews[index] setHidden:hide];
}

@end

@implementation BBQDynamicToolbarView

- (instancetype)initWithFrame:(CGRect)frame {
    frame = CGRectMake(0, 0, kDynamicCellProfileWidth, kDynamicCellToolbarHeight);
    if (self = [super initWithFrame:frame]) {
        self.exclusiveTouch = YES;
        _topLine = [CALayer layer];
        _topLine.size = CGSizeMake(self.width, 1);
        _topLine.top = 5;
        _topLine.backgroundColor = UIColorHex(f5f5f5).CGColor;
        [self.layer addSublayer:_topLine];
        
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareButton.exclusiveTouch = YES;
        [_shareButton setTitle:@"分享" forState:UIControlStateNormal];
        [_shareButton setTitleColor:kDynamicCellTextSubTitleColor
                           forState:UIControlStateNormal];
        _shareButton.titleLabel.font =
        [UIFont systemFontOfSize:kDynamicCellTextSubTitleFontSize];
        [_shareButton setImage:[UIImage imageNamed:@"share"]
                      forState:UIControlStateNormal];
        _shareButton.size = CGSizeMake(79, self.height - _topLine.bottom);
        _shareButton.top = _topLine.bottom;
        [_shareButton addTarget:self action:@selector(didClickShareButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_shareButton];
        
        _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commentButton.exclusiveTouch = YES;
        [_commentButton setTitleColor:kDynamicCellTextSubTitleColor
                             forState:UIControlStateNormal];
        _commentButton.titleLabel.font =
        [UIFont systemFontOfSize:kDynamicCellTextSubTitleFontSize];
        [_commentButton setImage:[UIImage imageNamed:@"reply"]
                        forState:UIControlStateNormal];
        _commentButton.size = CGSizeMake(79, _shareButton.height);
        _commentButton.top = _shareButton.top;
        _commentButton.right = self.right;
        [_commentButton addTarget:self action:@selector(didClickCommentButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_commentButton];
    }
    return self;
}

- (void)didClickShareButton {
    if (self.cell.delegate && [self.cell.delegate respondsToSelector:@selector(didClickShareButtonWithCell:)]) {
        [self.cell.delegate didClickShareButtonWithCell:self.cell];
    }
}

- (void)didClickCommentButton {
    if (self.cell.delegate && [self.cell.delegate respondsToSelector:@selector(didClickCommentButtonWithCell:)]) {
        [self.cell.delegate didClickCommentButtonWithCell:self.cell];
    }
}

@end

@implementation BBQDynamicView {
    CALayer *_bgLayer, *_verticalLine;
    BOOL _trackingTouch;
}

- (instancetype)initWithFrame:(CGRect)frame {
    frame = CGRectMake(0, 0, kScreenWidth, 1);
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColorHex(f5f5f5);
        self.exclusiveTouch = YES;
        _dateView = [BBQDynamicDateView new];
        _verticalLine = [CALayer new];
        _verticalLine.backgroundColor = UIColorHex(eeeeee).CGColor;
        _verticalLine.width = 2;
        _verticalLine.centerX = _dateView.centerX;
        [self.layer addSublayer:_verticalLine];
        [self addSubview:_dateView];
        
        _contentView = [[UIView alloc]
                        initWithFrame:CGRectMake(65, 0, kDynamicCellProfileWidth, 1)];
        _contentView.backgroundColor = UIColorHex(f5f5f5);
        [self addSubview:_contentView];
        
        _bgLayer = [CALayer new];
        _bgLayer.shouldRasterize = YES;
        _bgLayer.rasterizationScale = [UIScreen mainScreen].scale;
        _bgLayer.cornerRadius = 5;
        _bgLayer.backgroundColor = [UIColor whiteColor].CGColor;
        _bgLayer.width = _contentView.width;
        _bgLayer.top = kDynamicCellTopMargin + kDynamicCellProfileHeight;
        [_contentView.layer addSublayer:_bgLayer];
        _profileView = [BBQDynamicProfileView new];
        [_contentView addSubview:_profileView];
        
        _tagView = [BBQDynamicTagView new];
        [_contentView addSubview:_tagView];
        
        _textLabel = [YYLabel new];
        _textLabel.left = kDynamicCellPadding;
        _textLabel.width = kDynamicCellContentWidth;
        _textLabel.textVerticalAlignment = YYTextVerticalAlignmentTop;
        _textLabel.displaysAsynchronously = YES;
        _textLabel.ignoreCommonProperties = YES;
        _textLabel.fadeOnAsynchronouslyDisplay = NO;
        _textLabel.fadeOnHighlight = NO;
        [_contentView addSubview:_textLabel];
        
        NSMutableArray *picViews = [NSMutableArray new];
        for (NSInteger i = 0; i < 9; i++) {
            UIView *imageView = [UIView new];
            if (i == 0) {
                UIImageView *videoImage = [UIImageView new];
                videoImage.image = [UIImage imageNamed:@"video_play"];
                videoImage.contentMode = UIViewContentModeCenter;
                [imageView addSubview:videoImage];
                videoImage.hidden = YES;
            }
            imageView.layer.contentMode = UIViewContentModeScaleAspectFill;
            imageView.size = CGSizeMake(100, 100);
            imageView.hidden = YES;
            imageView.clipsToBounds = YES;
            imageView.backgroundColor = UIColorHex(f5f5f5);
            imageView.exclusiveTouch = YES;
            @weakify(self)
            UITapGestureRecognizer *singleTap = [UITapGestureRecognizer bk_recognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
                @strongify(self)
                if ([self.cell.delegate
                     respondsToSelector:
                     @selector(cell:didClickMediaAtIndex:)]) {
                    [self.cell.delegate cell:self.cell didClickMediaAtIndex:i];
                }
            }];
            [imageView addGestureRecognizer:singleTap];
            [picViews addObject:imageView];
            [_contentView addSubview:imageView];
        }
        _mediaViews = picViews;
        
        _funcButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _funcButton.size =
        CGSizeMake(kDynamicCellFuncHeight, kDynamicCellFuncHeight);
        _funcButton.right = kDynamicCellProfileWidth - kDynamicCellPadding;
        [_funcButton setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
        [_funcButton addTarget:self action:@selector(didClickFuncButton) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:_funcButton];
        
        _giftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _giftButton.size =
        CGSizeMake(kDynamicCellFuncHeight, kDynamicCellFuncHeight);
        [_giftButton addTarget:self action:@selector(didClickGiftButton) forControlEvents:UIControlEventTouchUpInside];
        _giftButton.right = _funcButton.left - 15;
        [_giftButton setImage:[UIImage imageNamed:@"gift_button"] forState:UIControlStateNormal];
        [_contentView addSubview:_giftButton];
        
        _giftView = [BBQDynamicGiftView new];
        [_contentView addSubview:_giftView];
        
        _commentTableView = [[UITableView alloc] initWithFrame:CGRectMake(kDynamicCellPadding, 0, kDynamicCellContentWidth, 1) style:UITableViewStylePlain];
        _commentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _commentTableView.scrollEnabled = NO;
        [_commentTableView setBackgroundView:nil];
        [_commentTableView setBackgroundColor:[UIColor whiteColor]];
        [_commentTableView registerClass:[BBQDynamicCommentCell class] forCellReuseIdentifier:kDynamicCommentCellIdentifier];
        _commentTableView.dataSource = self;
        _commentTableView.delegate = self;
        [self.contentView addSubview:_commentTableView];
        
        _toolbarView = [BBQDynamicToolbarView new];
        [_contentView addSubview:_toolbarView];
    }
    
    return self;
}

- (void)didClickGiftButton {
    if ([self.cell.delegate respondsToSelector:@selector(didClickGiftButtonWithCell:)]) {
        [self.cell.delegate didClickGiftButtonWithCell:self.cell];
    }
}

- (void)showDateView:(BOOL)show {
    self.dateView.hidden = !show;
}

- (void)didClickFuncButton {
    if (self.cell.delegate && [self.cell.delegate respondsToSelector:@selector(didClickFuncButton:withCell:)]) {
        [self.cell.delegate didClickFuncButton:_funcButton withCell:self.cell];
    }
}

- (void)setLayout:(BBQDynamicLayout *)layout {
    _layout = layout;
    BOOL hidden = layout.style == BBQDynamicStyleWelcome;
    _giftButton.hidden = hidden;
    _funcButton.hidden = hidden;
    _toolbarView.hidden = hidden;

    self.height = layout.height;
    _contentView.height = layout.height;
    _verticalLine.height = self.height;
    
    CGFloat top = kDynamicCellTopMargin;
    _dateView.dateLabel.textLayout = layout.dateLayout;
    
    if (layout.dynamic.ispajs.integerValue == 1) {
        UIImage *image = [UIImage imageNamed:@"panda_head"];
        UIImage *newImage = [BBQDynamicHelper avatarImageManager].sharedTransformBlock(image, nil);
        _profileView.avatarView.image = newImage;
    } else {
        [_profileView.avatarView setImageWithURL:[NSURL URLWithString:layout.dynamic.fbztx] placeholder:Placeholder_avatar
                                         options:YYWebImageOptionSetImageWithFadeAnimation
                                         manager:[BBQDynamicHelper avatarImageManager]
                                        progress:nil
                                       transform:nil
                                      completion:nil];
    }
    
    _profileView.nameLabel.textLayout = layout.nameTextLayout;
    _profileView.sourceLabel.textLayout = layout.sourceTextLayout;
    _profileView.cell = layout.cell;
    
    switch (layout.dynamic.uploadState) {
        case BBQDynamicUploadStateSuccess: {
            _profileView.postTimeLabel.hidden = NO;
            _profileView.postTimeLabel.textLayout = layout.postTimeTextLayout;
            _profileView.warningView.hidden = YES;
            [_profileView.indicator stopAnimating];
            break;
        }
        case BBQDynamicUploadStateWaiting:
        case BBQDynamicUploadStateUploading: {
            _profileView.postTimeLabel.hidden = YES;
            _profileView.warningView.hidden = YES;
            _profileView.indicator.hidden = NO;
            [_profileView.indicator startAnimating];
            break;
        }
        case BBQDynamicUploadStateFail: {
            _profileView.postTimeLabel.hidden = YES;
            _profileView.warningView.hidden = NO;
            [_profileView.indicator stopAnimating];
            break;
        }
    }
    
    _profileView.height = layout.profileHeight;
    top += layout.profileHeight;
    
    if (layout.tagHeight) {
        _tagView.hidden = NO;
        _tagView.height = layout.tagHeight;
        [_tagView setWithLayout:layout];
        _tagView.top = top;
        top += layout.tagHeight;
        _tagView.tagLabel.textLayout = layout.tagTextLayout;
    } else {
        _tagView.hidden = YES;
    }
    
    _textLabel.top = top;
    _textLabel.height = layout.textHeight;
    _textLabel.textLayout = layout.textLayout;
    top += layout.textHeight;
    
    if ((!layout.tagHeight && !layout.textHeight) || (layout.tagHeight && !layout.textHeight)) {
        top += 15;
    }
    
    if (layout.mediaType != BBQDynamicMediaTypeNone) {
        [self setImageViewWithTop:top];
        top += layout.mediaHeight;
    } else {
        [self hideImageViews];
    }
    
    _giftButton.top = top;
    _funcButton.top = top;
    top += kDynamicCellFuncHeight;
    
    if (layout.giftHeight > 0) {
        _giftView.hidden = NO;
        _giftView.top = top;
        _giftView.height = layout.giftHeight;
        _giftView.totalCountLabel.textLayout = layout.giftTextLayout;
        [_giftView setWithLayout:layout];
        top += layout.giftHeight;
    } else {
        _giftView.hidden = YES;
    }
    
    if (layout.commentHeight > 0) {
        _commentTableView.hidden = NO;
        _commentTableView.top = top;
        _commentTableView.height = layout.commentHeight;
        [_commentTableView reloadData];
        top += layout.commentHeight;
    } else {
        _commentTableView.hidden = YES;
    }
    
    _toolbarView.top = top;
    NSInteger commentCount = _layout.dynamic.reply.count;
    NSString *commentButtonTitle = @"评论";
    if (commentCount) {
        commentButtonTitle = [NSString stringWithFormat:@"评论(%@)", @(commentCount)];
    }
    [_toolbarView.commentButton setTitle:commentButtonTitle forState:UIControlStateNormal];
    
    top += layout.toolbarHeight;
    _bgLayer.height = layout.height - kDynamicCellProfileHeight - kDynamicCellTopMargin - kDynamicCellToolbarBottomMargin;
}

- (void)setImageViewWithTop:(CGFloat)imageTop {
    CGSize mediaSize = _layout.mediaSize;
    NSArray *media = _layout.dynamic.attachinfo;
    NSInteger mediaCount = media.count;
    
    for (NSInteger i = 0; i < 9; i++) {
        UIView *imageView = _mediaViews[i];
        if (i >= mediaCount) {
            [imageView.layer cancelCurrentImageRequest];
            imageView.hidden = YES;
        } else {
            CGPoint origin = {0};
            switch (mediaCount) {
                case 1: {
                    origin.x = kDynamicCellPadding;
                    origin.y = imageTop;
                } break;
                case 2: case 3: case 4: {
                    origin.x = kDynamicCellPadding +
                    (i % 2) * (mediaSize.width + kDynamicCellPaddingPic);
                    origin.y =
                    imageTop + (i / 2) * (mediaSize.height + kDynamicCellPaddingPic);
                } break;
                default: {
                    origin.x = kDynamicCellPadding +
                    (i % 3) * (mediaSize.width + kDynamicCellPaddingPic);
                    origin.y =
                    imageTop + (i / 3) * (mediaSize.height + kDynamicCellPaddingPic);
                } break;
            }
            imageView.frame = (CGRect){.origin = origin, .size = mediaSize};
            imageView.hidden = NO;
            [imageView.layer removeAnimationForKey:@"contents"];
            
            Attachment *mediaModel = media[i];
            if (![mediaModel.filepath isNotBlank]) {
                continue;
            }
            
            NSString *picURLStr;
            NSURL *picURL;
            CGFloat scale = [UIScreen mainScreen].scale;
            
            if (mediaModel.itype.integerValue == BBQAttachmentTypePhoto) {
                picURLStr = mediaModel.filepath;
            } else {
                picURLStr = mediaModel.thumbpath;
            }
            
            if ([mediaModel.remote isEqualToNumber:@1]) {
                picURL = [NSURL URLWithString:picURLStr];
            } else if ([mediaModel.remote isEqualToNumber:@2]) {
                picURLStr = [picURLStr stringByAppendingFormat:@"?imageView2/1/w/%.0f/h/%.0f", imageView.width * scale,
                             imageView.height * scale];
                picURL = [NSURL URLWithString:picURLStr];
            } else {
                picURL = [[NSURL alloc] initFileURLWithPath:picURLStr];
            }
            
            @weakify(imageView)
            @weakify(mediaModel)
            [imageView.layer
             setImageWithURL:picURL
             placeholder:[UIImage
                          imageNamed:@"placeholder_white_loading"]
             options:YYWebImageOptionAvoidSetImage
             completion:^(UIImage *image, NSURL *url, YYWebImageFromType from,
                          YYWebImageStage stage, NSError *error) {
                 @strongify(imageView)
                 @strongify(mediaModel)
                 if (!imageView)
                     return;
                 if (error) {
                     imageView.layer.contents = (__bridge id)[UIImage imageNamed:@"placeholder_white_error"].CGImage;
                     UIView *videoImage = imageView.subviews.firstObject;
                     videoImage.hidden = YES;
                 } else if (image && stage == YYWebImageStageFinished) {
                     imageView.layer.contents = (__bridge id)image.CGImage;
                     if (i == 0) {
                         UIView *videoImage = imageView.subviews.firstObject;
                         videoImage.size = imageView.size;
                         videoImage.hidden = !mediaModel.itype.boolValue;
                     }
                     if (from != YYWebImageFromMemoryCacheFast) {
                         CATransition *transition = [CATransition animation];
                         transition.duration = 0.15;
                         transition.timingFunction = [CAMediaTimingFunction
                                                      functionWithName:kCAMediaTimingFunctionEaseOut];
                         transition.type = kCATransitionFade;
                         [imageView.layer addAnimation:transition
                                                forKey:@"contents"];
                     }
                 }
             }];
        }
    }
}

- (void)hideImageViews {
    for (UIView *view in _mediaViews) {
        view.hidden = YES;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    _trackingTouch = NO;
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView:self];
    CALayer *layer = [_bgLayer hitTest:p];
    if (layer == _bgLayer) {
        _trackingTouch = YES;
    }
    if (!_trackingTouch) {
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!_trackingTouch) {
        [super touchesEnded:touches withEvent:event];
    } else {
        if ([self.cell.delegate respondsToSelector:@selector(didClickWhiteSpaceWithCell:)] && self.cell.layout.style != BBQDynamicStyleWelcome) {
            [self.cell.delegate didClickWhiteSpaceWithCell:self.cell];
        }
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!_trackingTouch) {
        [super touchesCancelled:touches withEvent:event];
    }
}

#pragma mark - Comment Table View DataSource
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return _layout.commentTextLayouts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BBQDynamicCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:kDynamicCommentCellIdentifier forIndexPath:indexPath];
    cell.delegate = self.cell.delegate;
    cell.layout = _layout.commentTextLayouts[indexPath.row];
    @weakify(self)
    UILongPressGestureRecognizer *longPress = [UILongPressGestureRecognizer bk_recognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        @strongify(self)
        if (state == UIGestureRecognizerStateBegan) {
            if ([cell.delegate respondsToSelector:@selector(cell:didLongPressCommentCell:)]) {
                [cell.delegate cell:self.cell didLongPressCommentCell:cell];
            }
        }
    }];
    [cell.contentView addGestureRecognizer:longPress];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ((BBQDynamicCommentLayout *)_layout.commentTextLayouts[indexPath.row]).height;
}

#pragma mark - Comment Table View DataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    BBQDynamicCommentCell *commentCell = [tableView cellForRowAtIndexPath:indexPath];
    if ([self.cell.delegate respondsToSelector:@selector(cell:didClickCommentCell:)]) {
        [self.cell.delegate cell:self.cell didClickCommentCell:commentCell];
    }
}



@end

@implementation BBQDynamicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _dynamicView = [BBQDynamicView new];
        [self.contentView addSubview:_dynamicView];
    }
    return self;
}

- (void)setLayout:(BBQDynamicLayout *)layout {
    _layout = layout;
    self.height = layout.height;
    layout.cell = self;
    _dynamicView.cell = self;
    _dynamicView.profileView.cell = self;
    _dynamicView.giftView.cell = self;
    _dynamicView.toolbarView.cell = self;
    self.contentView.height = layout.height;
    _dynamicView.layout = layout;
    _dynamic = layout.dynamic;
}

@end
