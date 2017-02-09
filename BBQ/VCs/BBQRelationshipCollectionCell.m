//
//  BBQRelationshipCollectionCell.m
//  BBQ
//
//  Created by slovelys on 15/10/23.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQRelationshipCollectionCell.h"

@implementation BBQRelationshipCollectionCell

- (void)layoutSubviews {
  [super layoutSubviews];

  self.btn.layer.cornerRadius = self.btn.frame.size.height / 2;
}

@end
