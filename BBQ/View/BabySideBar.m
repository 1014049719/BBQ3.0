//
//  BabySideBar.m
//  BBQ
//
//  Created by anymuse on 15/8/6.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BabySideBar.h"
#import "SwitchBabyButton.h"
#import <Masonry.h>
#import "DataSync.h"
#import "AppMacro.h"


@interface BabySideBarOverlayView : UIView

@property(strong, nonatomic) BabySideBar *sideBar;

@end

@implementation BabySideBarOverlayView

- (nonnull instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = [UIColor blackColor];
    self.alpha = 0;
  }
  return self;
}

- (void)touchesEnded:(nonnull NSSet *)touches
           withEvent:(nullable UIEvent *)event {

  [self.sideBar dismissSideBar];
}

@end

@interface BabySideBar ()

@property(strong, nonatomic) BabySideBarOverlayView *overlayView;
@property(strong, nonatomic) SwitchBabyButton *currentButton;
@property(strong, nonatomic) NSMutableArray *buttonArray;

@end

static NSInteger const kBaseTag = 1314;
@implementation BabySideBar

- (nonnull instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    _barWitdh = CGRectGetWidth(frame);
    _isShowing = NO;
    _buttonArray = [NSMutableArray array];
    self.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
  }
  return self;
}

- (void)loadBabyData {
  CGFloat buttonHeight = (_barWitdh - 20) * 10 / 39.0;
  self.contentSize =
      CGSizeMake(CGRectGetWidth(self.frame),
                 TheGlobal.m_arrBaobaoData.count * (buttonHeight + 10) + 10);

  [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
  [TheGlobal.m_arrBaobaoData enumerateObjectsUsingBlock:^(TJYEXBaoBaoData *baby,
                                                          NSUInteger idx,
                                                          BOOL *stop) {
    SwitchBabyButton *button =
        [[NSBundle mainBundle] loadNibNamed:@"SwitchBabyButton"
                                      owner:self
                                    options:nil]
            .firstObject;
    button.tag = kBaseTag + idx;
    [button.checkBabyButton addTarget:self
                               action:@selector(didClickCheckBabyButton:)
                     forControlEvents:UIControlEventTouchUpInside];

    if ([baby.avatar hasPrefix:@"http://"]) {
      [button.babyHeadView
          setImageWithURL:[NSURL URLWithString:baby.avatar]
                 placeholder:[UIImage imageNamed:@"placeholder_panda"]
                     options:YYWebImageOptionSetImageWithFadeAnimation
                  completion:nil];
    } else {
      button.babyHeadView.image = [UIImage imageWithContentsOfFile:baby.avatar];
    }

    button.sBaobaouid = baby.sBaobaouid;
    [button.babyBgButton addTarget:self
                            action:@selector(didClickBabyButton:)
                  forControlEvents:UIControlEventTouchUpInside];
    if ([button.sBaobaouid isEqualToString:TheCurBaoBao.sBaobaouid]) {
      self.currentButton = button;
      button.babyBgButton.selected = YES;
      button.babyNameLabel.textColor = [UIColor colorWithHexString:@"ff6440"];
    }
    button.babyNameLabel.text = baby.sRealname;
    if (baby.birthyear == 0) {
      button.babyAgeLabel.text = nil;
    } else {
      button.babyAgeLabel.text = [CommonFunc getAgeWithYear:baby.birthyear
                                                      month:baby.birthmonth
                                                        day:baby.birthday];
    }

    [self addSubview:button];
    [self.buttonArray addObject:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.equalTo(self.mas_centerX);
      make.height.equalTo(buttonHeight);
      make.width.equalTo(button.mas_height).multipliedBy(3.9);
      make.top.equalTo(self).offset(buttonHeight * idx + (idx + 1) * 10);
    }];

    [self setNeedsLayout];
    [self layoutIfNeeded];
    [self.buttonArray enumerateObjectsUsingBlock:^(SwitchBabyButton *buttn,
                                                   NSUInteger idx, BOOL *stop) {
      buttn.babyHeadView.layer.masksToBounds = YES;
      buttn.babyHeadView.contentMode = UIViewContentModeScaleAspectFill;
      buttn.babyHeadView.layer.cornerRadius =
          CGRectGetHeight(buttn.babyHeadView.frame) / 2.0;
    }];
  }];
}

