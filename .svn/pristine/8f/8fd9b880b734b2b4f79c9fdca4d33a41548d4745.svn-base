//
//  ShareView.m
//  BBQ
//
//  Created by anymuse on 15/7/23.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "ShareView.h"
#import <Masonry.h>
#import "UMSocialWechatHandler.h"
#import "UMSocial.h"
#import "WXApi.h"
#import "NSString+Common.h"
#import "NetConstDefine.h"
#import "Attachment.h"
#import "AppMacro.h"
#import "UMSocialQQHandler.h"
#import <UIView+BlocksKit.h>

#define kBBQShareViewNumPerLine 4

@interface BBQShareViewItem : UIView
@property (strong, nonatomic) NSString *snsName;
@property (copy, nonatomic) void(^clickedBlock)(NSString *snsName);
+ (instancetype)itemWithSnsName:(NSString *)snsName;
+ (CGFloat)itemWidth;
+ (CGFloat)itemHeight;
@end

@implementation BBQShareViewItem

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

+ (CGFloat)itemWidth {
    return kScreenWidth / kBBQShareViewNumPerLine;
}

+ (CGFloat)itemHeight {
    return [self itemWidth] + 20;
}

@end

@interface ShareView ()

@property (strong, nonatomic) UIView *bgView;
@property(strong, nonatomic) NSArray *shareButtonsImage;
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UIScrollView *itemsScrollView;
@property (strong, nonatomic) UIButton *cancelButton;

@end

static NSInteger const kButtonBaseTag = 1989;

