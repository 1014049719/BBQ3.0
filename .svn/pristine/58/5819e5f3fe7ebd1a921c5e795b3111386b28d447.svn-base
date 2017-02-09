//
//  BBQOperationEditViewController.m
//  BBQ
//
//  Created by anymuse on 15/12/31.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQOperationEditViewController.h"
#import "BBQTextView.h"
#import "BBQOperationModel.h"
#import "BBQOpeationViewController.h"
@interface BBQOperationEditViewController ()
@property (weak, nonatomic) IBOutlet BBQTextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *maxLabel;
@property (strong, nonatomic) BBQOperationModel *operationModel;

@end

@implementation BBQOperationEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.placeholder= @"  写给未来宝宝的……";
    self.textView.placeholderColor = [UIColor grayColor];
    self.operationModel = [[BBQOperationModel alloc] init];
    self.operationModel.preface = @"";
    self.textView.maxLength = 200;
    self.textView.returnLengthBlock=^(NSInteger len){
        self.maxLabel.text = [NSString stringWithFormat:@"%lu/%d",(unsigned long)len,200];
    };
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStyleDone target:self action:@selector(next)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    [self GetFutureRequest];
}
-(void)GetFutureRequest{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"baobaouid"] =TheCurBaoBao.uid;
    [SVProgressHUD showWithStatus:@"请稍候"];
    [BBQHTTPRequest
     queryWithType:BBQHTTPRequestTypeGetFuture
     param:param
     successHandler:^(AFHTTPRequestOperation *operation,
                      NSDictionary *responseObject, bool apiSuccess) {
         [SVProgressHUD dismiss];
         self.operationModel = [BBQOperationModel modelWithDictionary:responseObject[@"data"][@"arr"]];
         if (self.operationModel.preface.length >0) {
             self.textView.text = self.operationModel.preface;
             self.maxLabel.text = [NSString stringWithFormat:@"%lu/%d",(unsigned long)self.operationModel.preface.length,200];
         }
         NSLog(@"%@",responseObject);

     } errorHandler:^(NSDictionary *responseObject) {
         [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
         
     }
     failureHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@",error);
         [SVProgressHUD dismiss];
     }];
}
- (void)next {
    if (!self.textView.text.length) {
        [SVProgressHUD showErrorWithStatus:@"至少写点什么吧"];
        return;
    }
    BBQOpeationViewController *operationVC = [[BBQOpeationViewController alloc]init];
    operationVC.title = @"编辑";
    self.operationModel.preface = self.textView.text;
    operationVC.operationModel = self.operationModel;
    operationVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:operationVC animated:YES];
    // Dispose of any resources that can be recreated.
}
@end
