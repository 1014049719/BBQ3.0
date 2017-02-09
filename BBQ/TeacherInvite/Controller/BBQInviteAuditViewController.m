//
//  BBQInviteAuditViewController.m
//  BBQ
//
//  Created by anymuse on 15/11/27.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQInviteAuditViewController.h"
#import "BBQInviteViewCell.h"
#import "BBQInviteAuditCell.h"
#import "BBQInviteModel.h"
#import "BBQInviteBaobaoData.h"
#import "MJRefresh.h"
#import "BBQBabyModel.h"
#import "BBQInviteMemberdata.h"
#import "BBQBabyMaterialViewController.h"

@interface BBQInviteAuditViewController ()<UITableViewDataSource,UITableViewDelegate,BBQInviteAuditCellDelegate>
@property (nonatomic, strong) NSMutableArray *baobaoDatas;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) BBQInviteModel *inviteModel;

@end

@implementation BBQInviteAuditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 70;
    _page = 1;
    [self setExtraCellLineHidden:self.tableView];
    [self setupUpRefresh];
    [self setupDownRefresh];
}
/**
 *  集成上拉加载控件
 */
- (void)setupUpRefresh
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreRequest)];
    // 禁止自动加载
    footer.automaticallyRefresh = NO;
    // 设置footer
    self.tableView.footer = footer;
    self.tableView.footer.hidden = YES;
}
/**
 *  集成下拉刷新控件
 */
- (void)setupDownRefresh
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRequest)];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.autoChangeAlpha = YES;
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    //开始刷新
    [header beginRefreshing];
    // 设置header
    self.tableView.header = header;
}

-(void)loadRequest{
    [self setupRequest:@"PullToRefresh"];
}
-(void)loadMoreRequest{
    [self setupRequest:@"InfiniteScrolling"];
}

-(void)setupRequest:(NSString *)refreshType{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    BBQClassDataModel *classModel = [TheCurUser.classdata firstObject];
    param[@"classid"] =classModel.classid;
    if ([refreshType isEqualToString:@"InfiniteScrolling"]){
        param[@"pageIndex"] = [NSNumber numberWithInteger:self.page];
    }
    switch (self.inviteType) {
        case BBQInviteTypeAudit:
            param[@"status"] =@0;
            break;
        case BBQInviteTypeAgree:
            param[@"status"] =@1;
            break;
        case BBQInviteTypeRefuse:
            param[@"status"] =@-1;
            break;
        default:
            break;
    }
    [BBQHTTPRequest
     queryWithType:BBQHTTPRequestTypeGetInviteList
     param:param
     successHandler:^(AFHTTPRequestOperation *operation,
                      NSDictionary *responseObject, bool apiSuccess) {
         NSLog(@"%@",responseObject);
         if ([refreshType isEqualToString:@"InfiniteScrolling"]) {
             [self.baobaoDatas addObjectsFromArray:[BBQInviteModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"List"]]];
             ++_page;
             [self.tableView.footer endRefreshing];
         }else{
           self.baobaoDatas = [BBQInviteModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"List"]];
           [self.tableView.header endRefreshing];
             if (self.baobaoDatas.count) {
                 self.tableView.footer.hidden = NO;
             }
             _page =2;
         }
         [self.tableView reloadData];
     } errorHandler:^(NSDictionary *responseObject) {
         NSLog(@"%@",responseObject);
         if ([refreshType isEqualToString:@"InfiniteScrolling"]) {
             [self.tableView.footer endRefreshing];
         }else{
             [self.tableView.header endRefreshing];
         }
     }
     failureHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@",error);
         if ([refreshType isEqualToString:@"InfiniteScrolling"]) {
             [self.tableView.footer endRefreshing];
         }else{
             [self.tableView.header endRefreshing];
         }
     }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.baobaoDatas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.inviteModel= self.baobaoDatas[indexPath.row];
    BBQInviteAuditCell *cell =
    [tableView dequeueReusableCellWithIdentifier:@"InviteAuditCell"];
    cell.delegate = self;
    cell.curBaobao = self.inviteModel;
    if ([self.inviteModel.invStatus isEqualToString:@"-1"]) {
        UILongPressGestureRecognizer * longPressGesture =         [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(cellLongPress:)];
        
        [cell addGestureRecognizer:longPressGesture];
    }