@implementation ShareView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.frame = kScreen_Bounds;
        self.exclusiveTouch = YES;
        if (!_bgView) {
            _bgView = ({
                UIView *view = [[UIView alloc] initWithFrame:kScreen_Bounds];
//                view.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
                view.backgroundColor = [UIColor blackColor];
                view.alpha = 0;
                [view bk_whenTapped:^{
                    [self dismiss];
                }];
                view;
            });
            [self addSubview:_bgView];
        }
        
        if (!_contentView) {
            _contentView = [UIView new];
            _contentView.backgroundColor = UIColorHex(F0F0F0);
            if (!_cancelButton) {
                _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [self addSubview:_cancelButton];
                [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
                [_cancelButton setTitleColor:UIColorHex(ff6440)
                                    forState:UIControlStateNormal];
                _cancelButton.layer.cornerRadius = 20;
                _cancelButton.layer.borderWidth = 1;
                _cancelButton.layer.borderColor = UIColorHex(ff6440).CGColor;
                [_cancelButton addTarget:self
                                  action:@selector(dismiss)
                        forControlEvents:UIControlEventTouchUpInside];
                [_contentView addSubview:_cancelButton];
                [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(_contentView).offset(15);
                    make.centerX.equalTo(_contentView);
                    make.bottom.equalTo(_contentView).offset(-15);
                    make.height.mas_equalTo(40);
                }];
            }
            
            if (!_itemsScrollView) {
                _itemsScrollView = ({
                    UIScrollView *scrollView = [UIScrollView new];
                    scrollView;
                });
                [_contentView addSubview:_itemsScrollView];
                [_itemsScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.left.right.equalTo(_contentView).insets(UIEdgeInsetsMake(20, 0, 0, 0));
                    make.bottom.equalTo(_cancelButton.mas_top).offset(-20);
                }];
            }
        }
        
        CGFloat itemWidth = kScreenWidth * 0.15;
        CGFloat itemSpace = kScreenWidth * 0.08;
        UIButton *shareWX = [UIButton buttonWithType:UIButtonTypeCustom];
        shareWX.tag = kButtonBaseTag;
        [_itemsScrollView addSubview:shareWX];
        [shareWX setImage:[UIImage imageNamed:@"share_wx"]
                 forState:UIControlStateNormal];
        shareWX.tag = kButtonBaseTag + 0;
        [shareWX addTarget:self
                    action:@selector(didClickShareButton:)
          forControlEvents:UIControlEventTouchUpInside];
        [shareWX mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_itemsScrollView).offset(15);
            make.left.equalTo(_itemsScrollView).offset(itemSpace);
            make.width.height.equalTo(itemWidth);
        }];
        
        UILabel *wxLabel = [UILabel new];
        [_itemsScrollView addSubview:wxLabel];
        wxLabel.text = @"微信好友";
        wxLabel.textColor = [UIColor colorWithHexString:@"333333"];
        wxLabel.font = [UIFont systemFontOfSize:14];
        [wxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(shareWX.mas_bottom);
            make.centerX.equalTo(shareWX);
        }];
        
        UIButton *shareQuan = [UIButton buttonWithType:UIButtonTypeCustom];
        [_itemsScrollView addSubview:shareQuan];
        shareQuan.tag = kButtonBaseTag + 1;
        [shareQuan addTarget:self
                      action:@selector(didClickShareButton:)
            forControlEvents:UIControlEventTouchUpInside];
        [shareQuan setImage:[UIImage imageNamed:@"share_quan"]
                   forState:UIControlStateNormal];
        
        [shareQuan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(shareWX);
            make.left.equalTo(shareWX.mas_right).offset(itemSpace);
            make.width.height.equalTo(itemWidth);
        }];
        
        UILabel *quanLabel = [UILabel new];
        [_itemsScrollView addSubview:quanLabel];
        quanLabel.text = @"微信朋友圈";
        quanLabel.textColor = [UIColor colorWithHexString:@"333333"];
        quanLabel.font = [UIFont systemFontOfSize:14];
        [quanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(shareQuan.mas_bottom);
            make.centerX.equalTo(shareQuan);
        }];
        
        UIButton *shareQQ = [UIButton buttonWithType:UIButtonTypeCustom];
        [_itemsScrollView addSubview:shareQQ];
        shareQQ.tag = kButtonBaseTag + 2;
        [shareQQ addTarget:self
                    action:@selector(didClickShareButton:)
          forControlEvents:UIControlEventTouchUpInside];
        [shareQQ setImage:[UIImage imageNamed:@"share_qq"]
                 forState:UIControlStateNormal];
        
        [shareQQ mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(shareWX);
            make.left.equalTo(shareQuan.mas_right).offset(itemSpace);
            make.width.height.equalTo(itemWidth);
        }];
        
        UILabel *qqLabel = [UILabel new];
        [_itemsScrollView addSubview:qqLabel];
        qqLabel.text = @"QQ好友";
        qqLabel.textColor = [UIColor colorWithHexString:@"333333"];
        qqLabel.font = [UIFont systemFontOfSize:14];
        [qqLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(shareQQ.mas_bottom);
            make.centerX.equalTo(shareQQ);
        }];
        
        UIButton *shareZone = [UIButton buttonWithType:UIButtonTypeCustom];
        [_itemsScrollView addSubview:shareZone];
        shareZone.tag = kButtonBaseTag + 3;
        [shareZone addTarget:self
                      action:@selector(didClickShareButton:)
            forControlEvents:UIControlEventTouchUpInside];
        [shareZone setImage:[UIImage imageNamed:@"share_zone"]
                   forState:UIControlStateNormal];
        
        [shareZone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(shareWX);
            make.left.equalTo(shareQQ.mas_right).offset(itemSpace);
            make.width.height.equalTo(itemWidth);
        }];
        
        UILabel *zoneLabel = [UILabel new];
        [_itemsScrollView addSubview:zoneLabel];
        zoneLabel.text = @"QQ空间";
        zoneLabel.textColor = [UIColor colorWithHexString:@"333333"];
        zoneLabel.font = [UIFont systemFontOfSize:14];
        [zoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(shareZone.mas_bottom);
            make.centerX.equalTo(shareZone);
        }];
        
        _itemsScrollView.contentSize = CGSizeMake(kScreenWidth, itemWidth + 20);
        
        CGFloat contentHeight = 15 + 40 + 20 + itemWidth + 20 + 40;
        _contentView.size = CGSizeMake(kScreen_Width, contentHeight);
        _contentView.top = kScreenHeight;
        [self addSubview:_contentView];
    }
    return self;
}

- (void)didClickShareButton:(UIButton *)button {
    if (button.tag - kButtonBaseTag == 0) {
        [self shareToWeChat];
    } else if (button.tag - kButtonBaseTag == 1) {
        [self shareToWeChatFriendsList];
    } else if (button.tag - kButtonBaseTag == 2) {
        [self shareToQQ];
    } else if (button.tag - kButtonBaseTag == 3) {
        [self shareToQzone];
    }
    [self dismiss];
}

- (void)dismiss {
    CGPoint endCenter = self.contentView.center;
    endCenter.y += CGRectGetHeight(self.contentView.frame);
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.bgView.alpha = 0.0;
        self.contentView.center = endCenter;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

+ (instancetype)sharedInstance {
    static ShareView *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ShareView alloc] init];
    });
    return sharedInstance;
}

- (void)showShareView {
    [kKeyWindow addSubview:self];
    CGPoint endCenter = self.contentView.center;
    endCenter.y -= CGRectGetHeight(self.contentView.frame);
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.bgView.alpha = 0.3;
        self.contentView.center = endCenter;
    } completion:nil];
}

