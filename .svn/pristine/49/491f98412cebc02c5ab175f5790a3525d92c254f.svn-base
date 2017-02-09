//
//  BBQDynamicCommentLayout.m
//  BBQ
//
//  Created by 朱琨 on 15/11/26.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQDynamicCommentLayout.h"
#import "BBQTextLinePositionModifier.h"

@implementation BBQDynamicCommentLayout

- (instancetype)initWithComment:(Comment *)comment style:(BBQDynamicStyle)style {
    if (self = [super init]) {
        _comment = comment;
        _style = style;
        [self layout];
    }
    return self;
}

- (void)layout {
    if (_style == BBQDynamicStyleTimeline) {
        [self layoutTimelineStyle];
    } else {
        [self layoutDetailStyle];
    }
}

- (void)layoutTimelineStyle {
    _textLayout = nil;
    _height = 0;
    
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    
    NSString *username = @"";
    if (_comment.groupkey.integerValue == BBQGroupkeyTypeParent && [_comment.baobaoname isNotBlank]) {
        username = [_comment.baobaoname
                    stringByAppendingString:_comment.gxname];
    } else {
        username = _comment.nickname;
    }
    NSMutableAttributedString *usernameText = [[NSMutableAttributedString alloc] initWithString:username];
    
    YYTextBorder *highlightBorder = [YYTextBorder new];
    highlightBorder.strokeWidth = 0;
    highlightBorder.strokeColor = [UIColor lightGrayColor];
    highlightBorder.fillColor = [UIColor lightGrayColor];
    
    usernameText.font = [UIFont systemFontOfSize:kDynamicCellNormalFontSize];
    usernameText.color = UIColorHex(ff6440);
    YYTextHighlight *usernameHighlight = [YYTextHighlight new];
    [usernameHighlight setBackgroundBorder:highlightBorder];
    @weakify(self)
    usernameHighlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        @strongify(self)
        if (self.delegate && [self.delegate respondsToSelector:@selector(didClickUserWithID:)]) {
            [self.delegate didClickUserWithID:self.comment.uid];
        }
    };
    [usernameText setTextHighlight:usernameHighlight range:usernameText.rangeOfAll];
    [text appendAttributedString:usernameText];
    
    if (_comment.isreplay) {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@" 回复 "];
        str.font = [UIFont systemFontOfSize:kDynamicCellNormalFontSize];
        str.color = kDynamicCellTextNormalColor;
        [text appendAttributedString:str];
        
        NSMutableAttributedString *reUsernameText = [[NSMutableAttributedString alloc] initWithString:_comment.regxname];
        reUsernameText.font = [UIFont systemFontOfSize:kDynamicCellNormalFontSize];
        reUsernameText.color = UIColorHex(ff6440);
        YYTextHighlight *reUsernameHight = [YYTextHighlight new];
        [reUsernameHight setBackgroundBorder:highlightBorder];
        @weakify(self)
        reUsernameHight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
            @strongify(self)
            if (self.delegate && [self.delegate respondsToSelector:@selector(didClickUserWithID:)]) {
                [self.delegate didClickUserWithID:self.comment.reuid];
            }
        };
        [reUsernameText setTextHighlight:reUsernameHight range:reUsernameText.rangeOfAll];
        [text appendAttributedString:reUsernameText];
    }
    
    NSMutableAttributedString *contentText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"：%@", _comment.content]];
    contentText.font = [UIFont systemFontOfSize:kDynamicCellNormalFontSize];
    contentText.color = kDynamicCellTextNormalColor;
    [text appendAttributedString:contentText];
    text.lineSpacing = 5;
    
    BBQTextLinePositionModifier *modifier = [BBQTextLinePositionModifier new];
    modifier.font = [UIFont fontWithName:@"Heiti SC" size:kDynamicCellNormalFontSize];
    modifier.paddingTop = 5;
    modifier.paddingBottom = 7.5;
    
    YYTextContainer *container = [YYTextContainer new];
    container.size = CGSizeMake(kDynamicCellContentWidth - 31.5, HUGE);
    container.linePositionModifier = modifier;
    
    _textLayout = [YYTextLayout layoutWithContainer:container text:text];
    _height = MAX(31.5, CGFloatPixelRound([modifier heightForLineCount:_textLayout.lines.count]));
}

- (void)layoutDetailStyle {
    
}

@end
