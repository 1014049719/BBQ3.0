//
//  BBQDynamicLayout.m
//  BBQ
//
//  Created by 朱琨 on 15/11/17.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQDynamicLayout.h"
#import "BBQDynamicHelper.h"
#import <DateTools.h>
#import "BBQTextLinePositionModifier.h"
#import "BBQDynamicCommentLayout.h"
#import "NSString+Common.h"
#import "BBQDynamicCell.h"

static NSArray * reportTagType = nil;

@implementation BBQDynamicLayout

- (instancetype)initWithDynamic:(Dynamic *)dynamic style:(BBQDynamicStyle)style {
    if (self = [super init]) {
        _dynamic = dynamic;
        _style = style;
        if (!reportTagType) {
            reportTagType = @[@2, @3, @4, @5];
        }
        [self layoutWithStyle:style];
    }
    return self;
}

- (void)layout {
    [self layoutWithStyle:_style];
}

- (void)layoutWithStyle:(BBQDynamicStyle)style {
    switch (style) {
        case BBQDynamicStyleTimeline: {
            [self layoutTimelineStyle];
            break;
        }
        case BBQDynamicStyleDetail: {
            [self layoutDetailStyle];
            break;
        }
        case BBQDynamicStyleWelcome: {
            [self layoutWelcomeStyle];
            break;
        }
    }
}

- (void)layoutTimelineStyle {
    _marginTop = kDynamicCellTopMargin;
    _tagHeight = 0;
    _textHeight = 0;
    _mediaHeight = 0;
    _funcHeight = kDynamicCellFuncHeight;
    _giftHeight = 0;
    _commentHeight = 0;
    _marginBottom = kDynamicCellToolbarBottomMargin;
    
    [self layoutDateView];
    [self layoutProfile];
    [self layoutTag];
    [self layoutText];
    [self layoutMedia];
    [self layoutGifts];
    [self layoutComments];
    [self layoutToolbar];
    
    _height = 0;
    _height += _marginTop;
    _height += _profileHeight;
    _height += _tagHeight;
    _height += _textHeight;
    _height += _mediaHeight;
    _height += kDynamicCellFuncHeight;
    _height += _giftHeight;
    _height += _commentHeight;
    _height += _toolbarHeight;
    _height += _marginBottom;
    if ((!_tagHeight && !_textHeight) || (_tagHeight && !_textHeight)) {
        _height += 15;
    }
}

- (void)layoutDetailStyle {
    
}

- (void)layoutWelcomeStyle {
    _marginTop = kDynamicCellTopMargin;
    _tagHeight = 0;
    _textHeight = 0;
    _mediaHeight = 0;
    _funcHeight = kDynamicCellFuncHeight;
    _giftHeight = 0;
    _commentHeight = 0;
    _marginBottom = kDynamicCellToolbarBottomMargin;
    
    [self layoutDateView];
    [self layoutProfile];
    [self layoutText];
    
    _height = 0;
    _height += _marginTop;
    _height += _profileHeight;
    _height += _textHeight;
    _height += _marginBottom;
    if ((!_tagHeight && !_textHeight) || (_tagHeight && !_textHeight)) {
        _height += 15;
    }
}

- (void)layoutDateView {
    _dateLayout = nil;
    if (!_dynamic.graphtime || !_dynamic.graphtime.integerValue) return;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_dynamic.graphtime.integerValue];
    NSInteger day = date.day;
    NSInteger month = date.month;
    NSInteger year = date.year;
    
    NSMutableAttributedString *dateText = [NSMutableAttributedString new];
    
    NSMutableAttributedString *dayText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%02ld", (long)day]];
    dayText.font = [UIFont boldSystemFontOfSize:18];
    dayText.color = UIColorHex(999999);
    [dateText appendAttributedString:dayText];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"日"];
    str.font = [UIFont systemFontOfSize:10];
    str.color = UIColorHex(999999);
    [dateText appendAttributedString:str];
    
    [dateText appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"\n"]];
    
    NSMutableAttributedString *monthText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld.%02ld", (long)year, (long)month]];
    monthText.font = [UIFont systemFontOfSize:10];
    monthText.color = [UIColor whiteColor];
    [dateText appendAttributedString:monthText];
    
    dateText.lineSpacing = 3;
    dateText.alignment = NSTextAlignmentCenter;
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(45, MAXFLOAT)];
    container.maximumNumberOfRows = 2;
    _dateLayout = [YYTextLayout layoutWithContainer:container text:dateText];
}

