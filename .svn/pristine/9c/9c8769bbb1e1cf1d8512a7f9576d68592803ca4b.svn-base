//
//  BBQAttentionClassCell.m
//  BBQ
//
//  Created by anymuse on 15/11/23.
//  Copyright © 2015年 bbq. All rights reserved.
//


#import "BBQAttentionClassCell.h"
#import "BBQClassDataModel.h"
#import "BBQAttentionClassWithBaby.h"
@interface BBQAttentionClassCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *classLabel;
@property (weak, nonatomic) IBOutlet UILabel *schoolLabel;
@property (weak, nonatomic) IBOutlet UILabel *joinLabel;

@end
@implementation BBQAttentionClassCell

-(void)setCurBaobao:(BBQAttentionClassWithBaby *)curBaobao{
    _curBaobao = curBaobao;
    self.classLabel.text = curBaobao.classmodel.classname;
    self.schoolLabel.text = curBaobao.schoolname;
    self.joinLabel.text = [NSString stringWithFormat:@"%@已加入",curBaobao.showname];
    if ([curBaobao.schoolavartar hasPrefix:@"http://"]) {
        [self.iconView setImageWithURL:[NSURL URLWithString:curBaobao.schoolavartar] placeholder:Placeholder_avatar];
    }
}

@end