/// 分享到微信好友
- (void)shareToWeChat {
    [UMSocialData defaultData].extConfig.wechatSessionData.url = [self getUrl];
    [UMSocialData defaultData].extConfig.wechatSessionData.title =
    [self getTitle];
    [[UMSocialDataService defaultDataService]
     postSNSWithTypes:@[ UMShareToWechatSession ]
     content:[self getContentWX]
     image:[self getImage]
     location:nil
     urlResource:[self getUrlResoure]
     presentedController:nil
     completion:^(UMSocialResponseEntity *response) {
         if (response.responseCode == UMSResponseCodeSuccess) {
             NSLog(@"分享成功");
         } else if (response.responseCode != UMSResponseCodeCancel) {
         }
     }];
}

/// 分享到微信朋友圈
- (void)shareToWeChatFriendsList {
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = [self getUrl];
    [UMSocialData defaultData].extConfig.wechatTimelineData.title =
    [self getTitle];
    [[UMSocialDataService defaultDataService]
     postSNSWithTypes:@[ UMShareToWechatTimeline ]
     content:[self getContentWX]
     image:[self getImage]
     location:nil
     urlResource:[self getUrlResoure]
     presentedController:nil
     completion:^(UMSocialResponseEntity *response) {
         if (response.responseCode == UMSResponseCodeSuccess) {
             NSLog(@"分享成功");
         } else if (response.responseCode != UMSResponseCodeCancel) {
         }
     }];
}

- (void)shareToQQ {
    
#ifdef TARGET_PARENT
    
    [UMSocialData defaultData].extConfig.qqData.url = [self getUrl];
    [UMSocialQQHandler setQQWithAppId:@"1104761282"
                               appKey:@"vtnnMN5Ixc56gooz"
                                  url:@"http://www.jyex.cn"];
    [UMSocialData defaultData].extConfig.qqData.title = [self getTitle];
    [[UMSocialDataService defaultDataService]
     postSNSWithTypes:@[ UMShareToQQ ]
     content:[self getContent]
     image:[self getImage]
     location:nil
     urlResource:[self getUrlResoure]
     presentedController:nil
     completion:^(UMSocialResponseEntity *response) {
         if (response.responseCode == UMSResponseCodeSuccess) {
             NSLog(@"分享成功！");
         }
     }];
    
#elif TARGET_TEACHER
    [UMSocialData defaultData].extConfig.qqData.url = [self getUrl];
    [UMSocialQQHandler setQQWithAppId:@"1104803224"
                               appKey:@"UA0XxanXoaui9RHx"
                                  url:@"http://www.jyex.cn"];
    [[UMSocialDataService defaultDataService]
     postSNSWithTypes:@[ UMShareToQQ ]
     content:[self getContent]
     image:[self getImage]
     location:nil
     urlResource:[self getUrlResoure]
     presentedController:nil
     completion:^(UMSocialResponseEntity *response) {
         if (response.responseCode == UMSResponseCodeSuccess) {
             NSLog(@"分享成功！");
         }
     }];
    
#elif TARGET_MASTER
    [UMSocialData defaultData].extConfig.qqData.url = [self getUrl];
    [UMSocialQQHandler setQQWithAppId:@"1104803226"
                               appKey:@"n2z9sEUJynKloumw"
                                  url:@"http://www.jyex.cn"];
    [[UMSocialDataService defaultDataService]
     postSNSWithTypes:@[ UMShareToQQ ]
     content:[self getContent]
     image:[self getImage]
     location:nil
     urlResource:[self getUrlResoure]
     presentedController:nil
     completion:^(UMSocialResponseEntity *response) {
         if (response.responseCode == UMSResponseCodeSuccess) {
             NSLog(@"分享成功！");
         }
     }];
    
#endif
}

