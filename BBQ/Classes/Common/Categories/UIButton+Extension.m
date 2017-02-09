//
//  UIButton+Extension.m
//  BBQ
//
//  Created by anymuse on 15/12/15.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)
- (void)buttonDispNetorLocalImg:(NSString *)avatarUrl {
    if ([avatarUrl hasPrefix:@"http://"] || [avatarUrl isEqualToString:@""])
        [self setBackgroundImageWithURL:[NSURL URLWithString:avatarUrl]
                                  forState:UIControlStateNormal
                               placeholder:[UIImage imageNamed:@"set_head_image_button@2x"]
                                   options:YYWebImageOptionSetImageWithFadeAnimation
                                completion:nil];
    else
        [self setBackgroundImage:[UIImage imageWithContentsOfFile:avatarUrl]
                           forState:UIControlStateNormal];
}
@end
