//
//  UIImageView+Extension.m
//  BBQ
//
//  Created by anymuse on 15/12/15.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "UIImageView+Extension.h"

@implementation UIImageView (Extension)
- (void)DispNetorLocalImg:(NSString *)avatarUrl{
    if ([avatarUrl hasPrefix:@"http://"] || [avatarUrl isEqualToString:@""]) {
        [self setImageWithURL:[NSURL URLWithString:avatarUrl]
                     placeholder:Placeholder_avatar
                         options:YYWebImageOptionSetImageWithFadeAnimation
                      completion:nil];
    } else {
        self.image = [UIImage imageWithContentsOfFile:avatarUrl];
    }
}

@end
