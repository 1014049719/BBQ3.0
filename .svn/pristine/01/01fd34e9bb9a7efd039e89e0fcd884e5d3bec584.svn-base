//
//  UserDataShowViewController.m
//  BBQ
//
//  Created by wth on 15/7/22.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "UserDataShowViewController.h"
#import "OneFriendDataCell.h"
#import "TwoFriendDataCell.h"
#import "UserDataModel.h"
#import <UINavigationBar+Awesome.h>
#import "SchoolNameTableViewCell.h"
#import "TeClassTableViewCell.h"
#import "RelativeModel.h"
#import <UINavigationController+FDFullscreenPopGesture.h>
#import "NSString+Common.h"

@interface UserDataShowViewController ()<UITableViewDataSource,UITableViewDelegate, UINavigationBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *userDataTableview;

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
//自定义导航
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *dynamicNum;

@property (weak, nonatomic) IBOutlet UILabel *picturesNum;

@property (strong, nonatomic) UserDataModel *userdataModel;

@property (strong, nonatomic) RelativeModel *relativeModel;

@end

@implementation UserDataShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _userDataTableview.delegate=self;
    _userDataTableview.dataSource=self;
    
    self.userDataTableview.tableFooterView=[[UIView alloc] init];
    
    [self.navBar lt_setBackgroundColor:[UIColor clearColor]];
    self.navBar.translucent = YES;
    self.navBar.delegate = self;
    
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@""];
    item.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navBar pushNavigationItem:item animated:NO];
    [self.navBar pushNavigationItem:[[UINavigationItem alloc] initWithTitle:@""] animated:NO];
    
    
    //当前用户先显示
    if ( [self.uid isEqualToNumber:TheCurUser.member.uid]) {
        [self.headerImage setImageWithURL:[NSURL URLWithString:TheCurUser.member.avartar] placeholder:Placeholder_avatar];
    }
}

- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getUserData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //判断工程target
//#ifdef TARGET_MASTER
//    return 1;
//#elif TARGET_TEACHER
//    return 2;
//#else
//    
//#endif
    if (_userdataModel.groupkey.integerValue == 2) return 2;
    return 1;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_userdataModel.groupkey.integerValue == 2) {
        if (indexPath.row==0) {
            
            SchoolNameTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"schoolCell" forIndexPath:indexPath];
            cell.schoolNameLabel.text = _userdataModel.schoolname;
            return cell;
        }
        TeClassTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ClassName" forIndexPath:indexPath];
        cell.classNameLabel.text = _userdataModel.classname;
        return cell;
    } else if (_userdataModel.groupkey.integerValue == 3) {
        SchoolNameTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"schoolCell" forIndexPath:indexPath];
        cell.schoolNameLabel.text = _userdataModel.schoolname;
        return cell;
    } else {
        if (indexPath.row==0) {
            OneFriendDataCell *cell=[tableView dequeueReusableCellWithIdentifier:@"guanxiCell" forIndexPath:indexPath];
            
            if (_userdataModel) {
                if ([_userdataModel.groupkey intValue] == 2) {
                    cell.relationNameLabel.text = @"老师";
                } else if ([_userdataModel.groupkey intValue] == 3) {
                    cell.relationNameLabel.text = @"园长";
                } else {
                    NSString *string = [NSString relationshipWithID:_userdataModel.gxid.numberValue gxname:_relativeModel.gxName];
                    cell.relationNameLabel.text = string;
                }
            }
            return cell;
        }
        
        TwoFriendDataCell *cell=[tableView dequeueReusableCellWithIdentifier:@"qinzikaCell" forIndexPath:indexPath];
        
        if (_userdataModel) {
            if ([_userdataModel.isqzk intValue] == 1) {
                cell.qzkLabel.text = @"已购买";
            } else {
                cell.qzkLabel.text = @"未购买";
            }
        }
        return cell;
    }
}

//选择cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //点击后选中状态消失
    [_userDataTableview deselectRowAtIndexPath:indexPath animated:YES];
//    if (_userdataModel.groupkey.integerValue == 2) {
//        if (indexPath.row==1) {
//            
//            if (((UITabBarController*)([UIApplication sharedApplication].keyWindow.rootViewController)).selectedIndex !=0) {
//                ((UITabBarController*)([UIApplication sharedApplication].keyWindow.rootViewController)).selectedIndex =0;
//            }
//            [self.navigationController popToRootViewControllerAnimated:YES];
//            
//        }
//    } else if (_userdataModel.groupkey.integerValue == 1) {
//        if (indexPath.row==1) {
//            if (_userdataModel.groupkey.integerValue == 2) {
//                if (((UITabBarController*)([UIApplication sharedApplication].keyWindow.rootViewController)).selectedIndex !=0) {
//                    ((UITabBarController*)([UIApplication sharedApplication].keyWindow.rootViewController)).selectedIndex =0;
//                }
//                [self.navigationController popToRootViewControllerAnimated:YES];
//            }
//            else {
//                UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
//                UIViewController *CardWebVcl=[storyboard instantiateViewControllerWithIdentifier:@"CardWebVcl"];
//                CardWebVcl.title=@"成长书";
//                [self.navigationController pushViewController:CardWebVcl animated:YES];
//            }
            
            
//        }
//    }
}

#pragma mark - 查询个人信息网络请求

- (void)getUserData {
#ifdef TARGET_PARENT
    NSDictionary *params = @{ @"baobaouid" : TheCurBaoBao.uid,
                              @"uid" : self.uid };
    
    [BBQHTTPRequest queryWithType:BBQHTTPRequestTypeGetUserData param:params successHandler:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject, bool apiSuccess) {
        [SVProgressHUD dismiss];
        [SVProgressHUD dismiss];
        UserDataModel *model = [UserDataModel modelWithDictionary:responseObject[@"data"]];
        _userdataModel = model;
        
        [self.headerImage setImageWithURL:[NSURL URLWithString:model.fbztx] placeholder:Placeholder_avatar];
        self.nameLabel.text = model.realname;
        self.dynamicNum.text = model.bbq_fdt_num;
        self.picturesNum.text = model.bbq_pic_num;
        [_userDataTableview reloadData];
        
    } errorHandler:nil failureHandler:nil];
    
#else
    
    NSDictionary *params = @{ @"uid" : self.uid };
    [BBQHTTPRequest queryWithType:BBQHTTPRequestTypeGetUserData param:params successHandler:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject, bool apiSuccess) {
        [SVProgressHUD dismiss];
        UserDataModel *model = [UserDataModel modelWithDictionary:responseObject[@"data"]];
        _userdataModel = model;
        [self.headerImage setImageWithURL:[NSURL URLWithString:model.fbztx] placeholder:Placeholder_avatar];
        
        self.nameLabel.text = model.realname;
        self.dynamicNum.text = model.bbq_fdt_num;
        self.picturesNum.text = model.bbq_pic_num;
        dispatch_async_on_main_queue(^{
            [self.userDataTableview reloadData];
        });
        
    } errorHandler:nil failureHandler:nil];
    
#endif
    
}

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    [self.navigationController popViewControllerAnimated:YES];
    return YES;
}

@end
