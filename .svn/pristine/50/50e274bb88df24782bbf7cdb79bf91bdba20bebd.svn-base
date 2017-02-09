//
//  BBQThemeManager.m
//  BBQ
//
//  Created by slovelys on 15/12/24.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQThemeManager.h"

@interface BBQThemeManager ()

@property (copy, readwrite, nonatomic) NSString *colorStr;

@end

@implementation BBQThemeManager

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (NSString *)getTheCurThemeType {
    // 默认ff6440
    if (!TheCurUser.themeType) {
        return @"ff6440";
    }
    BBQThemeType type = TheCurUser.themeType;
    NSString *colocHexStr;
    switch (type) {
        case BBQThemeTypeDefault: {
            colocHexStr = @"ff6440";
        }
            break;
            
        case BBQThemeTypeLego: {
            colocHexStr = @"fed500";
        }
            break;
        case BBQThemeTypeXiaoP: {
            colocHexStr = @"2890c2";
        }
            break;
            
        default:
            break;
    }
    return colocHexStr;
}

- (void)switchTheme:(BBQThemeType)type {
    switch (type) {
        case BBQThemeTypeDefault: {
            self.colorStr = @"ff6440";
        } break;
        case BBQThemeTypeLego: {
            self.colorStr = @"fed500";
        } break;
        case BBQThemeTypeXiaoP: {
            self.colorStr = @"2890c2";
        } break;
        default:
            break;
    }
}

@end
