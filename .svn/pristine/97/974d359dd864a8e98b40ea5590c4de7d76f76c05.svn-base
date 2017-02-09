//
//  BBQTextView.m
//  BBQ
//
//  Created by anymuse on 15/12/31.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQTextView.h"
@interface BBQTextView()
/** placeHolder是否显示 */
@property (nonatomic, assign) BOOL placeHolderHiden;
@end;

@implementation BBQTextView

-(void)awakeFromNib{
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bordWillShow) name:UITextViewTextDidBeginEditingNotification object:self];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]  removeObserver:self];
}
-(void)bordWillShow{
    if (self.beginEditingBlock != nil) {
        self.beginEditingBlock();
    }
}
/**
 * 监听文字改变
 */
- (void)textDidChange
{
    if (self.text.length>self.maxLength) {
        self.text =[self.text substringToIndex:self.maxLength];
    }
    if (self.returnLengthBlock != nil) {
        self.returnLengthBlock(self.text.length);
    }
    // 重绘（重新调用）
    [self setNeedsDisplay];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    // setNeedsDisplay会在下一个消息循环时刻，调用drawRect:
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    // 如果有输入文字，就直接返回，不画占位文字
    if (self.hasText) return;
    
    // 文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor?self.placeholderColor:[UIColor grayColor];
    // 画文字
    //    [self.placeholder drawAtPoint:CGPointMake(5, 8) withAttributes:attrs];
    CGFloat x = 5;
    CGFloat w = rect.size.width - 2 * x;
    CGFloat y = 8;
    CGFloat h = rect.size.height - 2 * y;
    CGRect placeholderRect = CGRectMake(x, y, w, h);
    [self.placeholder drawInRect:placeholderRect withAttributes:attrs];
}
@end
