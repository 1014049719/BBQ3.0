//
//  BBQLeaveListTabbleViewController.m
//  BBQ
//
//  Created by slovelys on 15/11/30.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQLeaveListTabbleViewController.h"
#import "BBQLeaveListCell.h"
#import "BBQCreateLeaveViewController.h"
#import "BBQLeaveListFamilyApi.h"
#import "BBQLeaveListTeacherApi.h"
#import "BBQLeaveModel.h"
#import "BBQLeaveDetailViewController.h"
#import <DateTools.h>
#import <IMYThemeConfig.h>
#import "BBQSelectButton.h"
#import <KxMenu.h>
#import "KxMenuItem+BBQSchoolClassItme.h"

@interface BBQLeaveListTabbleViewController () <BBQTableViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) BBQSelectButton *selectBtn;
@property (copy, nonatomic) NSNumber *classid;

@end

@implementation BBQLeaveListTabbleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout=UIRectEdgeNone;
    _classid = TheCurUser.curClass.classid;
    self.statefulDelegate = self;
    _dataSource = [NSMutableArray arrayWithCapacity:0];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"BBQLeaveListCell" bundle:nil] forCellReuseIdentifier:@"leaveListCell"];
#ifdef TARGET_PARENT
    self.title = @"请假列表";
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"leave_add"] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
#elif TARGET_TEACHER
    self.title = @"请假管理";
#else
    _selectBtn = [BBQSelectButton buttonWithType:UIButtonTypeCustom];
    [_selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _selectBtn.frame = CGRectMake(80, 20, kScreen_Width - 160, 40);
    [_selectBtn setTitle:TheCurUser.curClass.classname forState:UIControlStateNormal];
    [_selectBtn setImage:[UIImage imageNamed:@"daosanjiao"] forState:UIControlStateNormal];
    [_selectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.navigationController.view.superview addSubview:_selectBtn];
#endif
    [self triggerInitialLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _selectBtn.hidden = NO;
    _selectBtn.userInteractionEnabled =  YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _selectBtn.hidden = YES;
    _selectBtn.userInteractionEnabled =  NO;
}

- (void)onInit {
    [super onInit];
    self.canLoadMore = NO;
}

- (void)dealloc {
    [_selectBtn removeFromSuperview];
    _selectBtn = nil;
}

- (void)selectBtnClick:(UIButton *)btn {
    NSMutableArray *nameAry = [NSMutableArray arrayWithCapacity:0];
    for (BBQClassDataModel *class in TheCurUser.classdata) {
        KxMenuItem *item = [KxMenuItem menuItem:class.classname image:nil target:self action:@selector(kxmenuItemClick:)];
        item.schoolclassname = class.classname;
        item.classid = [class.classid stringValue];
        [nameAry addObject:item];
    }
    [KxMenu showMenuInView:self.navigationController.view fromRect:btn.frame menuItems:nameAry];
}

- (void)kxmenuItemClick:(KxMenuItem *)item {
    [_selectBtn setTitle:item.title forState:UIControlStateNormal];
    _classid = [NSNumber numberWithString:item.classid];
    [self triggerInitialLoad];
//    [self tableViewControllerWillBeginInitialLoad:self completion:nil];
    [KxMenu dismissMenu];
} 

- (void)rightItemClick {
    BBQCreateLeaveViewController *vc = [[UIStoryboard storyboardWithName:@"Family" bundle:nil] instantiateViewControllerWithIdentifier:@"createLeaveVC"];
    WS(weakSelf)
    vc.block = ^(void) {
        [CommonFunc showAlertView:@"发表成功"];
        [weakSelf triggerInitialLoad];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
    //    [self changeTheme];
}

#pragma mark - BBQTableViewControllerDelegate
- (void)tableViewControllerWillBeginInitialLoad:(BBQTableViewController *)tvc completion:(void (^)(BOOL, BOOL))completion {
#ifdef TARGET_PARENT
    BBQLeaveListFamilyApi *api = [[BBQLeaveListFamilyApi alloc] initWithDic:_params];
#else
    NSDictionary *dic = @{
                          @"classuid" : _classid
                          };
    BBQLeaveListFamilyApi *api = [[BBQLeaveListFamilyApi alloc] initWithDic:dic];
#endif
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [_dataSource removeAllObjects];
            NSArray *leaveAry = [NSArray modelArrayWithClass:[BBQLeaveModel class] json:request.responseJSONObject[@"data"][@"arr"]];
            dispatch_async_on_main_queue(^{
                [_dataSource addObjectsFromArray:leaveAry];
                [self.tableView reloadData];
                completion(_dataSource.count == 0, NO);
            });
        });
    } failure:^(YTKBaseRequest *request) {
        completion(self.dataSource.count == 0, request.requestOperation.error ? YES : NO);
    }];
}

