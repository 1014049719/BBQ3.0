//
//  BBQBabyPickerViewController.m
//  BBQ
//
//  Created by slovelys on 15/11/30.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQBabyPickerViewController.h"
#import "BBQBabyPickerCell.h"

@interface BBQBabyPickerViewController ()

@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation BBQBabyPickerViewController

- (instancetype)initWithSource:(NSArray *)array {
    if (self = [super init]) {
        _dataSource = [NSMutableArray arrayWithArray:array];
    }
    return self;
}

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 66, kScreen_Width, kScreenHeight - 66)];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 66, kScreen_Width, kScreen_Height - 66) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.view = tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BBQBabyPickerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BBQBabyPicker" owner:self options:nil] firstObject];
    }
    BBQBabyModel *model = _dataSource[indexPath.row];
    cell.leftLabel.text = model.realname;
    cell.leftLabel.textColor = [UIColor blackColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    BBQBabyPickerCell *cell = (BBQBabyPickerCell *)[tableView cellForRowAtIndexPath:indexPath];
//    cell.backgroundColor = [UIColor colorWithHexString:@"ff6440"];
    if (self.block) {
        self.block(_dataSource[indexPath.row]);
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    BBQBabyPickerCell *cell = (BBQBabyPickerCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
