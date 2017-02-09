//
//  SelectFriendsTableViewController.m
//  BBQ
//
//  Created by wth on 15/7/28.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "SelectFriendsTableViewController.h"
#import "FriendsCell.h"
#include "RelativeModel.h"
#import "NSString+Common.h"

@interface SelectFriendsTableViewController ()

@property(strong, nonatomic) NSArray *data;

@end

@implementation SelectFriendsTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.tableView.delegate = self;
  self.tableView.dataSource = self;

  // Uncomment the following line to preserve selection between presentations.
  // self.clearsSelectionOnViewWillAppear = NO;

  // Uncomment the following line to display an Edit button in the navigation
  // bar for this view controller.
  // self.navigationItem.rightBarButtonItem = self.editButtonItem;

  self.tableView.tableFooterView = [UIView new];

  //设置多选
  self.tableView.allowsMultipleSelection = YES;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)reloadData:(NSArray *)data {
  self.data = data;
  [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  //#warning Potentially incomplete method implementation.
  // Return the number of sections.
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  //#warning Incomplete method implementation.
  // Return the number of rows in the section.

  if (!self.data) {
    NSLog(@"numberOfRowsInSection num 0");

    return 0;
  }

  NSLog(@"numberOfRowsInSection num:%lu", (unsigned long)self.data.count);

  return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  FriendsCell *cell =
      [tableView dequeueReusableCellWithIdentifier:@"FriendsCell"
                                      forIndexPath:indexPath];

  // Configure the cell...
  RelativeModel *model = [self.data objectAtIndex:indexPath.row];

    [cell.ivAvatar setImageWithURL:[NSURL URLWithString:model.avatar] placeholder:Placeholder_avatar options:YYWebImageOptionSetImageWithFadeAnimation | YYWebImageOptionRefreshImageCache completion:nil];
  NSString *info;
  if ([model.gxid intValue] > 0) {
    info = [NSString
        stringWithFormat:@"%@%@", TheCurBaoBao.nickname,
                         [NSString relationshipWithID:model.gxid.numberValue gxname:model.gxName]];
  } else if (model.nickName.length > 0) {
    info = model.nickName;
  } else {
    info = model.userName;
  }
  cell.lbName.text = info;

  return cell;
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

  //传选中的cell
  self.block(tableView.indexPathsForSelectedRows);
}

- (void)tableView:(UITableView *)tableView
    didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {

  self.block(tableView.indexPathsForSelectedRows);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
