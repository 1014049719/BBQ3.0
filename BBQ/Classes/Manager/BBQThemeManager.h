//
//  BBQThemeManager.h
//  BBQ
//
//  Created by slovelys on 15/12/24.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BBQThemeType) {
    BBQThemeTypeDefault = 1,
    BBQThemeTypeLego,
    BBQThemeTypeXiaoP
};

@interface BBQThemeManager : NSObject

@property (copy, readonly, nonatomic) NSString *colorStr;
@property (assign, nonatomic) BBQThemeType themeType;

+ (instancetype)sharedInstance;
- (void)switchTheme:(BBQThemeType)type;
- (NSString *)getTheCurThemeType;

@end