- (void)layoutProfile {
    [self layoutName];
    [self layoutSource];
    [self layoutPostTime];
    _profileHeight = kDynamicCellProfileHeight;
}

- (void)layoutName {
    NSString *nameStr = nil;
    if (_dynamic.ispajs.integerValue == 1) {
        nameStr = @"小宝";
    } else if ([reportTagType containsObject:_dynamic.ispajs]) {
        nameStr = _dynamic.crenickname;
    } else {
        if (_dynamic.groupkey.integerValue == BBQGroupkeyTypeParent) {
            NSString *strRelation =
            [NSString relationshipWithID:_dynamic.gxid gxname:_dynamic.gxname];
            if (strRelation && strRelation.length) {
                nameStr =
                [_dynamic.baobaoname stringByAppendingString:strRelation];
            } else {
                nameStr = _dynamic.crenickname;
            }
        } else {
            nameStr = _dynamic.crenickname;
        }
    }
    if (!nameStr || !nameStr.length) {
        _nameTextLayout = nil;
        return;
    }
    NSMutableAttributedString *nameText = [[NSMutableAttributedString alloc] initWithString:nameStr];
    nameText.font = [UIFont systemFontOfSize:kDynamicCellNameFontSize];
    nameText.color = kDynamicCellTextNormalColor;
    nameText.lineBreakMode = NSLineBreakByCharWrapping;
    
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kDynamicCellNameWidth, MAXFLOAT)];
    container.maximumNumberOfRows = 1;
    _nameTextLayout = [YYTextLayout layoutWithContainer:container text:nameText];
}

- (void)layoutSource {
    NSString *sourceStr = nil;
    if (_dynamic.ispajs.integerValue == 1) {
        sourceStr = @"宝宝圈小管家";
    } else if (_dynamic.ispajs.integerValue == 3) {
        sourceStr = _dynamic.schoolname;
    } else if ([reportTagType containsObject:_dynamic.ispajs]) {
        sourceStr = _dynamic.classname;
    } else {
        if (_dynamic.groupkey.integerValue == BBQGroupkeyTypeTeacher) {
            sourceStr = _dynamic.classname;
        } else if (_dynamic.groupkey.integerValue == BBQGroupkeyTypeMaster) {
            sourceStr = _dynamic.schoolname;
        } else {
            sourceStr = _dynamic.crenickname;
        }
    }
    if (!sourceStr || !sourceStr.length) {
        _sourceTextLayout = nil;
        return;
    }
    NSMutableAttributedString *sourceText = [[NSMutableAttributedString alloc] initWithString:sourceStr];
    sourceText.font = [UIFont systemFontOfSize:kDynamicCellSourceFontSize];
    sourceText.color = kDynamicCellTextSubTitleColor;
    sourceText.lineBreakMode = NSLineBreakByCharWrapping;
    
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(150, MAXFLOAT)];
    container.maximumNumberOfRows = 1;
    _sourceTextLayout = [YYTextLayout layoutWithContainer:container text:sourceText];
}

