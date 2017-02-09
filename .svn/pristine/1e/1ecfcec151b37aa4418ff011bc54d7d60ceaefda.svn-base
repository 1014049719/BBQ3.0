//
//  BBQBackgroundView.m
//  BBQ
//
//  Created by 朱琨 on 15/8/4.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQBackgroundView.h"

@implementation BBQBackgroundView

//- (nullable UIView *)hitTest:(CGPoint)point withEvent:(nullable UIEvent
//*)event {
//    UIView *hitView = [super hitTest:point withEvent:event];
//    if (self == hitView) {
////        self.superview.
//        [self.superview endEditing:YES];
//        [[NSNotificationCenter defaultCenter]
//        postNotificationName:kWillGiveUpEditing object:nil userInfo:nil];
////        [self removeFromSuperview];
//        return nil;
//    }
//    return hitView;
//}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesBegan:touches withEvent:event];
  //    [self.superview endEditing:YES];
  [[NSNotificationCenter defaultCenter] postNotificationName:kWillGiveUpEditing
                                                      object:nil
                                                    userInfo:nil];
}

@end
