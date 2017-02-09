//
//  BBQChooseStatusCell.m
//  DailyReportDemo
//
//  Created by 朱琨 on 15/10/8.
//  Copyright © 2015年 gzxlt. All rights reserved.
//

#import "BBQChooseStatusCell.h"

#import "BBQStatusButton.h"
#import "BBQDailyReportOptionModel.h"
#import <Masonry.h>


@interface BBQChooseStatusCell ()

@property(weak, nonatomic) IBOutlet UIImageView *avatar;
@property(weak, nonatomic) IBOutlet UILabel *nameLabel;
@property(weak, nonatomic) IBOutlet UILabel *statusLabel;
@property(weak, nonatomic) IBOutlet UIImageView *arrow;
@property(weak, nonatomic) IBOutlet UIButton *checkBoxButton;
@property(weak, nonatomic) IBOutlet UIView *optionView;

@property(weak, nonatomic) IBOutlet UIView *expandView;

@property(weak, nonatomic) IBOutlet NSLayoutConstraint *buttonWidth;

@property(weak, nonatomic) IBOutlet UILabel *label1;
@property(weak, nonatomic) IBOutlet UILabel *label2;
@property(weak, nonatomic) IBOutlet UILabel *label3;
@property(weak, nonatomic) IBOutlet UILabel *label4;
@property(weak, nonatomic) IBOutlet UILabel *label5;
@property(copy, nonatomic) NSArray *labelArray;

@property(weak, nonatomic) IBOutlet UIImageView *status1;
@property(weak, nonatomic) IBOutlet UIImageView *status2;
@property(weak, nonatomic) IBOutlet UIImageView *status3;
@property(weak, nonatomic) IBOutlet UIImageView *status4;
@property(weak, nonatomic) IBOutlet UIImageView *status5;
@property(copy, nonatomic) NSArray *statusArray;

@property(weak, nonatomic) IBOutlet UIView *option1;
@property(weak, nonatomic) IBOutlet UIView *option2;
@property(weak, nonatomic) IBOutlet UIView *option3;
@property(weak, nonatomic) IBOutlet UIView *option4;
@property(weak, nonatomic) IBOutlet UIView *option5;
@property(copy, nonatomic) NSArray *optionArray;

@end

@implementation BBQChooseStatusCell

- (void)awakeFromNib {
  self.labelArray =
      @[ self.label1, self.label2, self.label3, self.label4, self.label5 ];
  self.statusArray = @[
    self.status1,
    self.status2,
    self.status3,
    self.status4,
    self.status5
  ];
  self.optionArray = @[
    self.option1,
    self.option2,
    self.option3,
    self.option4,
    self.option5
  ];
  self.avatar.layer.masksToBounds = YES;
  self.avatar.layer.cornerRadius = CGRectGetHeight(self.avatar.frame) / 2.0;
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
      initWithTarget:self
              action:@selector(didTapExpandView)];
  [self.expandView addGestureRecognizer:tap];
  [self.optionArray
      enumerateObjectsUsingBlock:^(__kindof UIView *_Nonnull obj,
                                   NSUInteger idx, BOOL *_Nonnull stop) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
            initWithTarget:self
                    action:@selector(didTapStatusView:)];
        [obj addGestureRecognizer:tap];
      }];
}

- (void)setModel:(BBQBabyStatusModel *)model {
  _model = model;
  self.arrow.highlighted = _model.expand;

  self.buttonWidth.constant = kScreen_Width / model.options.count;
  ((UIImageView *)self.statusArray[model.selectedStatus]).highlighted = YES;
  [self.optionArray enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx,
                                                 BOOL *_Nonnull stop) {
    if (idx < model.options.count) {
      ((UILabel *)self.labelArray[idx]).text =
          ((BBQDailyReportOptionModel *)model.options[idx]).cval;
    } else {
      view.hidden = YES;
    }
  }];

  self.statusLabel.text =
      ((BBQDailyReportOptionModel *)model.options[model.selectedStatus]).cval;
  self.optionView.hidden = !model.expand;
  self.checkBoxButton.selected = model.selected;
  self.nameLabel.text = model.baby.realname;
  [self.avatar setImageWithURL:[NSURL URLWithString:model.baby.avartar]
                      placeholder:Placeholder_avatar
                          options:YYWebImageOptionSetImageWithFadeAnimation
                       completion:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
}
- (IBAction)didTapCheckBoxButton:(UIButton *)sender {
  sender.selected = !sender.selected;
  self.model.selected = sender.selected;
}

- (void)didTapStatusView:(UITapGestureRecognizer *)recognizer {
  NSInteger index = [self.optionArray indexOfObject:recognizer.view];
  if (self.model.selectedStatus != index) {
    ((UIImageView *)self.statusArray[self.model.selectedStatus]).highlighted =
        NO;
    self.model.selectedStatus = index;
    self.statusLabel.text = ((BBQDailyReportOptionModel *)
                                 self.model.options[self.model.selectedStatus])
                                .cval;
    ((UIImageView *)self.statusArray[index]).highlighted = YES;
  }
}

- (void)didTapExpandView {
  self.arrow.highlighted = !self.arrow.highlighted;
  if (self.expandBlock) {
    self.expandBlock(self.indexPath);
  }
}

@end
