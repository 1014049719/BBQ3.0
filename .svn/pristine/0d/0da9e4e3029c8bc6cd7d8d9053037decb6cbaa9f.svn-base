//
//  BBQTextView.h
//  BBQ
//
//  Created by anymuse on 15/12/31.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 回调Block 返回菜单MenuButton的Frame
 */
typedef void (^ReturnLengthBlock)(NSInteger len);
typedef void (^BeginEditingBlock)();
@interface BBQTextView : UITextView
/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字的颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;
/** 限制字数 */
@property (nonatomic, assign) NSInteger maxLength;
/**
 回调Block
 */
@property (nonatomic, copy) ReturnLengthBlock returnLengthBlock;
@property (nonatomic, copy) BeginEditingBlock beginEditingBlock;
@end
