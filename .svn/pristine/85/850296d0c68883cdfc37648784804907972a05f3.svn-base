//
//  BabyDynamicCell.m
//  BBQ
//
//  Created by 朱琨 on 15/8/2.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BabyDynamicCell.h"
#import <Masonry.h>
#import "DynaModel.h"

#import "GiftSingleView.h"
#import <DateTools.h>
#import "CommentView.h"
#import "CommentModel.h"

#import "AttachModel.h"
#import "GiftModel.h"
#import "GiftView.h"
#import "GiftViewClass.h"
#import <Bugly/CrashReporter.h>
#import <Bugly/Unity.h>
#import "AppMacro.h"

@interface BabyDynamicCell () <MLLinkLabelDelegate, UIGestureRecognizerDelegate>

@property(strong, nonatomic) MASConstraint *tagViewHeightCons;
@property(strong, nonatomic) MASConstraint *contentHeightCons;
@property(strong, nonatomic) MASConstraint *giftViewHeightCons;
@property(strong, nonatomic) MASConstraint *photoViewHeightCons;
@property(strong, nonatomic) MASConstraint *commentViewHeightCons;
@property(strong, nonatomic) MASConstraint *infoViewHeightCons;
@property(strong, nonatomic) NSMutableArray *giftImageArray;
@property(strong, nonatomic) NSMutableArray *giftUserImageArray;
@property(strong, nonatomic) UILabel *anotherNameLabel;
@property(strong, nonatomic) UIActivityIndicatorView *indicator;

@property(strong, nonatomic) UIImageView *dailyReportImageView;
@property(strong, nonatomic) UILabel *dailyReportLabel;
@property(weak, nonatomic) IBOutlet UIView *popMenu;

@end
@implementation BabyDynamicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.popMenu.layer.masksToBounds = YES;
    self.popMenu.layer.cornerRadius = 5;
    self.giftImageArray = [NSMutableArray array];
    self.giftUserImageArray = [NSMutableArray array];
    self.fbztxImageView.layer.masksToBounds = YES;
    self.fbztxImageView.layer.cornerRadius = 20;
    UITapGestureRecognizer *headTap = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(didTapOnUserHeadView:)];
    [self.fbztxImageView addGestureRecognizer:headTap];
    
    self.dailyReportImageView = [UIImageView new];
    [self.tagView addSubview:self.dailyReportImageView];
    [self.dailyReportImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tagView).offset(15);
        make.left.equalTo(self.tagView);
        make.bottom.equalTo(self.tagView).priority(900);
        make.width.height.equalTo(35);
    }];
    
    self.dailyReportLabel = [UILabel new];
    self.dailyReportLabel.font = [UIFont systemFontOfSize:14];
    self.dailyReportLabel.textColor = [UIColor colorWithHexString:@"ff6440"];
    [self.tagView addSubview:self.dailyReportLabel];
    [self.dailyReportLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dailyReportImageView.mas_right).offset(15);
        make.centerY.equalTo(self.dailyReportImageView);
    }];
    
    self.indicator = [[UIActivityIndicatorView alloc]
                      initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.contentView addSubview:self.indicator];
    [self.indicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(20);
        make.centerY.equalTo(self.fbztxImageView);
        make.trailing.equalTo(self.contentView).offset(-15);
    }];
    
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.cornerRadius = 5;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(didTapOnBgView:)];
    [self.bgView addGestureRecognizer:tap];
    tap.delegate = self;
    
    //    self.anotherNameLabel = [UILabel new];
    //    self.anotherNameLabel.textColor = [UIColor colorWithHexString:@"333333"];
    //    self.anotherClassNameLabel.hidden = YES;
    //    self.anotherNameLabel.font = [UIFont systemFontOfSize:14];
    //    [self.contentView addSubview:self.anotherNameLabel];
    //    [self.anotherNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.leading.equalTo(self.fbztxImageView.trailing).offset(7.5);
    //        make.centerY.equalTo(self.fbztxImageView);
    //        make.height.equalTo(14);
    //    }];
    
    self.fbztxImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.fbztxImageView.layer.borderWidth = 1;
    
    //    [self.tagView mas_updateConstraints:^(MASConstraintMaker *make) {
    //        self.tagViewHeightCons = make.height.equalTo(7);
    //        [self.tagViewHeightCons deactivate];
    //    }];
    [self.contentZoneView mas_updateConstraints:^(MASConstraintMaker *make) {
        self.contentHeightCons = make.height.equalTo(0);
        [self.contentHeightCons deactivate];
    }];
    [self.photoView mas_updateConstraints:^(MASConstraintMaker *make) {
        self.photoViewHeightCons = make.height.equalTo(0);
        [self.photoViewHeightCons deactivate];
    }];
    
    [self.giftView mas_updateConstraints:^(MASConstraintMaker *make) {
        self.giftViewHeightCons = make.height.equalTo(0);
        [self.contentHeightCons deactivate];
    }];
    
    [self.commentView mas_updateConstraints:^(MASConstraintMaker *make) {
        self.commentViewHeightCons = make.height.equalTo(0);
        [self.commentViewHeightCons deactivate];
    }];
    
    [self.infoView mas_updateConstraints:^(MASConstraintMaker *make) {
        self.infoViewHeightCons = make.height.equalTo(34);
        [self.commentViewHeightCons deactivate];
    }];
}

