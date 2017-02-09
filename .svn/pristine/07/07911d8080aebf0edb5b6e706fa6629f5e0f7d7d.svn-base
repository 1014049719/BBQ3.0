//
//  BBQNewTaskViewController.m
//  BBQ
//
//  Created by anymuse on 15/12/23.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQNewTaskViewController.h"
#import "AuthorizationHelper.h"
#import "QBImagePickerController.h"
#import "BBQNewTaskTableViewCell.h"
#import "SendInvitationViewController.h"
#import "BBQTaskResult.h"

@interface BBQNewTaskViewController ()<UITableViewDataSource,UITableViewDelegate,BBQNewTaskTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BBQNewTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 180;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (!TheCurUser.taskArr) {
        [self getTaskStatus];
    }
    
}
/**
 获取新手任务
 */
-(void)getTaskStatus{
    [SVProgressHUD showWithStatus:@"请稍候"];
    [BBQHTTPRequest
     queryWithType:BBQHTTPRequestTypeGetTaskStatus
     param:nil
     successHandler:^(AFHTTPRequestOperation *operation,
                      NSDictionary *responseObject, bool apiSuccess) {
         [SVProgressHUD dismiss];
         NSLog(@"%@",responseObject);
         BBQTaskResult *result = [BBQTaskResult modelWithDictionary:responseObject[@"data"]];
         TheCurUser.taskArr = result.taskarr;
         [self.tableView reloadData];
         
     } errorHandler:^(NSDictionary *responseObject) {
         [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
         
     }
     failureHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@",error);
         [SVProgressHUD showErrorWithStatus:@"网络繁忙"];
     }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return TheCurUser.taskArr.count -1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BBQNewTaskTableViewCell *cell = [BBQNewTaskTableViewCell cellWithTableView:tableView];
    cell.delegate = self;
    cell.taskno = indexPath.row+1;
    return cell;
    
}

-(void)newTaskTableViewCell:(BBQNewTaskTableViewCell *)cell taskno:(NSInteger)taskno{
    if (taskno == 1) {
        if (![AuthorizationHelper checkPhotoLibraryAuthorizationStatus]) {
            return;
        }
        Dynamic *dynamic = [Dynamic dynamicWithMediaType:BBQDynamicMediaTypePhoto object:TheCurBaoBao];
        [self createNewDynamic:dynamic];
    }else if (taskno==2){
        if (![AuthorizationHelper checkPhotoLibraryAuthorizationStatus]) {
            return;
        }
        Dynamic *dynamic = [Dynamic dynamicWithMediaType:BBQDynamicMediaTypeVideo object:TheCurBaoBao];
        [self createNewDynamic:dynamic];
        
    }else{
        SendInvitationViewController *vc = [[UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil]
                                        instantiateViewControllerWithIdentifier:@"sendInvitationVC"];
        vc.guideTaskCallBack= ^(){
            if (TheCurUser.taskArr.count > 3) {
                [TheCurUser updataTaskModel:3];
            }
            [self.tableView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)createNewDynamic:(Dynamic *)dynamic {
        QBImagePickerController *imagePicker = [[QBImagePickerController alloc] initWithDynamic:dynamic];
        [self.navigationController
         pushViewController:imagePicker
         animated:YES];
}
@end