- (void)layoutPostTime {
    _postTimeTextLayout = nil;
    if (!_dynamic.dateline || !_dynamic.dateline.integerValue) return;
    NSString *postTimeStr = [NSString
                             stringWithFormat:
                             @"发表于%@",
                             [NSDate timeAgoSinceDate:[NSDate dateWithTimeIntervalSince1970:
                                                       _dynamic.dateline.integerValue]]];
    if (postTimeStr) {
        NSMutableAttributedString *postTimeText = [[NSMutableAttributedString alloc] initWithString:postTimeStr];
        postTimeText.font = [UIFont systemFontOfSize:kDynamicCellSourceFontSize];
        postTimeText.color = kDynamicCellTextSubTitleColor;
        postTimeText.lineBreakMode = NSLineBreakByCharWrapping;
        postTimeText.alignment = NSTextAlignmentRight;
        
        YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(150, MAXFLOAT)];
        container.maximumNumberOfRows = 1;
        _postTimeTextLayout = [YYTextLayout layoutWithContainer:container text:postTimeText];
    }
}

- (void)layoutTag {
    _tagType = BBQDynamicTagTypeNone;
    _tagHeight = 0;
    _tagTextLayout = nil;
    if (![_dynamic.dynatag isNotBlank]) return;
    if (_dynamic.ispajs.integerValue == BBQDynamicContentTypeNormal) {
        _tagType = BBQDynamicTagTypeFirst;
        NSString *tagStr = _dynamic.dynatag;
        NSMutableAttributedString *tagText = [[NSMutableAttributedString alloc] initWithString:tagStr];
        tagText.font = [UIFont systemFontOfSize:kDynamicCellNormalFontSize];
        tagText.color = kDynamicCellTagFirstColor;
        tagText.lineBreakMode = NSLineBreakByCharWrapping;
        
        BBQTextLinePositionModifier *modifier = [BBQTextLinePositionModifier new];
        modifier.font = [UIFont fontWithName:@"Heiti SC" size:kDynamicCellNormalFontSize];
        
        YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kDynamicCellProfileWidth - kDynamicCellPadding * 2 - 24 - 5, HUGE)];
        container.linePositionModifier = modifier;
        _tagTextLayout = [YYTextLayout layoutWithContainer:container text:tagText];
        _tagPicName = @"dynamic_create_first_selected";
        _tagHeight = MAX([modifier heightForLineCount:_tagTextLayout.lines.count] + 15, 39);
    } else if ([reportTagType containsObject:_dynamic.ispajs]) {
        _tagType = BBQDynamicTagTypeReport;
        NSString *imageName = nil;
        NSString *tagStr = _dynamic.dynatag;
        UIColor *color = nil;
        
        if (_dynamic.ispajs.integerValue == 2) {
            if ([_dynamic.dynatag isEqualToString:@"早餐"]) {
                imageName = @"dailyreport_breakfast";
                color = kDynamicCellTagBreakfastColor;
            } else if ([_dynamic.dynatag isEqualToString:@"午餐"]) {
                imageName = @"dailyreport_lunch";
                color = kDynamicCellTagLunchColor;
            } else if ([_dynamic.dynatag isEqualToString:@"午睡"]) {
                imageName = @"dailyreport_noonbreak";
                color = kDynamicCellTagNoonbreakColor;
            } else if ([_dynamic.dynatag isEqualToString:@"喝水"]) {
                imageName = @"dailyreport_drinking";
                color = kDynamicCellTagDrinkingColor;
            } else if ([_dynamic.dynatag isEqualToString:@"学习"]) {
                imageName = @"dailyreport_study";
                color = kDynamicCellTagStudyColor;
            } else if ([_dynamic.dynatag isEqualToString:@"情绪"]) {
                imageName = @"dailyreport_emotion";
                color = kDynamicCellTagEmotionColor;
            } else if ([_dynamic.dynatag isEqualToString:@"健康"]) {
                imageName = @"dailyreport_health";
                color = kDynamicCellTagHealthColor;
            } else if ([_dynamic.dynatag isEqualToString:@"寄语"]) {
                imageName = @"dailyreport_words";
                color = kDynamicCellTagWordsColor;
            }
        } else if (_dynamic.ispajs.integerValue == 3) {
            tagStr = @"校园公告";
            imageName = @"dailyreport_message";
            color = kDynamicCellTagMessageColor;
        } else if (_dynamic.ispajs.integerValue == 4) {
            tagStr = @"班级公告";
            imageName = @"dailyreport_message";
            color = kDynamicCellTagMessageColor;
        } else if (_dynamic.ispajs.integerValue == 5) {
            tagStr = @"布置作业";
            imageName = @"dailyreport_homework";
            color = kDynamicCellTagHomeworkColor;
        } else {
            tagStr = @"教职工公告";
            imageName = @"dailyreport_message";
            color = kDynamicCellTagMessageColor;
        }

        NSMutableAttributedString *tagText = [[NSMutableAttributedString alloc] initWithString:tagStr];
        tagText.font = [UIFont systemFontOfSize:kDynamicCellNormalFontSize];
        tagText.color = color;
        tagText.lineBreakMode = NSLineBreakByCharWrapping;
        
        YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kDynamicCellProfileWidth - 46, 16)];
        container.maximumNumberOfRows = 1;
        _tagTextLayout = [YYTextLayout layoutWithContainer:container text:tagText];
        _tagColor = color;
        _tagPicName = imageName;
        _tagHeight = kDynamicCellTagReportHeight;
    }
}

