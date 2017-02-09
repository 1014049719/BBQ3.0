//
//  SetTableViewController.m
//  BBQ
//
//  Created by wth on 15/7/23.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "SetTableViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "ResetPassKeyTableViewController.h"
#import "BBQAccountInfoTableViewController.h"
#import "BBQLeaveListTabbleViewController.h"
#import "JJFMDB.h"
#import "aboutViewController.h"

@interface SetTableViewController () <UIAlertViewDelegate>

// WiFi开关
@property(weak, nonatomic) IBOutlet UISwitch *WifiSwitch;

@property(strong, nonatomic) NSDictionary *dataDic;
@property(weak, nonatomic) IBOutlet UILabel *cacheLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountInfoLabel;

//new
@property (weak, nonatomic) IBOutlet UILabel *huanfu_newLabel;
//缓存
@property(strong,nonatomic)NSUserDefaults *UserDefault;

@end

@implementation SetTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _UserDefault=[NSUserDefaults standardUserDefaults];
    if ([_UserDefault boolForKey:@"huanfu"]) {
        [self.huanfu_newLabel removeFromSuperview];
    }

    
    self.tableView.tableFooterView = [UIView new];
#ifdef TARGET_PARENT
    _accountInfoLabel.text = @"账号信息";
#endif
    self.WifiSwitch.on = TheCurUser.onlyViaWifi;
    [self.WifiSwitch addTarget:self
                        action:@selector(switchEvent:)
              forControlEvents:UIControlEventValueChanged];
}

- (void)switchEvent:(UISwitch *)sender {
    TheCurUser.onlyViaWifi = sender.on;
    [TheCurUser save];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.cacheLabel.text = [self getCacheSize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 2 && [_accountInfoLabel.text isEqualToString:@"账号信息"]) {
        BBQAccountInfoTableViewController *vc = [[UIStoryboard storyboardWithName:@"Family" bundle:nil] instantiateViewControllerWithIdentifier:@"accountInfoVC"];
        [self.navigationController pushViewController:vc animated:YES];
        
//        BBQLeaveListTabbleViewController *vc = [[UIStoryboard storyboardWithName:@"Family" bundle:nil] instantiateViewControllerWithIdentifier:@"leaveListVC"];
//        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 2 && [_accountInfoLabel.text isEqualToString:@"修改密码"]) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
        ResetPassKeyTableViewController *vc = [sb instantiateViewControllerWithIdentifier:@"ResetPassVcl"];
        vc.type = BBQResetPasswordTypeNormal;
        [self.navigationController pushViewController:vc animated:YES];
//        BBQLeaveListTabbleViewController *vc = [[UIStoryboard storyboardWithName:@"Family" bundle:nil] instantiateViewControllerWithIdentifier:@"leaveListVC"];
//        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 3) {
        //皮肤
        [_UserDefault setBool:YES forKey:@"huanfu"];
        [_huanfu_newLabel removeFromSuperview];
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Family" bundle:nil];
        aboutViewController *vc = [sb instantiateViewControllerWithIdentifier:@"setThemeVC"];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 4) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
        aboutViewController *vc = [sb instantiateViewControllerWithIdentifier:@"aboutVC"];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 5) {
        [self jumpToLoginVC];
    }
}

- (void)jumpToLoginVC {
    UIAlertView *alertView =
    [[UIAlertView alloc] initWithTitle:@"退出登录"
                               message:@"是否退出登录?"
                              delegate:self
                     cancelButtonTitle:@"取消"
                     otherButtonTitles:@"确定", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self exitLogin];
    }
}

- (void)exitLogin {
    [[BBQLoginManager sharedManager] logout];
}

- (NSString *)getCacheSize {
    NSString *cashDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                                   NSUserDomainMask, YES) firstObject];
    float cashSize =[self folderSizeAtPath:cashDirectory];
    if (cashSize > 1) {
        return [NSString
                stringWithFormat:@"%.0fM",
                cashSize];
    } else {
        return [NSString
                stringWithFormat:@"%.0fKB",cashSize *1000.0];
    }
}

- (float)folderSizeAtPath:(NSString *)filePath {
    NSFileManager *manager = [NSFileManager defaultManager];
    float folderSize = 0.0;
    if ([manager fileExistsAtPath:filePath]) {
        NSArray *childerFiles=[manager subpathsAtPath:filePath];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[filePath stringByAppendingPathComponent:fileName];
            folderSize +=[self fileSizeAtPath:absolutePath];
        }
        return folderSize;
    }
    return 0;
}
-(float)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1000.0/1000.0;
    }
    return 0;
}


@end
