//
//  RootTabBar.m
//  JYEX
//
//  Created by anymuse on 15/7/16.
//  Copyright © 2015年 广州洋基. All rights reserved.
//

#import "RootTabBar.h"
#import <IMYThemeConfig.h>
#import <UIColor+IMY_Theme.h>

@interface RootTabBar () <IMY_ThemeChangeProtocol>

@end

@implementation RootTabBar

- (void)layoutSubviews {
    [super layoutSubviews];
    [self addToThemeChangeObserver];
    
    self.legoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -5, kScreen_Width, 5)];
    UIImage *img = [UIImage imy_imageForKey:@"t2.png"];
    self.legoImgView.image = [img resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeTile];
    [self addSubview:self.legoImgView];
    
    self.middleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.middleButton imy_setImageForKey:@"take_photo" andState:UIControlStateNormal];
    [self.middleButton imy_setImageForKey:@"close_middle" andState:UIControlStateSelected];
    self.middleButton.frame = CGRectMake(200, -10, 52, 52);
    self.middleButton.center = CGPointMake(
                                           CGRectGetMidX(self.frame), CGRectGetMidY(self.middleButton.frame));
    
    [self.middleButton addTarget:self
                          action:@selector(didClickMiddleButton)
                forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.middleButton];
}

- (void)imy_themeChanged {
    //    if ([[IMYThemeManager sharedIMYThemeManager].themePath hasSuffix:@"ThemeLego.bundle"]) {
    //        self.legoImgView.hidden = NO;
    //    } else {
    //        self.legoImgView.hidden = YES;
    //    }
    self.legoImgView.hidden = [[IMYThemeManager sharedIMYThemeManager].themePath hasSuffix:@"ThemeLego.bundle"] ? NO : YES;
}

- (void)didClickMiddleButton {
    self.middleButton.selected = !self.middleButton.selected;
    if (self.buttonBlock) {
        self.buttonBlock(self.middleButton);
    }
}
@end