- (void)layoutText {
    _textHeight = 0;
    _textLayout = nil;
    if (![_dynamic.content isNotBlank] && !_dynamic.fb_flag) return;
    CGFloat topPadding = 7.5;
    if (![_dynamic.dynatag isNotBlank]) {
        topPadding = 15;
    }
    
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    if (_dynamic.fb_flag) {
        NSMutableAttributedString *preString = [[NSMutableAttributedString alloc] initWithString:@"转发于"];
        preString.font = [UIFont systemFontOfSize:kDynamicCellNormalFontSize];
        preString.color = kDynamicCellTextNormalColor;
        
        [text appendAttributedString:preString];
        NSMutableAttributedString *usernameText = [[NSMutableAttributedString alloc] initWithString:_dynamic.oldcrenickname];
        
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
            if ([self.cell.delegate respondsToSelector:@selector(didClickUserWithID:)]) {
                [self.cell.delegate didClickUserWithID:self.dynamic.oldcreuid];
            }
        };
        [usernameText setTextHighlight:usernameHighlight range:usernameText.rangeOfAll];
        [text appendAttributedString:usernameText];
        [text appendString:@"：\n"];
    }
    NSMutableAttributedString *contentText = [[NSMutableAttributedString alloc] initWithString: _dynamic.content];
    contentText.font = [UIFont systemFontOfSize:kDynamicCellNormalFontSize];
    contentText.color = kDynamicCellTextNormalColor;
    [text appendAttributedString:contentText];
    text.lineBreakMode = NSLineBreakByCharWrapping;
    
    BBQTextLinePositionModifier *modifier = [BBQTextLinePositionModifier new];
    modifier.font = [UIFont fontWithName:@"Heiti SC" size:kDynamicCellNormalFontSize];
    modifier.paddingTop = topPadding;
    modifier.paddingBottom = 15;
    
    YYTextContainer *container = [YYTextContainer new];
    container.size = CGSizeMake(kDynamicCellContentWidth, HUGE);
    container.linePositionModifier = modifier;
    
    _textLayout = [YYTextLayout layoutWithContainer:container text:text];
    if (!_textLayout) return;
    _textHeight = [modifier heightForLineCount:_textLayout.rowCount];
}

