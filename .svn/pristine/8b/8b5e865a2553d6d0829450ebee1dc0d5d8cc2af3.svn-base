//
//  SetLimitViewController.m
//  BBQ
//
//  Created by wth on 15/7/28.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "SetLimitViewController.h"
#import "setLimitTableViewController.h"

@interface SetLimitViewController ()

@end

@implementation SetLimitViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

//保存
- (IBAction)clickSaveBtn:(id)sender {

  NSLog(@"gx:%@ %@ qx:%@", self.relativeModel.gxid, self.relativeModel.gxName,
        self.relativeModel.qx);
  [self updateFriendsInfo];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  // Get the new view controller using [segue destinationViewController].
  // Pass the selected object to the new view controller.

  //    if ([segue.identifier isEqualToString:@"jumpToSetLimitTable"]) {
  //        setLimitTableViewController *sltvc =
  //        segue.destinationViewController;
  //        sltvc.relativeModel = self.relativeModel;
  //    }
}

///支付结果更新
- (void)updateFriendsInfo {
  [SVProgressHUD showWithStatus:@"正在处理中。。。"];

  // 1.请求网址
  NSString *URL =
      [CS_URL_BASE stringByAppendingString:URL_UPDATE_RELATION_INFO];
  /**
   * 2.请求参数
   * baobaouid : 宝宝id
   */

  NSDictionary *params = @{
    @"baobaouid" : TheCurBaoBao.uid,
    @"uid" : self.relativeModel.uid,
    @"gxid" : self.relativeModel.gxid,
    @"gxname" : self.relativeModel.gxName,
    @"nickname" : self.relativeModel.nickName,
    @"qx" : self.relativeModel.qx
  };

  NSLog(@"URL:%@", URL);
  NSLog(@"params:%@", [params description]);

  // 3.网络请求
  [HttpTool postWithPath:URL
      params:params
      success:^(id JSON) {
        dispatch_async(dispatch_get_main_queue(), ^{
          [SVProgressHUD dismiss];
        });
        NSDictionary *dic = JSON;

        NSLog(@"res:%@", [dic description]);

        // 返回状态
        NSNumber *res = [dic objectForKeyedSubscript:@"res"];
        // res为1表示请求成功
        if ([res intValue] == 1) {
          //            NSArray *tempAry = [dic objectForKey:@"data"];
          //            for (NSDictionary *tempDic in tempAry) {
          //                [self.dataAry addObject:tempDic];
          //            }
          NSLog(@"post return success");

          dispatch_async(dispatch_get_main_queue(), ^{

            [SVProgressHUD showErrorWithStatus:@"保存成功"];
            if (self.block) {
              self.block(self.relativeModel);
            }
            [self.navigationController popViewControllerAnimated:YES];
          });

        }
        // 请求失败
        else {
          dispatch_async(dispatch_get_main_queue(), ^{
            // 返回的message
            NSString *message = [NSString
                stringWithFormat:@"%@", [dic objectForKeyedSubscript:@"msg"]];

            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            [alert show];
          });
        }
        // 更新headerView上的信息
        dispatch_async(dispatch_get_main_queue(), ^{
                           //[self updateHeaderView];
                       });

      }
      failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
          [SVProgressHUD dismiss];
          UIAlertView *alert =
              [[UIAlertView alloc] initWithTitle:@"提示"
                                         message:[error localizedDescription]
                                        delegate:nil
                               cancelButtonTitle:@"确定"
                               otherButtonTitles:nil, nil];
          [alert show];
        });
      }];
}

@end
