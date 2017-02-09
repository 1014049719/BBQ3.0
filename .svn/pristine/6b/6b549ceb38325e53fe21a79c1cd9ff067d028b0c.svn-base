//
//  UIViewController+BBQBaseViewController.m
//  BBQ
//
//  Created by slovelys on 15/12/28.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "UIViewController+BBQBaseViewController.h"
#import <objc/runtime.h>
#import "AppDelegate.h"

@implementation UIViewController (BBQBaseViewController)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        swizzleMethod(class, @selector(viewDidAppear:), @selector(bbq_viewDidAppear:));
        swizzleMethod(class, @selector(viewDidDisappear:), @selector(bbq_viewDidDisappear:));
    });
}

void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector)   {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)bbq_viewDidAppear:(BOOL)animated {
    [self bbq_viewDidAppear:animated];
#ifndef DEBUG
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [MTA trackPageViewBegin:NSStringFromClass([self class])];
    });
#endif
}

- (void)bbq_viewDidDisappear:(BOOL)animated {
    [self bbq_viewDidDisappear:animated];
#ifndef DEBUG
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [MTA trackPageViewEnd:NSStringFromClass([self class])];
    });
#endif
}

@end
