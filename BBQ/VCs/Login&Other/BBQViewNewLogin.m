//
//  BBQViewNewLogin.m
//  BBQ
//
//  Created by slovelys on 15/11/13.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQViewNewLogin.h"
#import <Masonry.h>
#import "LoginViewController.h"

@implementation BBQViewNewLogin

- (void)awakeFromNib {
    _phoneLoginBtn.layer.cornerRadius = 25;
    _WXLoginBtn.layer.cornerRadius = 25;
    _QQLoginBtn.layer.cornerRadius = 25;
}
- (IBAction)phoneLoginBtnEvent:(id)sender {
    
    if (_block) {
        _block(0);
    }
    
}
- (IBAction)WXLoginBtnEvent:(id)sender {
}
- (IBAction)QQLoginBtnEvent:(id)sender {
}
- (IBAction)forgetPswBtnEvent:(id)sender {
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
