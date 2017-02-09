//
//  BuyCardView.m
//  BBQ
//
//  Created by anymuse on 15/7/24.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BuyCardView.h"
#import "BlurView.h"
#import <Masonry.h>

@interface BuyCardView ()

@property(strong, nonatomic) BlurView *blurView;
@property(strong, nonatomic) UILabel *priceLabel;

@property(strong, nonatomic) UIButton *alipayButton;
@property(strong, nonatomic) UIButton *wXButton;
@property(strong, nonatomic) UIButton *lastButton;

@end

@implementation BuyCardView

- (instancetype)init {
  if (self = [super init]) {
    _blurView = [BlurView sharedInstance];
    WS(weakSelf)
    _blurView.touchBlock = ^{
      [weakSelf hideSelf];
    };
    self.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 250);
    self.backgroundColor = [UIColor whiteColor];
    UILabel *needToPayLabel = [UILabel new];
    [self addSubview:needToPayLabel];
    needToPayLabel.textColor = [UIColor colorWithHexString:@"999999"];
    needToPayLabel.text = @"需支付";
    needToPayLabel.font = [UIFont systemFontOfSize:12];
    [needToPayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self).offset(20);
      make.left.equalTo(self).offset(15);
      make.height.equalTo(12);
    }];

    _priceLabel = [UILabel new];
    [self addSubview:_priceLabel];
    _priceLabel.textColor = [UIColor colorWithHexString:@"ff6440"];
    _priceLabel.font = [UIFont systemFontOfSize:18];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.right.equalTo(self).offset(-30);
      make.centerY.equalTo(needToPayLabel);
    }];

    UIView *separateLine = [UIView new];
    [self addSubview:separateLine];
    separateLine.backgroundColor = [UIColor colorWithHexString:@"999999"];
    [separateLine mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(needToPayLabel.mas_bottom).offset(20);
      make.left.right.equalTo(self);
      make.height.equalTo(1);
    }];

    UILabel *choosePayWayLabel = [UILabel new];
    [self addSubview:choosePayWayLabel];
    choosePayWayLabel.text = @"选择支付方式";
    choosePayWayLabel.textColor = [UIColor colorWithHexString:@"999999"];
    choosePayWayLabel.font = [UIFont systemFontOfSize:12];
    [choosePayWayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(separateLine.mas_bottom).offset(20);
      make.left.equalTo(needToPayLabel);
      make.height.equalTo(12);
    }];

    UIImage *selectedBgImage = [[UIImage imageNamed:@"choose_selected"]
        resizableImageWithCapInsets:UIEdgeInsetsMake(30, 60, 60, 30)];
    UIImage *unselectedBgImage = [[UIImage imageNamed:@"choose_unselected"]
        resizableImageWithCapInsets:UIEdgeInsetsMake(30, 60, 60, 30)];

    _wXButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_wXButton];
    [_wXButton addTarget:self
                  action:@selector(didMakeAChoice:)
        forControlEvents:UIControlEventTouchUpInside];
    [_wXButton setBackgroundImage:unselectedBgImage
                         forState:UIControlStateNormal];
    [_wXButton setBackgroundImage:selectedBgImage
                         forState:UIControlStateSelected];
    _wXButton.adjustsImageWhenHighlighted = NO;
    UIImageView *wxTitleView =
        [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"card_wx"]];
    [_wXButton addSubview:wxTitleView];
    [wxTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.center.equalTo(_wXButton);
      make.height.equalTo(35);
      make.width.equalTo(wxTitleView.mas_height).dividedBy(70 / 221.0);
    }];

    _alipayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_alipayButton];
    [_alipayButton addTarget:self
                      action:@selector(didMakeAChoice:)
            forControlEvents:UIControlEventTouchUpInside];
    [_alipayButton setBackgroundImage:unselectedBgImage
                             forState:UIControlStateNormal];
    [_alipayButton setBackgroundImage:selectedBgImage
                             forState:UIControlStateSelected];
    _alipayButton.adjustsImageWhenHighlighted = NO;
    UIImageView *alipayTitleView =
        [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"card_alipay"]];
    [_alipayButton addSubview:alipayTitleView];
    [alipayTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.center.equalTo(_alipayButton);
      make.height.equalTo(30);
      make.width.equalTo(alipayTitleView.mas_height).dividedBy(60 / 183.0);
    }];
    [_alipayButton mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(choosePayWayLabel.mas_bottom).offset(20);
      make.left.equalTo(choosePayWayLabel);
      make.height.equalTo(65);
      make.width.equalTo(_wXButton);
      make.right.equalTo(_wXButton.mas_left).offset(-20);
    }];

    [_wXButton mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(_alipayButton);
      make.right.equalTo(self).offset(-15);
      make.left.equalTo(_alipayButton.mas_right).offset(20);
      make.width.equalTo(_alipayButton);
      make.height.equalTo(_alipayButton);
    }];

    _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_confirmButton];
    [_confirmButton
        setBackgroundImage:[[UIImage imageNamed:@"card_confirm"]
                               resizableImageWithCapInsets:UIEdgeInsetsMake(
                                                               0, 50, 0, 50)]
                  forState:UIControlStateNormal];
    [_confirmButton setTitle:@"确认支付" forState:UIControlStateNormal];
    [_confirmButton setTitleColor:[UIColor whiteColor]
                         forState:UIControlStateNormal];
    [_confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(self).offset(15);
      make.right.equalTo(self).offset(-15);
      make.height.equalTo(49);
      make.bottom.equalTo(self).offset(-10);
    }];

    //[self didMakeAChoice:_alipayButton];
  }
  return self;
}

- (void)didMakeAChoice:(UIButton *)button {

  self.payWay =
      (button == self.alipayButton) ? ChosedPayWayAlipay : ChosedPayWayWX;
  if (self.lastButton != button) {
    button.selected = YES;
    if (!self.lastButton) {
      self.lastButton = button;
      return;
    }
    self.lastButton.selected = NO;
    self.lastButton = button;
  }
}

- (void)showBuyCardViewWithPrice:(float)price {
    dispatch_async_on_main_queue(^{
        [self.blurView showBlurView];
        self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f", price];
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.frame = CGRectMake(
                                                     0, kScreenHeight - CGRectGetHeight(self.frame),
                                                     kScreenWidth, CGRectGetHeight(self.frame));
                         }];
        WS(weakSelf)
        self.blurView.touchBlock = ^{
            [weakSelf hideSelf];
        };
    });
}

- (void)hideSelf {
    dispatch_async_on_main_queue(^{
        [self.blurView hideBlurView];
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.frame = CGRectMake(0, kScreenHeight, kScreenWidth,
                                                     CGRectGetHeight(self.frame));
                         }
                         completion:^(BOOL finished) {
                             if (finished) {
                                 [self removeFromSuperview];
                             }
                         }];
    });
}
@end
