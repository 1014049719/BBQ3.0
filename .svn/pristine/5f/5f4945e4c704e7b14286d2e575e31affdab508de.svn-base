//
//  BBQInviteViewController.m
//  BBQ
//
//  Created by anymuse on 15/11/25.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQInviteViewController.h"
#import "BBQBabyDataCreateViewController.h"
#import "BBQInviteViewCell.h"
#import "BBQSchoolDataModel.h"
#import "BBQClassDataModel.h"
#import "AppDelegate.h"
#import "BBQBabyModifyViewController.h"

@interface BBQInviteViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIView *coverView;
@property (weak, nonatomic) IBOutlet UILabel *classLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic) BBQSchoolDataModel *schoolmodel;
@property(strong, nonatomic) BBQClassDataModel *classmodel;
@property(strong, nonatomic) BBQBabyModel *baobao;
@property(copy, nonatomic) NSString *classname;
@property (weak, nonatomic) IBOutlet UILabel *hudLabel;
@property(copy, nonatomic) NSString *classuid;
@end

@implementation BBQInviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _coverView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    _tableView.rowHeight = 70;
    
}

- (IBAction)verifyButtonDidClick:(id)sender {
    if (self.codeTextField.text.length != 6) {
        [SVProgressHUD showErrorWithStatus:@"请输入6位邀请码"];
    } else {
        [self verifyRequestCode:self.codeTextField.text];
    }
}
- (void)showAlertWithName:(NSString *)name {
    NSString *message =
    [NSString stringWithFormat:@"您已经成功添加了宝宝\"%@"
     @"\"，现在可以看到宝宝的最新变化了。",
     name];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark - 验证邀请码
- (void)verifyRequestCode:(NSString *)requestcode {
    [self.view endEditing:YES];
    [SVProgressHUD showWithStatus:@"请稍候..."];
    NSDictionary *params = @{ @"yqm" : requestcode };
    [BBQHTTPRequest
     queryWithType:BBQHTTPRequestTypeYQM
     param:params
     successHandler:^(AFHTTPRequestOperation *operation,
                      NSDictionary *responseObject, bool apiSuccess) {
         NSLog(@"%@",responseObject);
         [SVProgressHUD dismiss];
         NSNumber *status = responseObject[@"data"][@"status"];
         if ([status isEqualToNumber:@0]) {
             NSDictionary *dict = responseObject[@"data"][@"baobaodata"][0];
             BBQBabyModel *babymodel = [BBQBabyModel modelWithDictionary:dict];
             self.baobao = babymodel;
            [TheCurUser addABaby:self.baobao];
             TheCurBaoBao = self.baobao;
             //发送通知 刷新关注列表
             [[NSNotificationCenter defaultCenter]
              postNotificationName:@"baobaoDataChange"
              object:nil];
             
             [[NSNotificationCenter defaultCenter]
              postNotificationName:kSetNeedsRefreshEntireDataNotification
              object:nil
              userInfo:@{
                         @"type" : @(BBQRefreshNotificationTypeAll)
                         }];
             [self jumpToModifyViewController];
             
         }else if ([status isEqual:@3]){
             [UIView animateWithDuration:0.5 animations:^{
                 self.hudLabel.text = @"您已关注该宝宝";
                 self.hudLabel.alpha = 1.0;
             }completion:^(BOOL finished){
                 [UIView animateWithDuration:2.0 animations:^{
                     self.hudLabel.alpha = 0.0;
                 }];
             }];
         }else{
             self.schoolmodel = [[NSArray modelArrayWithClass:[BBQSchoolDataModel class] json:responseObject[@"data"][@"schooldata"]] firstObject];
             self.classmodel = [self.schoolmodel.classdata firstObject];
             self.classname = self.classmodel.classname;
             self.classuid = self.classmodel.classid.stringValue;
             if (self.crebabies.count == 0) {
                 [self createNewBaoBao];
             }else{
                 self.classLabel.text = [NSString stringWithFormat:@"请选择需要加入%@的宝宝",self.classname];
                 [UIView animateWithDuration:0.5 animations:^{
                     self.coverView.alpha = 1.0;
                 }];
             }
         }
     } errorHandler:^(NSDictionary *responseObject) {
         [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
     }
     failureHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
         [SVProgressHUD showErrorWithStatus:@"验证失败"];
     }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.crebabies.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BBQInviteViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:@"inviteViewCell"];
    if (self.crebabies.count) {
        cell.curBaobao = self.crebabies[indexPath.row];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BBQBabyModel *model = self.crebabies[indexPath.row];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"baobaouid"] = model.uid;
    params[@"classuid"]=self.classuid;
    [BBQHTTPRequest
     queryWithType:BBQHTTPRequestTypeIntoClass
     param:params
     successHandler:^(AFHTTPRequestOperation *operation,
                      NSDictionary *responseObject, bool apiSuccess) {
         NSLog(@"%@",responseObject);
         
         [UIView animateWithDuration:0.5 animations:^{
             self.coverView.alpha = 0.0;
         }];
         [UIView animateWithDuration:0.5 animations:^{
             self.hudLabel.text = @"已经向老师发出申请,等待老师审核中";
             self.hudLabel.alpha = 1.0;
         }completion:^(BOOL finished){
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 self.hudLabel.alpha = 0.0;
                 if (self.type == BBQInviteViewTypeLogin) {
                     if (((UITabBarController*)([UIApplication sharedApplication].keyWindow.rootViewController)).selectedIndex !=0) {
                         ((UITabBarController*)([UIApplication sharedApplication].keyWindow.rootViewController)).selectedIndex =0;
                     }
                     [self.navigationController popToRootViewControllerAnimated:YES];
                 }else{
                     [((AppDelegate *)[UIApplication sharedApplication].delegate)
                      setupTabBarController];
                 }
             });
         }];
     } errorHandler:^(NSDictionary *responseObject) {
         [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
     }
     failureHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
         [SVProgressHUD showErrorWithStatus:@"网络繁忙"];
     }];
    
}
- (IBAction)createBB {
    [self createNewBaoBao];
}
-(void)createNewBaoBao{
    BBQBabyDataCreateViewController *vc =
    [self.storyboard instantiateViewControllerWithIdentifier:@"babyDataCreateVC"];
    vc.selectedSchool = self.schoolmodel;
    vc.selectedClass = self.classmodel;
    vc.type = (self.type ==BBQInviteViewTypeLogin)?BBQBabyDataCreateTypeLogin:BBQBabyDataCreateTypeNormal;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)jumpToModifyViewController{
    UIStoryboard *storyBoard =
    [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
    BBQBabyModifyViewController *vc = [storyBoard
                                       instantiateViewControllerWithIdentifier:@"babyModifyVC"];
    vc.type = (self.type ==BBQInviteViewTypeLogin)?BBQBabyModifyTypeLogin:BBQBabyModifyTypeNormal;
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