//    switch (self.inviteType) {
//        case BBQInviteTypeAudit:{//

//        }break;
//        case BBQInviteTypeAgree:{
//
//        }break;
//        case BBQInviteTypeRefuse:{
//        }break;
//    }
    return cell;
}

- (void)cellLongPress:(UIGestureRecognizer *)recognizer{
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        CGPoint location = [recognizer locationInView:self.tableView];
        
        NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:location];
        self.inviteModel= self.baobaoDatas[indexPath.row];
        [self showAlertWithName:self.inviteModel.baobaodata.username];
        
    }
}
- (void)showAlertWithName:(NSString *)name {
    NSString *titleStr =  [NSString stringWithFormat:@"确定要重新通过%@的班级申请么?",name];
    NSString *message =
    [NSString stringWithFormat:@"通过请点击确定,拒绝请点击取消"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:titleStr
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:@"取消", nil];
    [alert show];
}

- (void)alertView:(nonnull UIAlertView *)alertView
didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex ==0) {
        [self requestInviteAudit:self.inviteModel status:@"1"];;
    }
}
- (void)setExtraCellLineHidden: (UITableView *)tableView

{
    
    UIView *view =[ [UIView alloc]init];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
}
-(void)inviteAuditCell:(BBQInviteAuditCell *)cell DidClickButton:(BBQInviteModel *)inviteModel status:(NSString *)status{
    [self requestInviteAudit:inviteModel status:status];
    
}
-(void)requestInviteAudit:(BBQInviteModel *)inviteModel status:(NSString *)status{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"id"] = inviteModel.inviteid;
    param[@"status"] = status;
    [BBQHTTPRequest
     queryWithType:BBQHTTPRequestTypeInviteAudit
     param:param
     successHandler:^(AFHTTPRequestOperation *operation,
                      NSDictionary *responseObject, bool apiSuccess) {
          NSLog(@"%@",responseObject);
         [self.baobaoDatas removeObject:inviteModel];
         [self.tableView reloadData];
         if (status.integerValue ==1) {
             [self updateBaobaoData:inviteModel];
         }
         [SVProgressHUD showSuccessWithStatus:@"操作成功"];
     } errorHandler:^(NSDictionary *responseObject) {
         [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
     }
     failureHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@",error);
     }];
}
-(void)inviteAuditCell:(BBQInviteAuditCell *)cell tapIconView:(BBQInviteModel *)inviteMode{
    UIStoryboard *sb =
    [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
    BBQBabyMaterialViewController *vc =
    [sb instantiateViewControllerWithIdentifier:@"babyMaterialVC"];
    vc.inviteModel = inviteMode;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)updateBaobaoData:(BBQInviteModel*)inviteModel{
    BBQBabyModel *model = [[BBQBabyModel alloc] init];
    model.realname =  inviteModel.baobaodata.username;
    model.avartar = inviteModel.baobaodata.avartar;
    model.uid = [NSNumber numberWithString:inviteModel.baobaodata.uid];
    model.birthday = [NSNumber numberWithString:inviteModel.baobaodata.birthday];
    model.birthmonth = [NSNumber numberWithString:inviteModel.baobaodata.birthmonth];
    model.birthyear = [NSNumber numberWithString:inviteModel.baobaodata.birthyear];
    model.gender =  [NSNumber numberWithString:inviteModel.baobaodata.gender];
    model.gxrealname = inviteModel.memberdata.realname;
    model.gxname = inviteModel.memberdata.gxname;
    model.gxusername = inviteModel.memberdata.username;
    [TheCurUser addABaby:model];
}
@end