- (void)layoutMedia {
    _mediaSize = CGSizeZero;
    _mediaHeight = 0;
    if (!_dynamic.attachinfo.count) {
        _mediaType = BBQDynamicMediaTypeNone;
        return;
    }
    _mediaType = BBQDynamicMediaTypePhoto;
    CGSize mediaSize = CGSizeZero;
    CGFloat mediaHeight = 0;
    switch (_dynamic.attachinfo.count) {
        case 1: {
            Attachment *model = _dynamic.attachinfo.firstObject;
            if (model.itype.integerValue == BBQAttachmentTypeVideo) {
                _mediaType = BBQDynamicMediaTypeVideo;
                mediaHeight = CGFloatPixelRound(kDynamicCellContentWidth * 3 / 4.0);
                mediaSize = CGSizeMake(kDynamicCellContentWidth, mediaHeight);
            } else {
                mediaHeight = CGFloatPixelRound(kDynamicCellContentWidth * 7 / 6.0);
                mediaSize = CGSizeMake(kDynamicCellContentWidth, mediaHeight);
            }
        } break;
        case 2: {
            mediaHeight = CGFloatPixelRound((kDynamicCellContentWidth - kDynamicCellPaddingPic) / 2.0);
            mediaSize = CGSizeMake(mediaHeight, mediaHeight);
        } break;
        case 3: case 4: {
            CGFloat height = CGFloatPixelRound((kDynamicCellContentWidth - kDynamicCellPaddingPic) / 2.0);
            mediaSize = CGSizeMake(height, height);
            mediaHeight = height * 2 + kDynamicCellPaddingPic;
        } break;
        case 5: case 6: {
            CGFloat height = CGFloatPixelRound((kDynamicCellContentWidth - kDynamicCellPaddingPic * 2) / 3.0);
            mediaSize = CGSizeMake(height, height);
            mediaHeight = height * 2 + kDynamicCellPaddingPic;
        } break;
        default: {
            CGFloat height = CGFloatPixelRound((kDynamicCellContentWidth - kDynamicCellPaddingPic * 2) / 3.0);
            mediaSize = CGSizeMake(height, height);
            mediaHeight = height * 3 + kDynamicCellPaddingPic * 2;
        } break;
    }
    _mediaSize = mediaSize;
    _mediaHeight = mediaHeight;
}

- (void)layoutGifts {
    _giftHeight = 0;
    _giftTextLayout = nil;
    if (!_dynamic.giftdata || !_dynamic.giftdata.count) return;
    
    NSString *str = [NSString stringWithFormat:@"共收到%@个人赠送的礼物", @(_dynamic.giftdata.count)];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:str];
    text.color = kDynamicCellTextSubTitleColor;
    text.font = [UIFont systemFontOfSize:10];
    text.lineBreakMode = NSLineBreakByCharWrapping;
    
    YYTextContainer *container = [YYTextContainer new];
    container.size = CGSizeMake(kDynamicCellContentWidth - 35, HUGE);
    container.maximumNumberOfRows = 1;
    
    _giftTextLayout = [YYTextLayout layoutWithContainer:container text:text];
    if (!_giftTextLayout) return;
    if (_dynamic.dtype.integerValue == BBQDynamicGroupTypeBaby) {
        _giftHeight = 7 + 10 + 12 + 10 + 1 + 10 + kScaleFrom_iPhone6_Desgin(50) + 7 + 5 + kScaleFrom_iPhone6_Desgin(29) + 5 + 2.5;
    } else {
        _giftHeight = 7 + 10 + 12 + 10 + 1 + 10 + kScaleFrom_iPhone6_Desgin(50) + 7 + 5 + 2.5;
    }
}

- (void)layoutComments {
    _commentHeight = 0;
    if (!_dynamic.reply.count || _style == BBQDynamicStyleDetail) return;
    NSMutableArray *tempLayouts = [NSMutableArray array];
    for (Comment *comment in _dynamic.reply) {
        BBQDynamicCommentLayout *layout = [[BBQDynamicCommentLayout alloc] initWithComment:comment style:BBQDynamicStyleTimeline];
        _commentHeight += layout.height;
        [tempLayouts addObject:layout];
    }
    _commentTextLayouts = tempLayouts.copy;
}

- (void)layoutToolbar {
    _toolbarHeight = 0;
    if (_style == BBQDynamicStyleDetail) return;
    _toolbarHeight = kDynamicCellToolbarHeight;
}

#pragma mark - Getter & Setter
- (void)setShowDateView:(BOOL)showDateView {
    _showDateView = showDateView;
}

@end


