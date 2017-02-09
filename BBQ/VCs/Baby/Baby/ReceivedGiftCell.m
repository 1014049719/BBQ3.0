//
//  ReceivedGiftCell.m
//  BBQ
//
//  Created by anymuse on 15/8/4.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "ReceivedGiftCell.h"
#import <DateTools.h>
#import "NSString+Common.h"

@implementation ReceivedGiftCell

- (void)awakeFromNib {
  self.fbztxImageView.layer.masksToBounds = YES;
  self.fbztxImageView.layer.cornerRadius =
      CGRectGetHeight(self.fbztxImageView.frame) / 2;
}

- (void)setModel:(Gift *)model {
  _model = model;
  self.fbztxImageView.image = nil;
  self.giftImageView.image = nil;

  self.datelineLabel.text = [NSDate
      timeAgoSinceDate:
          [NSDate dateWithTimeIntervalSince1970:[model.dateline integerValue]]];
  if (model.groupkey.integerValue == BBQGroupkeyTypeParent) {
      NSString *relation = [NSString relationshipWithID:model.gxid gxname:model.gxname];
    self.nicknameLabel.text =
        [model.baobaoname stringByAppendingString:relation];
  } else {
    self.nicknameLabel.text = model.nickname;
  }

  self.giftInfoLabel.text = [NSString
      stringWithFormat:@"赠送了%@份%@", model.giftcount,
                       model.giftname];
}

- (void)cancelAllOperations {
  [self.giftImageView cancelCurrentImageRequest];
  [self.fbztxImageView cancelCurrentImageRequest];
}
- (void)loadImages {
    [self.giftImageView setImageWithURL:[NSURL URLWithString:self.model.imgurl] placeholder:nil];
    [self.fbztxImageView setImageWithURL:[NSURL URLWithString:self.model.fbztx] placeholder:Placeholder_avatar options:YYWebImageOptionRefreshImageCache | YYWebImageOptionSetImageWithFadeAnimation completion:nil];
}
@end
