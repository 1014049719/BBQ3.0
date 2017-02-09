//
//  BBQChooseWordViewController.m
//  BBQ
//
//  Created by 朱琨 on 15/10/20.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQChooseWordViewController.h"
#import "BBQDailyReportWordCell.h"

@interface BBQChooseWordViewController () <UITableViewDataSource,
                                           UITableViewDelegate>

@end

@implementation BBQChooseWordViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
}

#pragma mark - Table View DataSource
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  BBQDailyReportWordCell *cell =
      [tableView dequeueReusableCellWithIdentifier:@"WordCell"
                                      forIndexPath:indexPath];
  cell.wordLabel.text = self.dataSource[indexPath.row];
  return cell;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  BBQDailyReportWordCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  cell.backgroundColor = [UIColor colorWithHexString:@"ff6440"];
  cell.wordLabel.textColor = [UIColor whiteColor];
}

- (void)tableView:(UITableView *)tableView
    didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
  BBQDailyReportWordCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  cell.backgroundColor = [UIColor whiteColor];
  cell.wordLabel.textColor = [UIColor colorWithHexString:@"333333"];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
