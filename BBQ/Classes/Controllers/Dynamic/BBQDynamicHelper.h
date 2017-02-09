//
//  BBQDynamicHelper.h
//  BBQ
//
//  Created by 朱琨 on 15/11/24.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBQDynamicHelper : NSObject

/// 动态图片 cache
+ (YYMemoryCache *)imageCache;

/// 获取图片 (有缓存)
+ (UIImage *)imageNamed:(NSString *)name;

/// 圆角头像的 manager
+ (YYWebImageManager *)avatarImageManager;

@end