- (void)setModel:(DynaModel *)model {
    _model = model;
    if (model.ispajs.integerValue == 0 || model.ispajs.integerValue == 3 ||
        model.ispajs.integerValue == 4) {
        if (model.groupkey.integerValue == BBQGroupkeyTypeParent) {
            NSString *strRelation =
            [TJYEXLoginUserInfo relationshipLabelText:[model.gxid intValue]
                                               gxname:model.gxname];
            if (strRelation && strRelation.length > 0) {
                self.crenicknameLabel.text =
                [model.baobaoname stringByAppendingString:strRelation];
            } else {
                self.crenicknameLabel.text = model.crenickname;
            }
            self.classNameLabel.text = model.crenickname;
        } else if (model.groupkey.integerValue == BBQGroupkeyTypeTeacher) {
            self.crenicknameLabel.text = model.crenickname;
            self.classNameLabel.text = model.classname;
        } else if (model.groupkey.integerValue == BBQGroupkeyTypeMaster) {
            self.crenicknameLabel.text = model.crenickname;
            self.classNameLabel.text = model.schoolname;
        } else if (model.groupkey.integerValue == BBQGroupkeyTypeUndefined) {
            self.crenicknameLabel.text = model.crenickname;
            self.classNameLabel.text = model.crenickname;
        }
    } else if (model.ispajs.integerValue == 1) {
        self.crenicknameLabel.text = @"小宝";
        self.classNameLabel.text = @"宝宝圈小管家";
    } else if (model.ispajs.integerValue == 2) {
        self.crenicknameLabel.text = model.crenickname;
        self.classNameLabel.text = model.classname;
    }
    switch (model.upflag.integerValue) {
        case DYNA_NONEED_UPLOAD:
        case DYNA_UPLOAD_FINISH: {
            
            self.graphtimeLabel.hidden = NO;
            self.indicator.hidden = YES;
            self.warningView.hidden = YES;
            //            self.graphtimeLabel.text = [NSString
            //            stringWithFormat:@"拍摄于%@", [[NSDate
            //            dateWithTimeIntervalSince1970:[model.graphtime doubleValue]]
            //            formattedDateWithFormat:@"yyyy年MM月dd日"]];
            self.graphtimeLabel.text = [NSString
                                        stringWithFormat:
                                        @"发表于%@",
                                        [NSDate timeAgoSinceDate:[NSDate dateWithTimeIntervalSince1970:
                                                                  model.dateline.integerValue]]];
        } break;
        case DYNA_UPLOADING: {
            self.graphtimeLabel.hidden = YES;
            self.warningView.hidden = YES;
            self.indicator.hidden = NO;
            [self.indicator startAnimating];
        } break;
        case DYNA_UPLOAD_FAILURE: {
            self.graphtimeLabel.hidden = YES;
            self.warningView.hidden = NO;
            [self.indicator stopAnimating];
            self.indicator.hidden = YES;
        } break;
        default:
            break;
    }
    
    if (model.dynatag && ![model.dynatag isEqualToString:@""]) {
        if (model.ispajs.integerValue == 0) {
            [self.tagView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(34);
            }];
            self.firstTagImageView.hidden = NO;
            self.tagLabel.hidden = NO;
            self.tagLabel.text = model.dynatag;
            self.dailyReportImageView.hidden = YES;
            self.dailyReportLabel.hidden = YES;
        } else if (model.ispajs.integerValue == 2) {
            [self.tagView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(50);
            }];
            NSString *imageName = nil;
            if ([model.dynatag isEqualToString:@"早餐"]) {
                imageName = @"dailyreport_breakfast";
            } else if ([model.dynatag isEqualToString:@"午餐"]) {
                imageName = @"dailyreport_lunch";
            } else if ([model.dynatag isEqualToString:@"午睡"]) {
                imageName = @"dailyreport_noonbreak";
            } else if ([model.dynatag isEqualToString:@"喝水"]) {
                imageName = @"dailyreport_drinking";
            } else if ([model.dynatag isEqualToString:@"学习"]) {
                imageName = @"dailyreport_study";
            } else if ([model.dynatag isEqualToString:@"情绪"]) {
                imageName = @"dailyreport_emotion";
            } else if ([model.dynatag isEqualToString:@"健康"]) {
                imageName = @"dailyreport_health";
            } else if ([model.dynatag isEqualToString:@"寄语"]) {
                imageName = @"dailyreport_words";
            }
            
            self.dailyReportImageView.image = [UIImage imageNamed:imageName];
            self.dailyReportLabel.text =
            [NSString stringWithFormat:@"%@", model.dynatag];
            self.dailyReportImageView.hidden = NO;
            self.dailyReportLabel.hidden = NO;
            self.firstTagImageView.hidden = YES;
            self.tagLabel.hidden = YES;
        }
    } else {
        self.tagLabel.text = nil;
        self.firstTagImageView.hidden = YES;
        self.dailyReportImageView.hidden = YES;
        self.dailyReportLabel.text = nil;
        [self.tagView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(7);
        }];
    }
    
    if (!model.content || [model.content isEqualToString:@""]) {
        [self.contentHeightCons activate];
    } else {
        [self.contentHeightCons deactivate];
        self.contentLabel.text = model.content;
    }
    
    [self.photoView.subviews
     makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //    [self setNeedsLayout];
    //    [self layoutIfNeeded];
    if (!model.attachinfo || !model.attachinfo.count) {
        [self.photoViewHeightCons activate];
    } else if (model.attachinfo.count == 1) {
        [self.photoViewHeightCons deactivate];
        UIImageView *photo = [UIImageView new];
        [self.photoView addSubview:photo];
        [photo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.photoView).insets(UIEdgeInsetsMake(15, 0, 0, 0));
            make.height.equalTo(photo.mas_width).multipliedBy(7 / 6.0);
        }];
    } else if (model.attachinfo.count == 2) {
        [self.photoViewHeightCons deactivate];
        UIImageView *photo1 = [UIImageView new];
        [self.photoView addSubview:photo1];
        UIImageView *photo2 = [UIImageView new];
        [self.photoView addSubview:photo2];
        [photo1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self.photoView)
            .offset(UIEdgeInsetsMake(15, 0, 0, 0));
            make.width.height.equalTo(self.photoView.mas_width).offset(-5).dividedBy(2);
        }];
        
        [photo2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(self.photoView)
            .offset(UIEdgeInsetsMake(15, 0, 0, 0));
            make.width.height.equalTo(self.photoView.mas_width).offset(-5).dividedBy(2);
        }];
    } else {
        [self.photoViewHeightCons deactivate];
        //                CGFloat photoWidth = (CGRectGetWidth(self.photoView.frame)
        //                - 10) / 3.0;
        CGFloat photoWidth = (kScreenWidth - 104) / 3.0;
        for (NSInteger i = 0; i < model.attachinfo.count; i++) {
            @autoreleasepool {
                if (i == 9) {
                    break;
                }
                UIImageView *photo = [UIImageView new];
                [self.photoView addSubview:photo];
                [photo mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.photoView)
                    .offset(15 + (photoWidth + 5) * (i / 3));
                    make.left.equalTo(self.photoView).offset((photoWidth + 5) * (i % 3));
                    make.height.width.equalTo(photoWidth);
                    if (i == model.attachinfo.count - 1) {
                        make.bottom.equalTo(self.photoView);
                    }
                }];
            }
        }
    }
    for (UIImageView *photo in self.photoView.subviews) {
        photo.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapOnPhoto = [[UITapGestureRecognizer alloc]
                                              initWithTarget:self
                                              action:@selector(didTapOnPhoto:)];
        [photo addGestureRecognizer:tapOnPhoto];
    }
    //
    //    if (model.position && ![model.position isEqualToString:@""]) {
    //        [self.infoViewHeightCons deactivate];
    //        self.datelineLabel.hidden = NO;
    //        self.graphtimeImageView.hidden = YES;
    //        self.datelineLabel.text = [NSDate timeAgoSinceDate:[NSDate
    //        dateWithTimeIntervalSince1970:[model.dateline integerValue]]];
    //        self.positionLabel.text = model.position;
    //    } else {
    [self.infoViewHeightCons activate];
    if (!model.dateline && [model.dateline integerValue] == 0) {
        self.datelineLabel.hidden = YES;
        self.graphtimeImageView.hidden = YES;
    } else {
        self.datelineLabel.hidden = NO;
        self.graphtimeImageView.hidden = NO;
        
        self.positionLabel.text = model.position;
    }
    if (model.attachinfo && model.attachinfo.count > 0) {
        self.datelineLabel.text =
        [[NSDate dateWithTimeIntervalSince1970:model.graphtime.integerValue]
         formattedDateWithFormat:@"拍摄于yyyy年MM月dd日"];
        self.datelineLabel.hidden = NO;
        self.graphtimeImageView.hidden = NO;
    } else {
        self.datelineLabel.hidden = YES;
        self.graphtimeImageView.hidden = YES;
    }
    //    }
    
    for (UIView *view in self.giftView.subviews) {
        if ([view isKindOfClass:[GiftView class]] ||
            [view isKindOfClass:[GiftViewClass class]]) {
            [view removeFromSuperview];
        }
    }
    
    [self.giftView setNeedsLayout];
    [self.giftView layoutIfNeeded];
    
    if (!model.giftdata || !model.giftdata.count) {
        [self.giftViewHeightCons activate];
    } else {
        [self.giftViewHeightCons deactivate];
        
        if (model.dtype.integerValue == BBQDynamicTypeBaby) {
            [self.giftTotalCountLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(self.giftView).offset(13);
            }];
            self.giftSeparateLine.hidden = NO;
        } else {
            [self.giftTotalCountLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.giftView);
            }];
            self.giftSeparateLine.hidden = YES;
        }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(didTapOnGiftView:)];
        [self.giftView addGestureRecognizer:tap];
        
        CGFloat giftWidth = (CGRectGetWidth(self.giftView.frame) - 6) / 4;
        
        self.giftTotalCountLabel.text =
        [NSString stringWithFormat:@"共收到%ld个人赠送的礼物",
         (unsigned long)model.giftdata.count];
        
        [model.giftdata
         enumerateObjectsUsingBlock:^(GiftModel *giftModel, NSUInteger idx,
                                      BOOL *__nonnull stop) {
             if (model.dtype.integerValue == BBQDynamicTypeBaby) {
                 GiftView *view = [[NSBundle mainBundle] loadNibNamed:@"GiftView"
                                                                owner:self
                                                              options:nil]
                 .firstObject;
                 view.giftCountLabel.layer.masksToBounds = YES;
                 view.giftCountLabel.layer.cornerRadius =
                 CGRectGetHeight(view.giftCountLabel.frame) / 2.0;
                 view.giftCountLabel.text =
                 [NSString stringWithFormat:@"+%@", giftModel.giftcount];
                 view.fbztxImageView.layer.masksToBounds = YES;
                 view.fbztxImageView.layer.cornerRadius =
                 CGRectGetHeight(view.fbztxImageView.frame) / 2.0;
                 
                 [self.giftView addSubview:view];
                 [view mas_makeConstraints:^(MASConstraintMaker *make) {
                     make.top.equalTo(self.giftSeparateLine.mas_bottom).offset(10);
                     make.left.equalTo(self.giftView).offset(3 + idx * giftWidth);
                     make.width.equalTo(giftWidth);
                     make.bottom.equalTo(self.giftBorderView).offset(-8);
                 }];
             } else {
                 GiftViewClass *view =
                 [[NSBundle mainBundle] loadNibNamed:@"GiftViewClass"
                                               owner:self
                                             options:nil]
                 .firstObject;
                 view.giftCountLabel.layer.masksToBounds = YES;
                 view.giftCountLabel.layer.cornerRadius =
                 CGRectGetHeight(view.giftCountLabel.frame) / 2.0;
                 view.giftCountLabel.text =
                 [NSString stringWithFormat:@"+%@", giftModel.giftcount];
                 
                 [self.giftView addSubview:view];
                 [view mas_makeConstraints:^(MASConstraintMaker *make) {
                     make.top.equalTo(self.giftTotalCountLabel.bottom).offset(10);
                     make.left.equalTo(self.giftView).offset(3 + idx * giftWidth);
                     make.width.equalTo(giftWidth);
                     make.bottom.equalTo(self.giftBorderView).offset(-8);
                 }];
             }
             if (idx == 3) {
                 *stop = YES;
             }
         }];
    }
    
    [self.commentView.subviews
     makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    if (model.reply && model.reply.count) {
        [self.commentViewHeightCons deactivate];
        __block UIView *lastCommentView = nil;
        __block NSInteger validCommentCount = 0;
        [model.reply enumerateObjectsUsingBlock:^(CommentModel *commentModel,
                                                  NSUInteger idx,
                                                  BOOL *__nonnull stop) {
            //            commentModel.guid = model.guid;
            if ([commentModel.flag isEqualToString:@"0"]) {
                validCommentCount++;
                NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:@"CommentView"
                                                                 owner:self
                                                               options:nil];
                CommentView *view = nibView.firstObject;
                [self.commentView addSubview:view];
                view.cguid = commentModel.cguid;
                view.fbztxImageView.layer.masksToBounds = YES;
                view.fbztxImageView.layer.cornerRadius = 12;
                view.contentLabel.dataDetectorTypes = MLDataDetectorTypeAttributedLink;
                view.contentLabel.linkTextAttributes = @{
                                                         NSForegroundColorAttributeName : [UIColor colorWithHexString:@"ff6440"]
                                                         };
                view.contentLabel.delegate = self;
                
                NSString *str1 = @"";
                
                if (commentModel.groupkey.integerValue == BBQGroupkeyTypeParent &&
                    commentModel.baobaoname) {
                    str1 = [commentModel.baobaoname
                            stringByAppendingString:commentModel.gxname];
                    //                    str2 = commentModel.regxname;
                } else {
                    str1 = commentModel.nickname;
                    //                    str2 = commentModel.reNickname;
                }
                NSString *content = nil;
                NSMutableAttributedString *attributedContent = nil;
                if (commentModel.isreplay.integerValue) {
                    content = [NSString stringWithFormat:@"%@ 回复 %@ ：%@", str1,
                               commentModel.regxname,
                               commentModel.content];
                    attributedContent =
                    [[NSMutableAttributedString alloc] initWithString:content];
                    [attributedContent addAttribute:NSLinkAttributeName
                                              value:commentModel.uid
                                              range:[content rangeOfString:str1]];
                    //                    [attributedContent
                    //                    addAttribute:NSLinkAttributeName
                    //                    value:commentModel.reUID range:[content
                    //                    rangeOfString:commentModel.regxname]];
                    [attributedContent
                     addAttribute:NSLinkAttributeName
                     value:commentModel.reuid
                     range:NSMakeRange(str1.length + 4,
                                       commentModel.regxname.length)];
                } else {
                    content = [NSString
                               stringWithFormat:@"%@ ：%@", str1, commentModel.content];
                    attributedContent =
                    [[NSMutableAttributedString alloc] initWithString:content];
                    [attributedContent addAttribute:NSLinkAttributeName
                                              value:commentModel.uid
                                              range:[content rangeOfString:str1]];
                }
                view.contentLabel.attributedText = attributedContent;
                if (validCommentCount == 1) {
                    [view mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.left.right.equalTo(self.commentView);
                    }];
                    lastCommentView = view;
                } else {
                    [view mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(lastCommentView.mas_bottom);
                        make.left.right.equalTo(lastCommentView);
                    }];
                    lastCommentView = view;
                }
                if (validCommentCount == 3) {
                    *stop = YES;
                }
            }
        }];
        [lastCommentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.commentView);
        }];
        
    } else {
        [self.commentViewHeightCons activate];
    }
    
    //    if ([model.commentcount integerValue]) {
    //    NSInteger commentCount = 0;
    //    commentCount = ([model.commentcount integerValue] < model.reply.count) ?
    //    model.reply.count : model.commentcount.integerValue;
    [self.bottomCommentButton
     setTitle:[NSString stringWithFormat:@"评论(%ld)",
               MAX(model.commentcount.integerValue,
                   model.reply.count)]
     forState:UIControlStateNormal];
    //    } else {
    //        [self.bottomCommentButton setTitle:@"评论"
    //        forState:UIControlStateNormal];
    //    }
}

