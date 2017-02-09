//
//  SelectFriendsViewController.m
//  BBQ
//
//  Created by wth on 15/7/28.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "SelectFriendsViewController.h"
#import "RelativeModel.h"
#import "SelectFriendsTableViewController.h"
#import "MyDataCenter.h"
#import <IAPHelper.h>
#import <IAPShare.h>

@interface SelectFriendsViewController ()
@property(weak, nonatomic) IBOutlet UIView *messageView;
@property(weak, nonatomic) IBOutlet NSLayoutConstraint *TopLayout;

// tableviewController
@property(strong, nonatomic) SelectFriendsTableViewController *friendsTabVcl;

//选择对亲友数
@property(weak, nonatomic) IBOutlet UILabel *lbFriendsNum;
//总金额
@property(weak, nonatomic) IBOutlet UILabel *lbTotalMoney;

//支付按钮
@property(weak, nonatomic) IBOutlet UIButton *btnPay;

/// 数据源
@property(strong, nonatomic) NSMutableArray *dataAry;

@property(strong, nonatomic) RelativeModel *jumpModel;

//选择的亲友
@property(strong, nonatomic) NSArray *dataSelect;

@property(copy, nonatomic) NSString *orderid;

@property(assign, nonatomic) int result;

@property(copy, nonatomic) NSString *reason;

@end

@implementation SelectFriendsViewController {
    
    //通知传值
    int Money_chuanzhi;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataAry = [NSMutableArray array];
    
    self.lbFriendsNum.text = @"0";
    self.lbTotalMoney.text = @"0.0元";
    self.btnPay.enabled = NO;
    
    [self downloadData];
    
    //单例接收值money
    NSString *str = [MyDataCenter defaultCenter].infor;
    Money_chuanzhi = [str intValue];
    NSLog(@"chuanguolaidezhi.......%@", str);
}

//关闭提示框
- (IBAction)CloseBtnClick:(id)sender {
    
    _messageView.hidden = YES;
    _TopLayout.constant = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickPayBtn:(id)sender {
    if (!self.dataSelect || self.dataSelect.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"请先选择亲友"];
        return;
    }
    
    NSMutableArray *arr = [NSMutableArray array];
    for (NSIndexPath *no in self.dataSelect) {
        NSInteger jj = no.row;
        RelativeModel *model = [self.dataAry objectAtIndex:jj];
        [arr addObject:model.uid];
    }
    
    NSDictionary *params = @{
                             @"revnum" : @(self.dataSelect.count),
                             @"revuiddata" : arr,
                             @"total" : _price,
                             @"Int" : @(self.ledouNum)
                             };
    [BBQHTTPRequest queryWithType:BBQHTTPRequestTypeAddiOSLeDouOrder
                            param:params
                   successHandler:^(AFHTTPRequestOperation *operation,
                                    NSDictionary *responseObject, bool apiSuccess) {
                       dispatch_async(dispatch_get_main_queue(), ^{
                           //进入苹果支付
                           NSDictionary *dicData = [responseObject objectForKey:@"data"];
                           self.orderid = pickJsonStrValue(dicData, @"orderid");
                           [self getIAPWithProductID:self.productID];
                       });
                   }
                     errorHandler:^(NSDictionary *responseObject) {
                         NSLog(@"%@", responseObject);
                     }
                   failureHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
                       NSLog(@" ===== %@", [error localizedDescription]);
                   }];
    
    //
    //    self.payblock(arr);
}

//苹果支付
- (void)getIAPWithProductID:(NSString *)productID {
    
    [SVProgressHUD showWithStatus:@"请稍候..."];
    if (![IAPShare sharedHelper].iap) {
        
        NSSet *dataSet = [[NSSet alloc]
                          initWithObjects:@"bbq.Family.LeDou18", @"bbq.Family.LeDou78",
                          @"bbq.Family.LeDou45", @"bbq.Family.LeDou153", nil];
        
        [IAPShare sharedHelper].iap =
        [[IAPHelper alloc] initWithProductIdentifiers:dataSet];
    }
    // 测试服 = NO
    [IAPShare sharedHelper].iap.production = NO;
    
    [[IAPShare sharedHelper]
     .iap requestProductsWithCompletion:^(SKProductsRequest *request,
                                          SKProductsResponse *response) {
         if (response > 0) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 [SVProgressHUD dismiss];
             });
             __block SKProduct *product = nil;
             [[IAPShare sharedHelper]
              .iap.products
              enumerateObjectsUsingBlock:^(SKProduct *abc, NSUInteger idx,
                                           BOOL *stop) {
                  NSLog(@"%@", abc.productIdentifier);
                  if ([abc.productIdentifier isEqualToString:productID]) {
                      product = abc;
                      *stop = YES;
                  }
              }];
             
//             [[IAPShare sharedHelper]
//              .iap
//              buyProduct:product
//              withQuantity:self.dataSelect.count
//              onCompletion:^(SKPaymentTransaction *trans) {
//                  if (trans.error) {
//                      NSLog(@"Fail %@", [trans.error localizedDescription]);
//                      _reason = [trans.error localizedDescription];
//                      _result = 4; //支付失败
//                      [self updateOrderWithDic:@{}];
//                      [CommonFunc showAlertView:@"支付取消或支付失败"];
//                  } else if (trans.transactionState ==
//                             SKPaymentTransactionStatePurchased) {
//                      
//                      [[IAPShare sharedHelper]
//                       .iap
//                       checkReceipt:trans.transactionReceipt
//                       AndSharedSecret:@"your sharesecret"
//                       onCompletion:^(NSString *response, NSError *error) {
//                           
//                           // Convert JSON String to NSDictionary
//                           NSDictionary *rec = [IAPShare toJSON:response];
//                           
//                           if ([rec[@"status"] integerValue] == 0) {
//                               
//                               _result = 1; //成功
//                               _reason = @"";
//                               [self updateOrderWithDic:rec];
//                               NSString *productIdentifier =
//                               trans.payment.productIdentifier;
//                               [[IAPShare sharedHelper]
//                                .iap provideContent:productIdentifier];
//                               NSLog(@"SUCCESS %@", response);
//                               NSLog(@"Pruchases %@",
//                                     [IAPShare sharedHelper].iap.purchasedProducts);
//                               dispatch_async(dispatch_get_main_queue(), ^{
//                                   [self.navigationController
//                                    popViewControllerAnimated:YES];
//                                   
//                                   //发送更新结果通知
//                                   //                                 [[NSNotificationCenter
//                                   //                                 defaultCenter]
//                                   //                                 postNotificationName:NOTIFICATION_Update_BuyResult
//                                   //                                 object:nil
//                                   //                                 userInfo:dic];
//                                   [[NSNotificationCenter defaultCenter]
//                                    postNotificationName:
//                                    kSetNeedsRefreshEntireDataNotification
//                                    object:nil
//                                    userInfo:@{
//                                               @"type" : @(
//                                                   BBQRefreshNotificationTypeUserInfo)
//                                               }];
//                               });
//                               
//                           } else {
//                               NSLog(@"Fail");
//                           }
//                       }];
//                  } else if (trans.transactionState ==
//                             SKPaymentTransactionStateFailed) {
//                      NSLog(@"Fail");
//                  }
//              }]; // end of buy product
         }
         
     }];
}

