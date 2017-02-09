//
//  BBQCreateBBCell.m
//  BBQ
//
//  Created by anymuse on 16/1/12.
//  Copyright © 2016年 bbq. All rights reserved.
//

#import "BBQCreateBBCell.h"
@interface BBQCreateBBCell()
@property (weak, nonatomic) IBOutlet UIView *createview;
@property (weak, nonatomic) IBOutlet UIView *inviteview;

@end
@implementation BBQCreateBBCell

- (void)awakeFromNib {
    [self.createview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapcreateview)]];
    [self.inviteview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapinviteview)]];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
-(void)tapcreateview{
    if ([_delegate respondsToSelector:@selector(createBBCell:DidClickViewWithTag:)]){
        [_delegate createBBCell:self DidClickViewWithTag:100];
    }
}
-(void)tapinviteview{
    if ([_delegate respondsToSelector:@selector(createBBCell:DidClickViewWithTag:)]){
        [_delegate createBBCell:self DidClickViewWithTag:101];
    }
    
}
@end
