//
//  CardPopTableViewController.m
//  BBQ
//
//  Created by wth on 15/8/20.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "CardPopTableViewController.h"
#import "CardPopTableViewCell.h"


@interface CardPopTableViewController ()

//标题数据源
@property(strong, nonatomic) NSMutableArray *DescMutableArrDataSource;

@end

@implementation CardPopTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  // Uncomment the following line to preserve selection between presentations.
  // self.clearsSelectionOnViewWillAppear = NO;

  // Uncomment the following line to display an Edit button in the navigation
  // bar for this view controller.
  // self.navigationItem.rightBarButtonItem = self.editButtonItem;

  self.DescMutableArrDataSource = [NSMutableArray array];
  self.tableView.tableFooterView = [UIView new];

  NSLog(@"。。。。悬浮窗数据源%@。。", self.DataSourceArr[1][@"ur"
                                                                         @"l"]);
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
  // Return the number of rows in the section.
  return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {

  CardPopTableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:@"CardPopCell"
                                      forIndexPath:indexPath];

  cell.CardtitleLabel.text = self.DataSourceArr[indexPath.row][@"title"];
  cell.cardDecsLabel.text = self.DataSourceArr[indexPath.row][@"desc"];
  [cell.cardImageView
      setImageWithURL:[NSURL URLWithString:self.DataSourceArr[indexPath.row][
                                                  @"url"]]
                 options:YYWebImageOptionSetImageWithFadeAnimation];

  return cell;
}

@end
