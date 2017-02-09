//
//  GroupViewController.m
//  BBQ
//
//  Created by anymuse on 15/8/15.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "GroupViewController.h"
#import "GroupCell.h"
#import "GroupModel.h"
#import "SetLimitViewController.h"
#import "FriendDataShowViewController.h"
#import <DateTools.h>
#import "NSString+Common.h"

@interface GroupViewController () <UITableViewDataSource, UITableViewDelegate>
@property(weak, nonatomic) IBOutlet UITableView *tableView;
/// 数据源
@property(strong, nonatomic) NSMutableArray *dataAry;

@property(strong, nonatomic) RelativeModel *jumpModel;

@property(assign, nonatomic) int selectno;
//刷新页面计数值
@property(nonatomic, assign) int nRefreshPageCount;
//本页面是否是当前页面
@property(nonatomic, assign) BOOL isCurrentPage;
@end

@implementation GroupViewController

- (instancetype)init {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
    return self = [sb instantiateViewControllerWithIdentifier:@"GroupVC"];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [self initValues];
  [self downloadData];

  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(needToRefreshEntireData)
             name:kSetNeedsRefreshEntireDataNotification
           object:nil];
}

/// 初始化变量
- (void)initValues {
  self.tableView.tableFooterView = [[UIView alloc] init];

  if (self.dataAry == nil) {
    self.dataAry = [NSMutableArray arrayWithCapacity:0];
  }
}

#pragma mark - Life Cycle
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.isCurrentPage = YES;
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];

  self.isCurrentPage = NO;
}

- (void)needToRefreshEntireData {
  //是当前页面才刷新
  if (self.isCurrentPage) {
    self.needsRefreshEntireData = YES;
    [self downloadData];
  }
}

#pragma mark - Table view data source

- (UIView *)tableView:(UITableView *)tableView
    viewForFooterInSection:(NSInteger)section {
  UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
  return view;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return self.dataAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  GroupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupCell"
                                                    forIndexPath:indexPath];
  cell.selectionStyle = UITableViewCellSelectionStyleNone;

  RelativeModel *model = [self.dataAry objectAtIndex:indexPath.row];

  cell.countLabel.text =
      [NSString stringWithFormat:@"来过%@次", model.visit_count];

  if (model.visit_dateline > 0) {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:model.visit_dateline];
    cell.latestTime.text = [NSString
        stringWithFormat:@"最近访问：%@",
                         [date formattedDateWithFormat:@"MM-dd HH:mm"]];
    //        cell.latestTime.text = [NSString
    //        stringWithFormat:@"最近访问：%@",[CommonFunc
    //        getTimestring:model.visit_dateline]];
  } else {
    cell.latestTime.text = @"最近访问：";
  }

  if (self.tableView.dragging == NO && self.tableView.decelerating == NO) {
      [cell.userHeadView setImageWithURL:[NSURL URLWithString:model.avatar] placeholder:Placeholder_avatar options:YYWebImageOptionSetImageWithFadeAnimation | YYWebImageOptionRefreshImageCache completion:nil];
  }

  cell.vipLabel.text = [self vipLabelText:[model.qx intValue]];
  if ([model.qx intValue] == 3) {

    cell.vipLabel.hidden = YES;
  } else if ([model.qx intValue] == 2) {

    cell.vipLabel.backgroundColor =
        [UIColor colorWithRed:255 / 255.0 green:180 / 255.0 blue:0 alpha:1];
    cell.vipLabel.hidden = NO;
  } else {

    cell.vipLabel.backgroundColor = [UIColor colorWithHexString:@"ff6440"];
    cell.vipLabel.hidden = NO;
  }

  if ([model.gxid intValue] == 100) {
    cell.nickname.text = model.gxName;
  } else if ([model.gxid intValue] > 0) {
      cell.nickname.text = [NSString relationshipWithID:model.gxid.numberValue gxname:model.gxName];
  } else {
    if (model.nickName && model.nickName.length > 0)
      cell.nickname.text = model.nickName;
    else
      cell.nickname.text = model.userName;
  }

  return cell;
}

- (void)tableView:(nonnull UITableView *)tableView
    didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
  _jumpModel = [self.dataAry objectAtIndex:indexPath.row];
  self.selectno = (int)indexPath.row;
  [self performSegueWithIdentifier:@"jumpTofriendDataShowVcl"
                            sender:_jumpModel];
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
  RelativeModel *model = self.dataAry[indexPath.row];
    [((GroupCell *)cell)
     .userHeadView setImageWithURL:[NSURL URLWithString:model.avatar] placeholder:Placeholder_avatar options:YYWebImageOptionRefreshImageCache | YYWebImageOptionSetImageWithFadeAnimation completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

  //    if ([segue.identifier isEqualToString:@"jumpToSetLimit"]) {
  //        SetLimitViewController *slvc = segue.destinationViewController;
  //        slvc.relativeModel = [sender copy]; //拷贝，不修改原值先
  //        slvc.block = ^(RelativeModel *model) {
  //            [self.dataAry replaceObjectAtIndex:self.selectno
  //            withObject:model];
  //            [self downloadData];
  //        };

  //    }

  if ([segue.identifier isEqualToString:@"jumpTofriendDataShowVcl"]) {
    FriendDataShowViewController *fdvc = segue.destinationViewController;
    fdvc.model = sender;
  }
}

- (void)refreshEntireData {
  [self downloadData];
}

- (void)clearData {
  [self.dataAry removeAllObjects];
  [self.tableView reloadData];
}

#pragma mark -
#pragma mark 网络请求

/// 请求数据
- (void)downloadData {
  NSString *strUID;
  if (self.guid && self.guid.length > 0) {
    strUID = self.guid;
  } else {
    strUID = [TheCurBaoBao.uid stringValue];
  }
  /**
   * 2.请求参数
   * baobaouid : 宝宝id
   */
  NSDictionary *params = @{ @"baobaouid" : strUID };

  [BBQHTTPRequest queryWithType:BBQHTTPRequestTypeGetRelativeList
      param:params
      successHandler:^(AFHTTPRequestOperation *operation,
                       NSDictionary *responseObject, bool apiSuccess) {
        self.needsRefreshEntireData = NO;
        [self.dataAry removeAllObjects];
        NSDictionary *dict = responseObject[@"data"];
        NSArray *arr = dict[@"qyarr"];
        for (NSDictionary *tempDic in arr) {
          RelativeModel *model = [[RelativeModel alloc] initWithDic:tempDic];
          [self.dataAry addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
          [self.tableView reloadData];
        });
      }
      errorHandler:^(NSDictionary *responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
          [self.tableView reloadData];
        });
      }
      failureHandler:nil];
}

/// 权限处理
- (NSString *)vipLabelText:(int)qx {
  NSString *string = @"";
  switch (qx) {
  case 1: {
    string = @"圈主";
  } break;
  case 2: {
    string = @"管理员";
  } break;
  case 3: {
    string = @"";
  } break;
  default:
    break;
  }
  return string;
}
@end
