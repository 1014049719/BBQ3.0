//
//  LoadingView.m
//  BBQ
//
//  Created by 朱琨 on 15/9/2.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "LoadingView.h"
#import "WDActivityIndicator.h"
#import <Masonry.h>

@interface LoadingView ()

@property(strong, nonatomic) WDActivityIndicator *activityIndicator;
@property(weak, nonatomic) IBOutlet UIView *loadingView;
@property(weak, nonatomic) IBOutlet UIView *errorView;
@property(weak, nonatomic) IBOutlet UIImageView *noContentView;
@property(weak, nonatomic) IBOutlet UIButton *loadButton;
@property(strong, nonatomic) UIView *originalSuperView;
@property(weak, nonatomic) IBOutlet UIButton *refreshButton;

@end

@implementation LoadingView

- (void)awakeFromNib {
  self.activityIndicator = [WDActivityIndicator new];
  [self.loadingView addSubview:self.activityIndicator];
  [self.activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(self.loadingView);
    make.bottom.equalTo(self.loadingView);
    make.width.height.equalTo(24);
  }];

  self.status = BBQLoadingViewStatusLoading;
  self.loadButton.layer.masksToBounds = YES;
  self.loadButton.layer.cornerRadius = 5;
  self.loadButton.layer.borderColor = [UIColor colorWithHexString:@"999999"].CGColor;
  self.loadButton.layer.borderWidth = 1;

  self.refreshButton.layer.masksToBounds = YES;
  self.refreshButton.layer.cornerRadius = 5;
  self.refreshButton.layer.borderColor =
      [UIColor colorWithHexString:@"999999"].CGColor;
  self.refreshButton.layer.borderWidth = 1;
}

- (void)setStatus:(BBQLoadingViewStatus)status {
  _status = status;
    dispatch_async(dispatch_get_main_queue(), ^{
        
    });
  dispatch_async_on_main_queue(^{
    self.alpha = 1;
    switch (status) {
    case BBQLoadingViewStatusLoading: {
      self.loadingView.hidden = NO;
      self.noContentView.hidden = YES;
      self.errorView.hidden = YES;
      self.refreshButton.hidden = YES;
      [self startAnimating];
    } break;
    case BBQLoadingViewStatusNoContent: {
      [self stopAnimating];
      self.loadingView.hidden = YES;
      self.noContentView.hidden = NO;
      self.refreshButton.hidden = NO;
      self.errorView.hidden = YES;
    } break;
    case BBQLoadingViewStatusError: {
      [self stopAnimating];
      self.loadingView.hidden = YES;
      self.noContentView.hidden = YES;
      self.refreshButton.hidden = YES;
      self.errorView.hidden = NO;
    } break;
    default:
      break;
    }
  });
}

- (void)startAnimating {
  [self.activityIndicator startAnimating];
}

- (void)stopAnimating {
  [self.activityIndicator stopAnimating];
}

- (void)dismiss {
  dispatch_async_on_main_queue(^{
    [UIView animateWithDuration:0.3
        animations:^{
          self.alpha = 0;
        }
        completion:^(BOOL finished) {
          if (finished) {
            [self stopAnimating];
            [self removeFromSuperview];
          }
        }];
  });
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
  if (newSuperview) {
    self.isShowing = YES;
  }
}

- (void)didMoveToSuperview {
  if (!self.superview) {
    self.isShowing = NO;
  } else {
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
      make.edges.equalTo(self.superview);
    }];
  }
}

- (IBAction)didClickLoadButton:(id)sender {
  self.status = BBQLoadingViewStatusLoading;
  if (self.buttonBlock) {
    self.buttonBlock();
  }
}

@end
