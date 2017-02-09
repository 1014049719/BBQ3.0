//
//  BBQSetNameViewController.m
//  BBQ
//
//  Created by wenjing on 15/11/24.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQSetNameViewController.h"

@interface BBQSetNameViewController ()<UITextFieldDelegate>
/** 输入控件 */
@property (nonatomic, weak) UITextField *textView;

@end

@implementation BBQSetNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorHex(eeeeee);
    // 添加输入控件
    [self setupTextView];
    //设置导航栏
    [self setupNav];
    
}

/**
 * 设置导航栏内容
 */
- (void)setupNav
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(sure)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}
-(void)sure{
    if (self.returnTextBlock != nil) {
        self.returnTextBlock(self.textView.text);
    }
    // POP
    [self.navigationController popViewControllerAnimated:YES];
    
}
/**
 * 添加输入控件
 */
- (void)setupTextView
{
    UITextField *textView = [[UITextField alloc] init];
    textView.backgroundColor=[UIColor whiteColor];
    CGFloat viewX = 0;
    CGFloat viewY = 0;
    CGFloat viewW = self.view.bounds.size.width;
    CGFloat viewH = 50;
    textView.frame = CGRectMake(viewX, viewY, viewW, viewH);
    textView.font = [UIFont systemFontOfSize:15];
    textView.textAlignment = NSTextAlignmentCenter;
    textView.delegate = self;
    textView.placeholder = @"请输入宝宝的姓名";
    [self.view addSubview:textView];
    if (self.nameStr) {
        textView.text = self.nameStr;
    }
    self.textView = textView;
    
    // 文字改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextFieldTextDidChangeNotification object:textView];
}

/**
 * 监听文字改变
 */
- (void)textDidChange
{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 成为第一响应者叫出相应的键盘）
    [self.textView becomeFirstResponder];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)returnText:(ReturnTextBlock)block {
    self.returnTextBlock = block;
}
@end