#pragma mark - Load Images
- (void)loadImages {
    if (self.model.ispajs.integerValue == 1) {
        self.fbztxImageView.image = [UIImage imageNamed:@"panda_head"];
    } else {
        [self.fbztxImageView
         setImageWithURL:[NSURL URLWithString:_model.fbztx]
         placeholder:[UIImage imageNamed:@"placeholder_panda"]
         options:YYWebImageOptionSetImageWithFadeAnimation
         completion:^(UIImage *image, NSURL *url,
                      YYWebImageFromType from, YYWebImageStage stage,
                      NSError *error) {
             if (error) {
                 dispatch_async(
                                dispatch_get_global_queue(
                                                          DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                                ^{
                                    [[CrashReporter sharedInstance]
                                     reportError:error
                                     reason:@"动态cell头像加载图片失败"
                                     extraInfo:nil];
                                });
             }
         }];
    }
    
    [self.photoView.subviews enumerateObjectsUsingBlock:^(UIImageView *photo,
                                                          NSUInteger idx,
                                                          BOOL *__nonnull stop) {
        photo.clipsToBounds = YES;
        photo.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
        photo.contentMode = UIViewContentModeScaleAspectFill;
        AttachModel *photoModel = _model.attachinfo[idx];
        // 缩略图URL
        if ([photoModel.filepath hasPrefix:@"/var"]) {
            
            //            [photo setimageURL:[NSURL
            //            fileURLWithPath:photoModel.filepath]];
            [photo
             setImageWithURL:[NSURL fileURLWithPath:photoModel.filepath]
             placeholder:[UIImage imageNamed:@"placeholder_white_error"]];
        } else {
            CGFloat scale = [UIScreen mainScreen].scale;
            NSString *thumbnailURL = [NSString
                                      stringWithFormat:@"%@?imageView2/1/w/%.0f/h/%.0f",
                                      photoModel.filepath, photo.frame.size.width * scale,
                                      photo.frame.size.height * scale];
            @weakify(photo)
            [photo
             setImageWithURL:[NSURL URLWithString:thumbnailURL]
             placeholder:[UIImage imageNamed:@"placeholder_white_loading"]
             options:YYWebImageOptionSetImageWithFadeAnimation
             completion:^(UIImage *image, NSURL *url,
                          YYWebImageFromType from, YYWebImageStage stage,
                          NSError *error) {
                 @strongify(photo)
                 if (error) {
                     photo.image =
                     [UIImage imageNamed:@"placeholder_white_error"];
                     dispatch_async(
                                    dispatch_get_global_queue(
                                                              DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                                    ^{
                                        [[CrashReporter sharedInstance]
                                         reportError:error
                                         reason:@"动态加载图片失败"
                                         extraInfo:@{
                                                     @"URL" : url
                                                     }];
                                    });
                 }
             }];
        }
    }];
    
    __block NSInteger i = 0;
    if (self.model.giftdata.count > 0) {
        [self.giftView.subviews enumerateObjectsUsingBlock:^(UIView *view,
                                                             NSUInteger idx,
                                                             BOOL *__nonnull stop) {
            if ([view isKindOfClass:[GiftView class]]) {
                [((GiftView *)view)
                 .fbztxImageView
                 setImageWithURL:
                 [NSURL URLWithString:((GiftModel *)_model.giftdata[i]).fbztx]
                 placeholder:[UIImage imageNamed:@"placeholder_panda"]
                 options:YYWebImageOptionSetImageWithFadeAnimation
                 completion:^(UIImage *image, NSURL *url,
                              YYWebImageFromType from, YYWebImageStage stage,
                              NSError *error) {
                     if (error) {
                         dispatch_async(
                                        dispatch_get_global_queue(
                                                                  DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                                        ^{
                                            [[CrashReporter sharedInstance]
                                             reportError:error
                                             reason:
                                             @"送礼人头像加载图片失败"
                                             extraInfo:nil];
                                        });
                     }
                 }];
                
                [((GiftView *)view)
                 .giftImageView
                 setImageWithURL:[NSURL URLWithString:((GiftModel *)
                                                       _model.giftdata[i])
                                  .imgurl]
                 placeholder:nil
                 options:YYWebImageOptionSetImageWithFadeAnimation
                 completion:^(UIImage *image, NSURL *url,
                              YYWebImageFromType from, YYWebImageStage stage,
                              NSError *error) {
                     if (error) {
                         dispatch_async(
                                        dispatch_get_global_queue(
                                                                  DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                                        ^{
                                            [[CrashReporter sharedInstance]
                                             reportError:error
                                             reason:@"礼物图片加载失败"
                                             extraInfo:nil];
                                        });
                     }
                 }];
                i++;
            } else if ([view isKindOfClass:[GiftViewClass class]]) {
                [((GiftViewClass *)view)
                 .giftImageView
                 setImageWithURL:[NSURL URLWithString:((GiftModel *)
                                                       _model.giftdata[i])
                                  .imgurl]
                 placeholder:nil
                 options:YYWebImageOptionSetImageWithFadeAnimation
                 completion:^(UIImage *image, NSURL *url,
                              YYWebImageFromType from, YYWebImageStage stage,
                              NSError *error) {
                     if (error) {
                         dispatch_async(
                                        dispatch_get_global_queue(
                                                                  DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                                        ^{
                                            [[CrashReporter sharedInstance]
                                             reportError:error
                                             reason:@"礼物图片加载失败"
                                             extraInfo:nil];
                                        });
                     }
                 }];
                i++;
            }
        }];
    }
    
    [self.commentView.subviews
     enumerateObjectsUsingBlock:^(CommentView *view, NSUInteger idx,
                                  BOOL *__nonnull stop) {
         [view.fbztxImageView
          setImageWithURL:
          [NSURL URLWithString:((CommentModel *)_model.reply[idx]).fbztx]
          placeholder:[UIImage imageNamed:@"placeholder_panda"]
          options:YYWebImageOptionSetImageWithFadeAnimation
          completion:nil];
     }];
}

- (void)cancelAllOperations {
    [self.fbztxImageView cancelCurrentImageRequest];
    [self.photoView.subviews
     makeObjectsPerformSelector:@selector(cancelCurrentImageRequest)];
}

- (void)hidePopmenu {
    self.popMenu.hidden = YES;
}

#pragma mark - Cell Delegate
- (IBAction)didClickMiddleCommentButton:(id)sender {
    self.popMenu.hidden = !self.popMenu.hidden;
    //    if (self.delegate && [self.delegate
    //    respondsToSelector:@selector(didClickMiddleCommentButtonAtIndexPath:)])
    //    {
    //        [self.delegate
    //        didClickMiddleCommentButtonAtIndexPath:self.indexPath];
    //    }
}
- (IBAction)didClickGiftButton:(id)sender {
    if (self.delegate &&
        [self.delegate
         respondsToSelector:@selector(didClickGiftButtonAtIndexPath:)]) {
            [self.delegate didClickGiftButtonAtIndexPath:self.indexPath];
        }
}
- (IBAction)didClickShareButton:(id)sender {
    if (self.delegate &&
        [self.delegate
         respondsToSelector:@selector(didClickShareButtonAtIndexPath:)]) {
            [self.delegate didClickShareButtonAtIndexPath:self.indexPath];
        }
}
- (IBAction)didClickBottomCommentButton:(id)sender {
    if (self.delegate &&
        [self.delegate
         respondsToSelector:@selector(
                                      didClickBottomCommentButtonAtIndexPath:)]) {
             [self.delegate didClickBottomCommentButtonAtIndexPath:self.indexPath];
         }
}

- (void)didClickLink:(MLLink *)link
            linkText:(NSString *)linkText
           linkLabel:(MLLinkLabel *)linkLabel {
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(didClickUserWithID:)]) {
        [self.delegate didClickUserWithID:link.linkValue];
    }
}

- (void)didClickNonLinkAreaInLinkLabel:(MLLinkLabel *)linkLabel {
    if (self.delegate &&
        [self.delegate
         respondsToSelector:@selector(didTapCommentLabelAtIndexPath:
                                      atIndex:)]) {
             [self.delegate
              didTapCommentLabelAtIndexPath:self.indexPath
              atIndex:[self.commentView.subviews
                       indexOfObject:linkLabel.superview]];
         }
}

- (void)didLongPressNonLinkAreaInLinkLabel:(MLLinkLabel *)linkLabel {
    if (self.delegate &&
        [self.delegate
         respondsToSelector:@selector(didLongPressCommentLabelAtIndexPath:
                                      atIndex:)]) {
             [self.delegate
              didLongPressCommentLabelAtIndexPath:
              self.indexPath atIndex:[self.commentView.subviews
                                      indexOfObject:linkLabel.superview]];
         }
}

- (void)didTapOnGiftView:(UITapGestureRecognizer *)recognizer {
    if (self.delegate &&
        [self.delegate
         respondsToSelector:@selector(didClickGiftViewAtIndexPath:)]) {
            [self.delegate didClickGiftViewAtIndexPath:self.indexPath];
        }
}

- (void)didTapOnPhoto:(UITapGestureRecognizer *)recognizer {
    if (self.delegate &&
        [self.delegate
         respondsToSelector:@selector(didClickPhoto:atIndexPath:atIndex:)]) {
            [self.delegate
             didClickPhoto:(UIImageView *)recognizer.view
             atIndexPath:self.indexPath
             atIndex:[self.photoView.subviews indexOfObject:recognizer.view]];
        }
}

- (void)didTapOnBgView:(UITapGestureRecognizer *)recognizer {
    if (self.delegate &&
        [self.delegate
         respondsToSelector:@selector(didClickBgViewAtIndexPath:)]) {
            [self.delegate didClickBgViewAtIndexPath:self.indexPath];
        }
}

- (void)didTapOnUserHeadView:(UITapGestureRecognizer *)recognizer {
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(didClickUserWithID:)]) {
        [self.delegate didClickUserWithID:[self.model.creuid stringValue]];
    }
}

- (IBAction)didClickCommentButton:(id)sender {
    [self hidePopmenu];
    if (self.delegate &&
        [self.delegate
         respondsToSelector:@selector(didClickCommentButtonAtIndexPath:)]) {
            [self.delegate didClickCommentButtonAtIndexPath:self.indexPath];
        }
}

- (IBAction)didClickDeleteButton:(id)sender {
    [self hidePopmenu];
    if (self.delegate &&
        [self.delegate
         respondsToSelector:@selector(didClickDeleteButtonAtIndexPath:)]) {
            [self.delegate didClickDeleteButtonAtIndexPath:self.indexPath];
        }
}

#pragma mark - Gesture Delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[MLLinkLabel class]]) {
        return NO;
    }
    return YES;
}

- (void)prepareForReuse {
    for (UIImageView *view in self.photoView.subviews) {
        view.image = nil;
    }
}
@end
