//
//  BaobaoListTableViewController.m
//  BBQ
//
//  Created by wth on 15/8/10.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "BaobaoListTableViewController.h"
#import "BaoBaoListCell.h"
#import "BBQCalendarViewController.h"
#import "Common.h"
#import "BBQBabyMaterialViewController.h"
#import "BBQCalendarViewController.h"

@interface BaobaoListTableViewController ()

@property(strong, nonatomic) NSMutableArray *dataAry;

@end

@implementation BaobaoListTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.tableView.tableFooterView = [[UIView alloc] init];
  [self initValues];
  [self getBaoBaoListData];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)initValues {
  if (self.dataAry == nil) {
    self.dataAry = [NSMutableArray arrayWithCapacity:0];
  }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return self.dataAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  BaoBaoListCell *cell =
      [tableView dequeueReusableCellWithIdentifier:@"baobaoListCell"
                                      forIndexPath:indexPath];

  BBQBabyModel *baobao = self.dataAry[indexPath.row];

    [cell.headView setImageWithURL:[NSURL URLWithString:baobao.avartar] placeholder:Placeholder_avatar];
  cell.nameLabel.text = baobao.realname;
    if (baobao.birthyear.intValue ==0) {
        cell.ageLabel.text = @"0岁";
    }else
      cell.ageLabel.text = [CommonFunc getAgeWithYear:baobao.birthyear.intValue
                                            month:baobao.birthmonth.intValue
                                              day:baobao.birthday.intValue];

  return cell;
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BBQBabyModel *baobao = self.dataAry[indexPath.row];
  if (self.needJumpToCalendarVC == YES) {
      BBQCalendarViewController *vc = [[BBQCalendarViewController alloc] initWithBaby:self.dataAry[indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
  } else {
    UIStoryboard *sb =
        [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
    BBQBabyMaterialViewController *vc =
        [sb instantiateViewControllerWithIdentifier:@"babyMaterialVC"];
    vc.baby = baobao;
    [self.navigationController pushViewController:vc animated:YES];
  }
}

#pragma mark - 网络请求

- (void)getBaoBaoListData {
  [self.dataAry addObjectsFromArray:TheCurUser.baobaodata];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"BabyListToCalendar"]) {
  }
}

@end