- (void)didClickBabyButton:(UIButton *)button {
  SwitchBabyButton *switchButton = (SwitchBabyButton *)button.superview;
  TJYEXBaoBaoData *baby =
      TheGlobal.m_arrBaobaoData[switchButton.tag - kBaseTag];
  if (baby.gxid < 1 && TheCurUser.groupkey == 1) {
    [[NSNotificationCenter defaultCenter]
        postNotificationName:kNeedCompleteRelationship
                      object:nil
                    userInfo:@{
                      @"data" : baby
                    }];
    return;
  }

  if (self.currentButton != button.superview) {
    self.currentButton.babyNameLabel.textColor =
        [UIColor colorWithHexString:@"333333"];
    switchButton = (SwitchBabyButton *)button.superview;
    switchButton.babyNameLabel.textColor = [UIColor colorWithHexString:@"ff6440"];
    self.currentButton.babyBgButton.selected = NO;
    button.selected = YES;
    self.currentButton = switchButton;
    TheCurBaoBao = TheGlobal.m_arrBaobaoData[switchButton.tag - kBaseTag];

    [[NSNotificationCenter defaultCenter]
        postNotificationName:kSetNeedsRefreshEntireDataNotification
                      object:nil
                    userInfo:@{
                      @"type" : @(BBQRefreshNotificationTypeAll)
                    }];

    [[NSNotificationCenter defaultCenter]
        postNotificationName:@"refreshBabyRootView"
                      object:nil];

    //发送获取删除的动态的通知
    [[DataSync instance] syncRequest:BIZ_SYNC_GET_DELETED_DYNA:nil:nil:nil];
    //更新刷新页面计数值
    [_GLOBAL addRefreshPageCount];
  }
}

- (void)dismissSideBar {
  if (!self.isShowing)
    return;
  CGRect frame = self.frame;
  frame.origin.x = -self.barWitdh;
  if (self.willAnimateBlock) {
    self.willAnimateBlock();
  }
  [UIView animateWithDuration:0.3
      animations:^{
        self.frame = frame;
        self.overlayView.alpha = 0;
      }
      completion:^(BOOL finished) {
        if (finished) {
          self.isShowing = NO;
          [self removeFromSuperview];
          [self.overlayView removeFromSuperview];
          if (self.finishAnimationBlock) {
            self.finishAnimationBlock();
          }
        }
      }];
}

- (void)showSideBar {
  if (self.isShowing)
    return;
  [self loadBabyData];
  if (!self.overlayView) {
    self.overlayView = [[BabySideBarOverlayView alloc]
        initWithFrame:CGRectMake(0, CGRectGetMinY(self.frame), kScreenWidth,
                                 CGRectGetHeight(self.frame))];
    self.overlayView.sideBar = self;
  }

  UIViewController *controller =
      [UIApplication sharedApplication].keyWindow.rootViewController;
  while (controller.presentedViewController != nil) {
    controller = controller.presentedViewController;
  }

  [controller.view addSubview:self.overlayView];
  [controller.view addSubview:self];
  CGRect frame = self.frame;
  frame.origin.x = 0;
  if (self.willAnimateBlock) {
    self.willAnimateBlock();
  }
  [UIView animateWithDuration:0.3
      animations:^{
        self.frame = frame;
        self.overlayView.alpha = 0.4;
      }
      completion:^(BOOL finished) {
        if (finished) {
          self.isShowing = YES;
          if (self.finishAnimationBlock) {
            self.finishAnimationBlock();
          }
        }
      }];
}

- (void)didClickCheckBabyButton:(UIButton *)button {
  if (self.checkBabyBlock) {
    self.checkBabyBlock(button.superview.tag - kBaseTag);
  }
}

@end
