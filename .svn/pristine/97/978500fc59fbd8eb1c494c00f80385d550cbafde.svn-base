//
//  BBQDynamicHelper.m
//  BBQ
//
//  Created by 朱琨 on 15/11/24.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQDynamicHelper.h"

@implementation BBQDynamicHelper

+ (YYMemoryCache *)imageCache {
    static YYMemoryCache *cache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [YYMemoryCache new];
        cache.shouldRemoveAllObjectsOnMemoryWarning = NO;
        cache.shouldRemoveAllObjectsWhenEnteringBackground = NO;
        cache.name = @"DynamicImageCache";
    });
    return cache;
}

+ (UIImage *)imageNamed:(NSString *)name {
    if (!name) return nil;
    UIImage *image = [[self imageCache] objectForKey:name];
    if (image) return image;
    NSString *ext = name.pathExtension;
    if (ext.length == 0) ext = @"png";

    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:ext];
    image = [UIImage imageWithContentsOfFile:path];
    image = [image imageByDecoded];
    if (!image) return nil;
    [[self imageCache] setObject:image forKey:name];
    return image;
}

+ (YYWebImageManager *)avatarImageManager {
    static YYWebImageManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = [[UIApplication sharedApplication].cachesPath stringByAppendingPathComponent:@"dynamic.avatar"];
        YYImageCache *cache = [[YYImageCache alloc] initWithPath:path];
        manager = [[YYWebImageManager alloc] initWithCache:cache queue:[YYWebImageManager sharedManager].queue];
        manager.sharedTransformBlock = ^(UIImage *image, NSURL *url) {
            if (!image) return image;
            if (image.size.width != image.size.height) {
                CGFloat width = MIN(image.size.width, image.size.height);
                image = [image imageByResizeToSize:CGSizeMake(width, width) contentMode:UIViewContentModeCenter];
            }
            return [image imageByRoundCornerRadius:100 borderWidth:1 borderColor:[UIColor whiteColor]]; // a large value
        };
    });
    return manager;
}

@end
