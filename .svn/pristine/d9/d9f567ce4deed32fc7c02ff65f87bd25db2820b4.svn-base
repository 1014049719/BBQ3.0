//
//  BBQSetClassViewController.m
//  BBQ
//
//  Created by anymuse on 15/11/24.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQSetClassViewController.h"
#import "BBQSchoolDataModel.h"
#import "BBQClassDataModel.h"

@interface BBQSetClassViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak) UITextField *textView;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *resultClasses;
@property (nonatomic, strong) BBQClassDataModel *selectedmodel;
@end

@implementation BBQSetClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTextView];
    [self setupFrame];
}

-(void)setSelectedSchool:(BBQSchoolDataModel *)selectedSchool{
    _selectedSchool = selectedSchool;
    self.resultClasses = selectedSchool.classdata;
    
}
-(void)setupFrame{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(sure)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    CGRect frame = CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height -104);
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame];
    tableView.tableFooterView =[UIView new];
    tableView.backgroundColor = UIColorHex(eeeeee);
    [self.view addSubview:tableView];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView =tableView;
    
}
-(void)sure{
    if (self.returnTextBlock != nil) {
        self.returnTextBlock(self.selectedmodel);
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
    textView.placeholder = @"请填写班级名称";
    [self.view addSubview:textView];
    self.textView = textView;
    
    // 文字改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextFieldTextDidChangeNotification object:textView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultClasses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"schoolCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor=[UIColor clearColor];
    }
    //取出模型
    BBQClassDataModel *model = [[BBQClassDataModel alloc] init];
    model= self.resultClasses[indexPath.row];
    //显示数据
    cell.textLabel.text = model.classname;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取出模型
    BBQClassDataModel *model = [[BBQClassDataModel alloc] init];
    model= self.resultClasses[indexPath.row];
    self.selectedmodel = model;
    //赋值
    self.textView.text = model.classname;
}

-(void)setSelectedmodel:(BBQClassDataModel *)selectedmodel{
    _selectedmodel = selectedmodel;
    self.navigationItem.rightBarButtonItem.enabled = YES;
}
/**
 * 监听文字改变
 */
- (void)textDidChange
{
    NSString *searchText = self.textView.text;
    if (searchText.length >0) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"classname contains %@ ", searchText];
        self.resultClasses = [self.selectedSchool.classdata filteredArrayUsingPredicate:predicate];
    }else{
        self.resultClasses = self.selectedSchool.classdata;
    }
    if (self.resultClasses.count <=1) {
        self.selectedmodel = [self.resultClasses firstObject];
    }
    [self.tableView reloadData];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)returnText:(ReturnClassModelBlock)block {
    self.returnTextBlock = block;
}

//当tableview 滚动的时候 结束编辑事件  （退出键盘）
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

@end