- (void)tableViewControllerWillBeginLoadingFromPullToRefresh:(BBQTableViewController *)tvc completion:(void (^)(BOOL, BOOL))completion {
#ifdef TARGET_PARENT
    BBQLeaveListFamilyApi *api = [[BBQLeaveListFamilyApi alloc] initWithDic:_params];
#else
    BBQLeaveListFamilyApi *api = [[BBQLeaveListFamilyApi alloc] initWithDic:@{ @"classuid" : TheCurUser.curClass.classid }];
#endif
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [_dataSource removeAllObjects];
            NSArray *leaveAry = [NSArray modelArrayWithClass:[BBQLeaveModel class] json:request.responseJSONObject[@"data"][@"arr"]];
            [_dataSource addObjectsFromArray:leaveAry];
            dispatch_async_on_main_queue(^{
                [self.tableView reloadData];
                completion(_dataSource.count == 0, NO);
            });
        });
    } failure:^(YTKBaseRequest *request) {
        completion(self.dataSource.count == 0, request.requestOperation.error ? YES : NO);
    }];
}

//- (void)tableViewControllerWillBeginLoadingMore:(BBQTableViewController *)tvc completion:(void (^)(BOOL, NSError *, BOOL))completion {
//    BBQLeaveListFamilyApi *api = [[BBQLeaveListFamilyApi alloc] init];
//    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            NSArray *leaveAry = [NSArray modelArrayWithClass:[BBQLeaveModel class] json:request.responseJSONObject[@"data"][@"arr"]];
//            [_dataSource addObjectsFromArray:leaveAry];
//            dispatch_async_on_main_queue(^{
//                [self.tableView reloadData];
//                completion(YES, nil, NO);
//            });
//        });
//    } failure:^(YTKBaseRequest *request) {
//        completion(YES, request.requestOperation.error, YES);
//    }];
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BBQLeaveListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leaveListCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BBQLeaveListCell" owner:self options:nil] firstObject];
    }
    
    BBQLeaveModel *model = _dataSource[indexPath.row];
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:[model.dateline doubleValue]];
    NSString *time = [date formattedDateWithFormat:@"yyyy-MM-dd"];
    
    cell.nameLabel.text = model.baobaoname;
    cell.timeLabel.text = time;
    [cell.nameLabel imy_setTextColorForKey:IMY_RED];
#ifdef TARGET_TEACHER
    if (model.is_modify == 0) {
        cell.readStatusLabel.text = @"未读";
        cell.readStatusLabel.textColor = [UIColor redColor];
    } else {
        cell.readStatusLabel.text = @"已读";
        cell.readStatusLabel.textColor = [UIColor lightGrayColor];
    }
#else
    if (model.is_modify == 0) {
        cell.readStatusLabel.text = @"老师未读";
        cell.readStatusLabel.textColor = [UIColor redColor];
    } else {
        cell.readStatusLabel.text = @"老师已读";
        cell.readStatusLabel.textColor = [UIColor lightGrayColor];
    }
#endif
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BBQLeaveModel *model = _dataSource[indexPath.row];
    BBQLeaveDetailViewController *vc = [[UIStoryboard storyboardWithName:@"Family" bundle:nil] instantiateViewControllerWithIdentifier:@"leaveDetailVC"];
    vc.sid = [model.jid intValue];
    WS(weakSelf)
    vc.block = ^(BOOL isDelete) {
        if (isDelete == YES) {
            [CommonFunc showAlertView:@"删除成功"];
        }
        [weakSelf triggerInitialLoad];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
