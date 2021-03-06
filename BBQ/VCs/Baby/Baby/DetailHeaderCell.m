//
//  DetailHeaderCell.m
//  BBQ
//
//  Created by 朱琨 on 15/8/5.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "DetailHeaderCell.h"
#import "NSString+Common.h"
#import <DateTools.h>
#import <Masonry.h>
#import "GiftView.h"
#import "DynamicConst.h"
#import "GiftViewClass.h"
#import <Bugly/CrashReporter.h>
//#import <Bugly/Unity.h>
#import "BBQDynamicHelper.h"

@interface DetailHeaderCell ()

@property(strong, nonatomic) MASConstraint *tagViewHeightCons;
@property(strong, nonatomic) MASConstraint *photoViewHeightCons;
@property(strong, nonatomic) MASConstraint *giftViewHeightCons;
@property(strong, nonatomic) MASConstraint *contentZoneHeightCons;
@property(weak, nonatomic) IBOutlet UIImageView *firstTagImageView;
@property(weak, nonatomic) IBOutlet UILabel *tagLabel;
@property(weak, nonatomic) IBOutlet UIView *tagView;

@property(strong, nonatomic) UIImageView *dailyReportImageView;
@property(strong, nonatomic) UILabel *dailyReportLabel;

@end

static NSArray * reportTagType = nil;
@implementation DetailHeaderCell {
    BOOL _trackingTouch;
}

- (void)awakeFromNib {
    if (!reportTagType) {
        reportTagType = @[@2, @3, @4, @5];
    }
    self.fbztxImageView.layer.masksToBounds = YES;
    self.fbztxImageView.layer.cornerRadius =
    CGRectGetHeight(self.fbztxImageView.frame) / 2;
    
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
        make.left.equalTo(self.dailyReportImageView.right).offset(15);
        make.centerY.equalTo(self.dailyReportImageView);
    }];
    
    [self.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        self.photoViewHeightCons = make.height.equalTo(0);
        [self.photoViewHeightCons deactivate];
    }];
    
    [self.giftView mas_makeConstraints:^(MASConstraintMaker *make) {
        self.giftViewHeightCons = make.height.equalTo(0);
        [self.giftViewHeightCons deactivate];
    }];
    
    [self.contentZoneView mas_updateConstraints:^(MASConstraintMaker *make) {
        self.contentZoneHeightCons = make.height.equalTo(0);
        [self.contentZoneHeightCons deactivate];
    }];
}

