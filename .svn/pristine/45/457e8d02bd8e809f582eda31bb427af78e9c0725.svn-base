//
//  BBQIndicatorBar.m
//  BBQ
//
//  Created by anymuse on 15/8/18.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQIndicatorBar.h"
#import <Masonry.h>
#import "UploadRecordViewController.h"
#import "AppMacro.h"
#import "BizLogic_Dyna.h"

@interface BBQIndicatorBar ()

@end

@implementation BBQIndicatorBar

- (void)awakeFromNib {
  [[NSBundle mainBundle] loadNibNamed:@"BBQIndicatorBar"
                                owner:self
                              options:nil];
  [self addSubview:self.contentView];

  self.alpha = 0.9;
  self.hidden = YES;
  self.userInteractionEnabled = YES;

  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(handleUpdateDynamicStartNotification:)
             name:kStartUploadDynamic
           object:nil];
  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(handleUpdateDynamicEndNotification:)
             name:kDeleteDynamicNotification
           object:nil];
  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(handleUpdateDynamicEndNotification:)
             name:NOTIFICATION_SYNC_FINISH
           object:nil];
  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(handleUpdateDynamicEndNotification:)
             name:kUpdateDynamicStatusNotification
           object:nil];

  UITapGestureRecognizer *tap =
      [[UITapGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(didTapOnBar:)];
  [self addGestureRecognizer:tap];

  [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self);
  }];
}

- (void)handleUpdateDynamicStartNotification:(NSNotification *)notification {
//  NSArray *uploadDynamics = [BizLogic getLocalUploadDyna:nil limit:20];
//  if (uploadDynamics.count) {
//    self.statusLabel.text = [NSString
//        stringWithFormat:@"%@条动态正在上传中...", @(uploadDynamics.count)];
//    if (!self.isShow) {
//      [self show];
//    }
//  }
}

- (void)handleUpdateDynamicEndNotification:(NSNotification *)notification {
//  NSArray *uploadDynamics = [BizLogic getLocalUploadDyna:nil limit:20];
//  if (!uploadDynamics.count) {
//    self.statusLabel.text = @"所有动态上传成功";
//    [self dismiss];
//  } else {
//    self.statusLabel.text = [NSString
//        stringWithFormat:@"%@条动态正在上传中...", @(uploadDynamics.count)];
//  }
}

- (void)didTapOnBar:(UITapGestureRecognizer *)recognizer {
  UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Common" bundle:nil];
  UploadRecordViewController *urvc =
      [sb instantiateViewControllerWithIdentifier:@"UploadRecordVC"];
  [self.vc.navigationController pushViewController:urvc animated:YES];
}

- (void)show {
  if (self.isShow)
    return;
  self.hidden = NO;
  dispatch_async_on_main_queue(^{
    self.isShow = YES;
    self.topCons.constant = 0;
    [UIView animateWithDuration:0.3
                     animations:^{
                       [self layoutIfNeeded];
                     }
                     completion:nil];
  });
}

- (void)dismiss {
  if (!self.isShow)
    return;
  dispatch_async_on_main_queue(^{
    self.userInteractionEnabled = NO;
    self.topCons.constant = -CGRectGetHeight(self.frame);

    [UIView animateWithDuration:0.3
        animations:^{
          [self layoutIfNeeded];
        }
        completion:^(BOOL finished) {
          self.isShow = NO;
          self.hidden = YES;
          self.userInteractionEnabled = YES;
        }];
  });
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
