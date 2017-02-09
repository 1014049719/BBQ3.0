//
//  LeDouPayTableViewController.m
//  BBQ
//
//  Created by wth on 15/7/22.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "LeDouPayTableViewController.h"
#import "LeDouPayCell.h"
#import "MyDataCenter.h"

@interface LeDouPayTableViewController ()
//@property (strong, nonatomic) IBOutlet UITableView *LeDouTableview;
@property(strong, nonatomic) NSArray *schema_cztype;

@property(assign, nonatomic) int currentIndex;

@end

@implementation LeDouPayTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  // Uncomment the following line to preserve selection between presentations.
  //     self.clearsSelectionOnViewWillAppear = NO;

  // Uncomment the following line to display an Edit button in the navigation
  // bar for this view controller.
  // self.navigationItem.rightBarButtonItem = self.editButtonItem;

  NSLog(@"into LeDouPayTableViewController viewDidLoad");

  _currentIndex = 10;

  //    去多余分割线
  self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)reloadCzdata:(NSArray *)schema_cztype {
  self.schema_cztype = schema_cztype;
  [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  //#warning Potentially incomplete method implementation.
  //    // Return the number of sections.

  NSLog(@"numberOfSectionsInTableView  1");

  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  //#warning Incomplete method implementation.
  //    // Return the number of rows in the section.
  if (!self.schema_cztype) {
    NSLog(@"numberOfRowsInSection num 0");

    return 0;
  }

  NSLog(@"numberOfRowsInSection num:%lu",
        (unsigned long)self.schema_cztype.count);

  return self.schema_cztype.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  LeDouPayCell *cell = (LeDouPayCell *)
      [tableView dequeueReusableCellWithIdentifier:@"LeDouPayCell"
                                      forIndexPath:indexPath];

  // Configure the cell...
  //    NSDictionary *dic = [self.schema_cztype objectAtIndex:indexPath.row];

  NSArray *PriceArr = @[ @"18元", @"45元", @"78元", @"153元" ];
  cell.OriginalPriceLabel.text = PriceArr[indexPath.row];
  NSArray *LeDouArr = @[ @"120乐豆", @"300乐豆", @"520乐豆", @"1020乐豆" ];
  cell.lbLedou.text = LeDouArr[indexPath.row];

  //如果购买了成长书（打折）
  if (self.czsState_Value == 1) {

    NSArray *LeDou_zhekouArr = @[ @"60", @"155", @"268", @"525" ];
    cell.LeDou_zhekouLabel.hidden = NO;

    cell.LeDou_zhekouLabel.text = [NSString
        stringWithFormat:@" + %@乐豆", LeDou_zhekouArr[indexPath.row]];
  } else {

    cell.LeDou_zhekouLabel.hidden = YES;
  }

  return cell;
}

// cell点击
- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSArray *LeDouArr = @[ @"120乐豆", @"300乐豆", @"520乐豆", @"1020乐豆" ];
  NSArray *LeDou_zhekouArr = @[ @"60", @"155", @"268", @"525" ];
  int ledou = 0;
  if (self.czsState_Value == 1) {
    ledou = [LeDouArr[indexPath.row] intValue] +
            [LeDou_zhekouArr[indexPath.row] intValue];
  } else {
    ledou = [LeDouArr[indexPath.row] intValue];
  }
  //取出当前cell
  LeDouPayCell *cell =
      (LeDouPayCell *)[tableView cellForRowAtIndexPath:indexPath];
  cell.selectImageView.highlighted = YES;

  //传值
  if (self.block) {
    self.block([[NSNumber numberWithInteger:indexPath.row] intValue], ledou);
  }

  static NSString *moneyStr;
  switch (indexPath.row) {
  case 0:
    moneyStr = @"18";
    break;
  case 1:
    moneyStr = @"45";
    break;
  case 2:
    moneyStr = @"78";
    break;
  case 3:
    moneyStr = @"153";
    break;

  default:
    break;
  }
  NSLog(@"qianshu.....%@", moneyStr);
  //    NSDictionary *Dic=@{@"Money":money};
  //单例传金额

  [MyDataCenter defaultCenter].infor = moneyStr;
}

//- (void)tableView:(UITableView *)tableView
//didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    //取出当前cell
//    LeDouPayCell *cell = (LeDouPayCell *)[tableView
//    cellForRowAtIndexPath:indexPath];
//    cell.selectImageView.highlighted = NO;
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath
*)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath]
withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the
array, and add a new row to the table view
    }
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath
*)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath
*)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