- (void)setModel:(Dynamic *)model {
    _model = model;
    self.giftButton.hidden = model.uploadState != BBQDynamicUploadStateSuccess;
    
    if (model.ispajs.integerValue == 1) {
        self.fbztxImageView.image = [UIImage imageNamed:@"panda_head"];
    } else {
        [self.fbztxImageView setImageWithURL:[NSURL URLWithString:model.fbztx] placeholder:Placeholder_avatar
                                     options:YYWebImageOptionSetImageWithFadeAnimation
                                     manager:[BBQDynamicHelper avatarImageManager]
                                    progress:nil
                                   transform:nil
                                  completion:nil];
    }
    
    NSString *nameStr = nil;
    if (model.ispajs.integerValue == 1) {
        nameStr = @"小宝";
    } else if ([reportTagType containsObject:model.ispajs]) {
        nameStr = model.crenickname;
    } else {
        if (model.groupkey.integerValue == BBQGroupkeyTypeParent) {
            NSString *strRelation =
            [NSString relationshipWithID:model.gxid gxname:model.gxname];
            if (strRelation && strRelation.length) {
                nameStr =
                [model.baobaoname stringByAppendingString:strRelation];
            } else {
                nameStr = model.crenickname;
            }
        } else {
            nameStr = model.crenickname;
        }
    }
    
    self.nicknameLabel.text = nameStr ?: @"";
    
    NSString *sourceStr = nil;
    if (model.ispajs.integerValue == 1) {
        sourceStr = @"宝宝圈小管家";
    } else if (model.ispajs.integerValue == 3) {
        sourceStr = model.schoolname;
    } else if ([reportTagType containsObject:model.ispajs]) {
        sourceStr = model.classname;
    } else {
        if (model.groupkey.integerValue == BBQGroupkeyTypeTeacher) {
            sourceStr = model.classname;
        } else if (model.groupkey.integerValue == BBQGroupkeyTypeMaster) {
            sourceStr = model.schoolname;
        } else {
            sourceStr = model.crenickname;
        }
    }
    
    self.classnameLabel.text = sourceStr ?: @"";
    
    if ([model.dynatag isNotBlank] && model.ispajs.integerValue == 0) {
        [self.tagView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(34);
        }];
        self.firstTagImageView.hidden = NO;
        self.tagLabel.hidden = NO;
        self.tagLabel.text = model.dynatag;
        self.dailyReportImageView.hidden = YES;
        self.dailyReportLabel.hidden = YES;
    } else {
        self.tagLabel.text = nil;
        self.firstTagImageView.hidden = YES;
        self.dailyReportImageView.hidden = YES;
        self.dailyReportLabel.text = nil;
        [self.tagView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(7);
        }];
    }
    
    self.contentLabel.text = model.content;
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
    
    self.graphtimeLabel.text = nil;
    if (model.graphtime && model.graphtime.integerValue != 0) {
        self.graphtimeLabel.text = [NSString
                                    stringWithFormat:
                                    @"发表于%@",
                                    [NSDate timeAgoSinceDate:[NSDate dateWithTimeIntervalSince1970:
                                                              model.dateline.integerValue]]];
    }
    
    if (!model.content || [model.content isEqualToString:@""]) {
        [self.contentZoneHeightCons activate];
    } else {
        [self.contentZoneHeightCons deactivate];
    }
    
    [self.photoView.subviews
     makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (model.attachinfo.count) {
        [self.photoViewHeightCons deactivate];
        if (model.attachinfo.count == 1) {
            UIImageView *photo = [UIImageView new];
            [self.photoView addSubview:photo];
            Attachment *attachment = model.attachinfo.firstObject;
            [photo mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.photoView)
                .insets(UIEdgeInsetsMake(15, 0, 0, 0));
                make.height.equalTo(photo.mas_width).multipliedBy(7 / 6.0);
            }];
            if ([attachment.itype isEqualToNumber:@1]) {
                UIImageView *videoImage = [UIImageView new];
                videoImage.image = [UIImage imageNamed:@"video_play"];
                videoImage.contentMode = UIViewContentModeCenter;
                [photo addSubview:videoImage];
                [videoImage mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.center.equalTo(photo);
                }];
            }
        } else if (model.attachinfo.count == 2) {
            UIImageView *photo1 = [UIImageView new];
            [self.photoView addSubview:photo1];
            UIImageView *photo2 = [UIImageView new];
            [self.photoView addSubview:photo2];
            //            CGFloat photoWidth = (CGRectGetWidth(self.photoView.frame) -
            //            10) / 2.0;
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
            //            CGFloat photoWidth = (CGRectGetWidth(self.photoView.frame) -
            //            10) / 3.0;
            CGFloat photoWidth = (kScreenWidth - 95) / 3.0;
            for (NSInteger i = 0; i < model.attachinfo.count; i++) {
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
    } else {
        [self.photoViewHeightCons activate];
    }
    
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
        if (model.dtype.integerValue == BBQDynamicGroupTypeBaby) {
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
        [NSString stringWithFormat:@"共收到%@个人赠送的礼物",
         @(model.giftdata.count)];
        
        [model.giftdata
         enumerateObjectsUsingBlock:^(Gift *Gift, NSUInteger idx,
                                      BOOL *__nonnull stop) {
             if (model.dtype.integerValue == BBQDynamicGroupTypeBaby) {
                 GiftView *view = [[NSBundle mainBundle] loadNibNamed:@"GiftView"
                                                                owner:self
                                                              options:nil]
                 .firstObject;
                 view.giftCountLabel.layer.masksToBounds = YES;
                 view.giftCountLabel.layer.cornerRadius =
                 CGRectGetHeight(view.giftCountLabel.frame) / 2.0;
                 view.giftCountLabel.text =
                 [NSString stringWithFormat:@"+%@", Gift.giftcount];
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
                 [NSString stringWithFormat:@"+%@", Gift.giftcount];
                 
                 [self.giftView addSubview:view];
                 [view mas_makeConstraints:^(MASConstraintMaker *make) {
                     make.top.equalTo(self.giftTotalCountLabel.mas_bottom).offset(10);
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
}

- (void)didTapOnPhotoView:(UITapGestureRecognizer *)recognizer {
    if ([self.delegate respondsToSelector:@selector(didClickMediaAtIndex:)]) {
        [self.delegate didClickMediaAtIndex:[self.photoView.subviews indexOfObject:recognizer.view]];
    }
}

- (void)loadImages {
    [self.photoView.subviews enumerateObjectsUsingBlock:^(UIImageView *photo,
                                                          NSUInteger idx,
                                                          BOOL *__nonnull stop) {
        if (idx == 8) {
            *stop = YES;
        }
        
        photo.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(didTapOnPhotoView:)];
        [photo addGestureRecognizer:tap];
        photo.userInteractionEnabled = YES;
        photo.clipsToBounds = YES;
        photo.contentMode = UIViewContentModeScaleAspectFill;
        // 缩略图URL
        
        Attachment *mediaModel = self.model.attachinfo[idx];
        NSString *picURLStr;
        NSURL *picURL;
        CGFloat scale = [UIScreen mainScreen].scale;
        if (mediaModel.itype.integerValue == BBQAttachmentTypePhoto) {
            picURLStr = mediaModel.filepath;
        } else {
            picURLStr = [mediaModel thumbpath];
        }
        
        if ([mediaModel.remote isEqualToNumber:@1]) {
            picURL = [NSURL URLWithString:picURLStr];
        } else if ([mediaModel.remote isEqualToNumber:@2]) {
            picURLStr = [picURLStr stringByAppendingFormat:@"?imageView2/1/w/%.0f/h/%.0f", photo.width * scale,
                         photo.height * scale];
            picURL = [NSURL URLWithString:picURLStr];
        } else {
            picURL = [[NSURL alloc] initFileURLWithPath:picURLStr];
        }
        
        @weakify(photo)
        [photo
         setImageWithURL:picURL
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
                                     reason:@"动态详情加载图片失败"
                                     extraInfo:nil];
                                });
             }
         }];
    }];
    
    if (self.model.giftdata.count > 0) {
        __block NSInteger i = 0;
        [self.giftView.subviews enumerateObjectsUsingBlock:^(UIView *view,
                                                             NSUInteger idx,
                                                             BOOL *__nonnull stop) {
            if ([view isKindOfClass:[GiftView class]]) {
                [((GiftView *)view)
                 .fbztxImageView setImageWithURL:[NSURL URLWithString:((Gift *)_model.giftdata[i]).fbztx] placeholder:Placeholder_avatar options:YYWebImageOptionSetImageWithFadeAnimation completion:nil];
                
                [((GiftView *)view)
                 .giftImageView
                 setImageWithURL:[NSURL URLWithString:((Gift *)
                                                       _model.giftdata[i])
                                  .imgurl]
                 placeholder:Placeholder_avatar
                 options:YYWebImageOptionSetImageWithFadeAnimation
                 completion:nil];
                i++;
            } else if ([view isKindOfClass:[GiftViewClass class]]) {
                [((GiftViewClass *)view)
                 .giftImageView
                 setImageWithURL:[NSURL URLWithString:((Gift *)
                                                       _model.giftdata[i])
                                  .imgurl]
                 placeholder:Placeholder_avatar
                 options:YYWebImageOptionSetImageWithFadeAnimation
                 completion:nil];
                i++;
            }
        }];
    }
}
- (IBAction)didClickGiftButton:(id)sender {
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(didClickGiftButton)]) {
        [self.delegate didClickGiftButton];
    }
}

- (void)didTapOnGiftView:(UITapGestureRecognizer *)recognizer {
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(didClickGiftView)]) {
        [self.delegate didClickGiftView];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    _trackingTouch = NO;
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView:_fbztxImageView];
    if (CGRectContainsPoint(_fbztxImageView.bounds, p)) {
        _trackingTouch = YES;
    }
    p = [t locationInView:_nicknameLabel];
    if (CGRectContainsPoint(_nicknameLabel.bounds, p) &&
        _nicknameLabel.size.width > p.x) {
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
        if (self.delegate && [self.delegate
                              respondsToSelector:@selector(didClickUserWithID:)]) {
            [self.delegate didClickUserWithID:_model.creuid];
        }
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!_trackingTouch) {
        [super touchesCancelled:touches withEvent:event];
    }
}

@end