- (void)shareToQzone {
    
    //    [UMSocialData defaultData].extConfig.qzoneData.url = [self
    //    getUrl];//@"http://www.jyex.cn";//;
    
#ifdef TARGET_PARENT
    
    [UMSocialData defaultData].extConfig.qzoneData.url = [self getUrl];
    [UMSocialData defaultData].extConfig.qzoneData.title = [self getTitle];
    [UMSocialQQHandler setQQWithAppId:@"1104761282"
                               appKey:@"vtnnMN5Ixc56gooz"
                                  url:@"http://www.jyex.cn"];
    [[UMSocialDataService defaultDataService]
     postSNSWithTypes:@[ UMShareToQzone ]
     content:[self getContent]
     image:[self getImage]
     location:nil
     urlResource:[self getUrlResoure]
     presentedController:nil
     completion:^(UMSocialResponseEntity *response) {
         if (response.responseCode == UMSResponseCodeSuccess) {
             NSLog(@"分享成功！");
         }
     }];
    
#elif TARGET_TEACHER
    [UMSocialData defaultData].extConfig.qzoneData.url = [self getUrl];
    [UMSocialQQHandler setQQWithAppId:@"1104803224"
                               appKey:@"UA0XxanXoaui9RHx"
                                  url:@"http://www.jyex.cn"];
    [[UMSocialDataService defaultDataService]
     postSNSWithTypes:@[ UMShareToQzone ]
     content:[self getContent]
     image:[self getImage]
     location:nil
     urlResource:[self getUrlResoure]
     presentedController:nil
     completion:^(UMSocialResponseEntity *response) {
         if (response.responseCode == UMSResponseCodeSuccess) {
             NSLog(@"分享成功！");
         }
     }];
    
#elif TARGET_MASTER
    [UMSocialData defaultData].extConfig.qzoneData.url = [self getUrl];
    [UMSocialQQHandler setQQWithAppId:@"1104803226"
                               appKey:@"n2z9sEUJynKloumw"
                                  url:@"http://www.jyex.cn"];
    [[UMSocialDataService defaultDataService]
     postSNSWithTypes:@[ UMShareToQzone ]
     content:[self getContent]
     image:[self getImage]
     location:nil
     urlResource:[self getUrlResoure]
     presentedController:nil
     completion:^(UMSocialResponseEntity *response) {
         if (response.responseCode == UMSResponseCodeSuccess) {
             NSLog(@"分享成功！");
         }
     }];
    
#endif
}

- (NSString *)getTitle {
    if (self.shareType == BBQShareTypeDynamic) {
        return nil;
    }
    return self.shareTitle;
}

- (NSString *)getUrl {
    if (self.shareType == BBQShareTypeDynamic) {
        NSString *url = [NSString
                         stringWithFormat:@"%@%@%@", CS_URL_BASE, URL_DYNA_H5, self.model.guid];
        
        return url;
    }
    return self.shareURL;
}

- (NSString *)getContent {
    if (self.shareType == BBQShareTypeDynamic) {
        NSString *strName;
        if (TheCurBaoBao.gxid.integerValue > 0) {
            strName = [TheCurBaoBao.nickname
                       stringByAppendingString: [NSString relationshipWithID:TheCurBaoBao.gxid gxname:TheCurBaoBao.gxname]];
        } else if (TheCurUser.member.nickname.length > 0)
            strName = TheCurUser.member.nickname;
        else if (TheCurUser.member.realname.length > 0)
            strName = TheCurUser.member.realname;
        else
            strName = TheCurUser.member.username;
        
        NSString *string =
        [NSString stringWithFormat:@"[宝宝圈]%@分享的动态。%@%@%@", strName,
         CS_URL_BASE, URL_DYNA_H5, self.model.guid];
        
        return string;
    }
    return self.shareContent;
}

- (NSString *)getContentWX {
    if (self.shareType == BBQShareTypeDynamic) {
        NSString *strName;
        if (TheCurBaoBao.gxid.integerValue > 0) {
            strName = [TheCurBaoBao.nickname
                       stringByAppendingString: [NSString relationshipWithID:TheCurBaoBao.gxid gxname:TheCurBaoBao.gxname]];
        } else if (TheCurUser.member.nickname.length > 0)
            strName = TheCurUser.member.nickname;
        else if (TheCurUser.member.realname.length > 0)
            strName = TheCurUser.member.realname;
        else
            strName = TheCurUser.member.username;
        
        NSString *string =
        [NSString stringWithFormat:@"[宝宝圈]%@分享的动态", strName];
        
        return string;
    }
    return self.shareContent;
}

- (UMSocialUrlResource *)getUrlResoure {
    if (self.shareType == BBQShareTypeDynamic) {
        UMSocialUrlResourceType resourcetype;
        if (self.model.attachinfo.count > 0) {
            Attachment *attach = [self.model.attachinfo firstObject];
            NSString *url = attach.filepath;
            if (attach.itype.integerValue == BBQAttachmentTypePhoto)
                resourcetype = UMSocialUrlResourceTypeImage;
            else
                resourcetype = UMSocialUrlResourceTypeVideo;
            
            UMSocialUrlResource *urlResource =
            [[UMSocialUrlResource alloc] initWithSnsResourceType:resourcetype
                                                             url:url];
            
            return urlResource;
        }
        return nil;
    }
    return nil;
}

- (UIImage *)getImage {
    UIImage *img = [UIImage imageNamed:@"place_color_pander"];
    return img;
}

@end