- (void)updateOrderWithDic:(NSDictionary *)dic {
    NSDictionary *params = @{
                             @"orderid" : self.orderid,
                             @"result" : @(_result),
                             @"receipt" : dic,
                             @"reason" : _reason
                             };
    [BBQHTTPRequest queryWithType:BBQHTTPRequestTypeiOSUpdateOrder
                            param:params
                   successHandler:^(AFHTTPRequestOperation *operation,
                                    NSDictionary *responseObject, bool apiSuccess) {
                       
                       NSLog(@"=-》%@", responseObject);
                       
                   }
                     errorHandler:^(NSDictionary *responseObject) {
                         NSLog(@"=-》%@", responseObject);
                     }
                   failureHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
                       NSLog(@"error = %@", error.localizedDescription);
                   }];
}

- (void)dispData {
    [self.friendsTabVcl reloadData:self.dataAry];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
// preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"SelectFriendsSegue"]) {
        
        self.friendsTabVcl = segue.destinationViewController;
        WS(weakSelf)
        self.friendsTabVcl.block = ^(NSArray *arr) {
            weakSelf.dataSelect = arr;
            
            //            float money = weakSelf.block(arr.count);
            
            int money_total = Money_chuanzhi * arr.count;
            
            weakSelf.lbFriendsNum.text =
            [NSString stringWithFormat:@"%lu", (unsigned long)[arr count]];
            weakSelf.lbTotalMoney.text =
            [NSString stringWithFormat:@"%.2d元", money_total];
            
            if (arr.count > 0)
                weakSelf.btnPay.enabled = YES;
            else
                weakSelf.btnPay.enabled = NO;
        };
    }
}

#pragma mark -
#pragma mark 网络请求

/// 请求数据
- (void)downloadData {
    [SVProgressHUD showWithStatus:@"正在加载中"];
    // 1.请求网址
    NSString *URL = [CS_URL_BASE stringByAppendingString:URL_GET_RELATIVE_LIST];
    
    BBQBabyModel *baobao = TheCurBaoBao;
    /**
     * 2.请求参数
     * baobaouid : 宝宝id
     */
    NSDictionary *params = @{ @"baobaouid" : baobao.uid };
    // 3.网络请求
    [HttpTool postWithPath:URL
                    params:params
                   success:^(id JSON) {
                       
                       dispatch_async(
                                      dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                          NSDictionary *dic = JSON;
                                          
                                          NSLog(@"dic:%@", [dic description]);
                                          
                                          NSNumber *res = [dic objectForKey:@"res"];
                                          // res = 1 表示请求成功并返回数据正确
                                          if ([res intValue] == 1) {
                                              NSDictionary *dict = [dic objectForKey:@"data"];
                                              NSArray *arr = dict[@"qyarr"];
                                              for (NSDictionary *tempDic in arr) {
                                                  RelativeModel *model =
                                                  [[RelativeModel alloc] initWithDic:tempDic];
                                                  [self.dataAry addObject:model];
                                              }
                                          }
                                          // 请求成功但返回错误信息
                                          else {
                                              NSString *message =
                                              [NSString stringWithFormat:@"%@", dic[@"msg"]];
                                              [CommonFunc showAlertView:message];
                                          }
                                          
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              [SVProgressHUD dismiss];
                                              [self dispData];
                                          });
                                          
                                      });
                   }
                   failure:^(NSError *error) {
                       dispatch_async(dispatch_get_main_queue(), ^{
                           [SVProgressHUD dismiss];
                           [CommonFunc showAlertView:[error localizedDescription]];
                       });
                   }];
}

@end
