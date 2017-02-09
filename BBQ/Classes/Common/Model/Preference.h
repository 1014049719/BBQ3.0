//
//  Preference.h
//  BBQ
//
//  Created by 朱琨 on 15/12/27.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBQThemeManager.h"

@interface Preference : NSObject

@property (assign, nonatomic) BBQLoginType authtype;
@property (assign, nonatomic) BBQThemeType themeType;
@property (assign, nonatomic) BOOL inviteHasFinished;
@property (assign, nonatomic) BOOL onlyViaWifi;
@property (assign, nonatomic) BOOL uploadPicHasFinished;
@property (assign, nonatomic) BOOL uploadVideoHasFinished;
@property (copy, nonatomic) NSArray *announcementTypes;

@end
