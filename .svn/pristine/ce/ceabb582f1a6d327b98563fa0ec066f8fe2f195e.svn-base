//
//  DetailCommentCell.m
//  BBQ
//
//  Created by anymuse on 15/7/21.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "DetailCommentCell.h"
#import "Comment.h"
#import <DateTools.h>
#import "NSString+Common.h"

static NSInteger const kButtonBaseIndex = 2007;
@implementation DetailCommentCell

- (void)awakeFromNib {
    // Initialization code
    self.replierHeadView.layer.masksToBounds = YES;
    self.replierHeadView.layer.cornerRadius =
    CGRectGetHeight(self.replierHeadView.frame) / 2;
    [self.commentButton addTarget:self
                           action:@selector(didClickCommentButton)
                 forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *headTap = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(didTapOnUserHeadView:)];
    self.replierHeadView.userInteractionEnabled = YES;
    [self.replierHeadView addGestureRecognizer:headTap];
    
    UITapGestureRecognizer *nameTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(nameTapEvent:)];
    self.replierNicknameLabel.userInteractionEnabled = YES;
    [self.replierNicknameLabel addGestureRecognizer:nameTap];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setModel:(Comment *)model {
    _model = model;
    self.commentButton.tag = kButtonBaseIndex + self.indexPath.row;
    
    if (model.groupkey.integerValue == BBQGroupkeyTypeParent) {
        NSString *relation = [NSString relationshipWithID:model.gxid gxname:model.gxname];
        self.replierNicknameLabel.text =
        [model.baobaoname stringByAppendingString:relation];
    } else if (model.groupkey.integerValue != BBQGroupkeyTypeParent) {
        self.replierNicknameLabel.text = model.nickname;
    }
    self.replyTimeLabel.text = [NSDate
                                timeAgoSinceDate:
                                [NSDate dateWithTimeIntervalSince1970:model.dateline.integerValue]];
    
    if (!model.flag) {
        self.contentLabel.dataDetectorTypes = MLDataDetectorTypeAttributedLink;
        self.contentLabel.linkTextAttributes = @{
                                                 NSForegroundColorAttributeName : [UIColor colorWithHexString:@"ff6440"]
                                                 };
        self.contentLabel.delegate = self;
        if (model.isreplay) {
            NSString *content = @"";
            NSMutableAttributedString *attributedContent = nil;
            content = [NSString
                       stringWithFormat:@"回复 %@ ：%@", model.regxname, model.content];
            attributedContent =
            [[NSMutableAttributedString alloc] initWithString:content];
            [attributedContent addAttribute:NSLinkAttributeName
                                      value:model.reuid
                                      range:[content rangeOfString:model.regxname]];
            self.contentLabel.attributedText = attributedContent;
        } else {
            self.contentLabel.text = model.content;
        }
    }
}

- (void)loadImages {
    [self.replierHeadView setImageWithURL:[NSURL URLWithString:self.model.fbztx] placeholder:Placeholder_avatar];
}

#pragma mark - Cell Delegate
- (void)didClickCommentButton {
    if (self.delegate &&
        [self.delegate
         respondsToSelector:@selector(didClickCommentButtonAtIndexPath:)]) {
            [self.delegate didClickCommentButtonAtIndexPath:self.indexPath];
        }
}

- (void)didLongPressNonLinkAreaInLinkLabel:(MLLinkLabel *)linkLabel {
    if (self.delegate &&
        [self.delegate
         respondsToSelector:@selector(didLongPressCommentLabelAtIndexPath:)]) {
            [self.delegate didLongPressCommentLabelAtIndexPath:self.indexPath];
        }
}

- (void)didTapOnUserHeadView:(UITapGestureRecognizer *)recognizer {
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(didClickUserWithID:)]) {
        [self.delegate didClickUserWithID:self.model.uid];
    }
}

- (void)nameTapEvent:(UITapGestureRecognizer *)tap {
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(didClickUserWithID:)]) {
        [self.delegate didClickUserWithID:self.model.uid];
    }
}

- (void)didClickLink:(MLLink *)link
            linkText:(NSString *)linkText
           linkLabel:(MLLinkLabel *)linkLabel {
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(didClickUserWithID:)]) {
        [self.delegate didClickUserWithID:[link.linkValue numberValue]];
    }
}

@end
