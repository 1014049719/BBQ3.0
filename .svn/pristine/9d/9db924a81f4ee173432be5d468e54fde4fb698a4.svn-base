//
//  aboutTableViewController.m
//  BBQ
//
//  Created by wth on 15/7/24.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "aboutTableViewController.h"
#import <StoreKit/StoreKit.h>
#import "NetConstDefine.h"

@interface aboutTableViewController ()

// APP版本号
@property(weak, nonatomic) IBOutlet UILabel *AppVersionLabel;

@end

@implementation aboutTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.tableView.tableFooterView = [UIView new];

  //获取app版本
  self.AppVersionLabel.text =
      [NSString stringWithFormat:@"当前版本 %@", [[UIApplication sharedApplication] appVersion]];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView
//numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView
cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView
dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#>
forIndexPath:indexPath];

    // Configure the cell...

    return cell;
}
*/

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

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

      [tableView deselectRowAtIndexPath:indexPath animated:YES];
  //
  //    if ( indexPath.row == 0) {
  ////        [self evaluate];
  //    }
  //    else if (indexPath.row == 1 ){

  // NSString *evaluateString = [NSString
  // stringWithFormat:@"imts-apps://itunes.apple.com/us/app/id%@", APPLE_ID];
  //[[UIApplication sharedApplication] openURL:[NSURL
  //URLWithString:evaluateString]];

  //        NSLog(@"%@", TheGlobal.sUpdataSoftUrl);
  //        if (TheGlobal.sUpdataSoftUrl ) {
  //            [[UIApplication sharedApplication] openURL:[NSURL
  //            URLWithString:TheGlobal.sUpdataSoftUrl]];
  //        }
  //        else {
  //            NSString *evaluateString = [NSString
  //            stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/jie-zou-da-shi/id%@?mt=8",APPLE_ID];
  //            [[UIApplication sharedApplication] openURL:[NSURL
  //            URLWithString:evaluateString]];
  //
  //        }
  //    }
}

- (void)evaluate {
  // NSString *evaluateString = [NSString
  // stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",APPLE_ID];
  //[[UIApplication sharedApplication] openURL:[NSURL
  //URLWithString:evaluateString]];

  NSString *evaluateString = [NSString
      stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/"
                       @"wa/"
                       @"viewContentsUserReviews?type=Purple+Software&id=%@",
                       APPLE_ID];
  [[UIApplication sharedApplication]
      openURL:[NSURL URLWithString:evaluateString]];

  /*
  //初始化控制器
  SKStoreProductViewController *storeProductViewContorller =
  [[SKStoreProductViewController alloc] init];
  //设置代理请求为当前控制器本身
  storeProductViewContorller.delegate = self;
  //加载一个新的视图展示
  [storeProductViewContorller loadProductWithParameters:
   //appId唯一的
   @{SKStoreProductParameterITunesItemIdentifier : APPLE_ID}
  completionBlock:^(BOOL result, NSError *error) {
       //block回调
       if(error){
           NSLog(@"error %@ with userInfo %@",error,[error userInfo]);
       }else{
           //模态弹出appstore
           [self presentViewController:storeProductViewContorller animated:YES
  completion:^{

           }
            ];
       }
   }];
  */
}

/*
//取消按钮监听
- (void)productViewControllerDidFinish:(SKStoreProductViewController
*)viewController{
    [self dismissViewControllerAnimated:YES completion:^{

    }];
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
