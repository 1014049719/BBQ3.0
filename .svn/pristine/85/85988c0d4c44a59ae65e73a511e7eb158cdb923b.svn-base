//
//  clearCacheTableViewController.m
//  BBQ
//
//  Created by wth on 15/7/23.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "clearCacheTableViewController.h"

@interface clearCacheTableViewController () <UITableViewDelegate,
                                             UIAlertViewDelegate>
@property(weak, nonatomic) IBOutlet UILabel *AllCacheLabel;

@property(weak, nonatomic) IBOutlet UILabel *clearCacheNum;
@property(weak, nonatomic) IBOutlet UIImageView *clearImage;
@end

@implementation clearCacheTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.tableView.tableFooterView = [UIView new];

  self.AllCacheLabel.text = [self getCacheSize];
  self.clearCacheNum.text = [self getCacheSize];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
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
    float folderSize =0.0;
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

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  switch (indexPath.row) {
  case 1: {
    [self createAlertView];
  } break;

  default:
    break;
  }
}

- (void)createAlertView {
  UIAlertView *alertView =
      [[UIAlertView alloc] initWithTitle:@"确定清除缓存？"
                                 message:nil
                                delegate:self
                       cancelButtonTitle:@"取消"
                       otherButtonTitles:@"确定", nil];
  [alertView show];
}

- (void)alertView:(UIAlertView *)alertView
    clickedButtonAtIndex:(NSInteger)buttonIndex {
  switch (buttonIndex) {
  case 1: {
    [self clearCache];
    NSString *str = @"清除成功";
    [SVProgressHUD showSuccessWithStatus:@"清除成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                 (int64_t)(HUD_DURATION(str) * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
                     [self.navigationController popViewControllerAnimated:YES];
                   });
  } break;

  default:
    break;
  }
}

-(void)clearCache{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                         NSUserDomainMask, YES) firstObject];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
}
//- (void)clearCache {
//  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
//                                                       NSUserDomainMask, YES);
//  NSString *documentsDirectory = [paths objectAtIndex:0];
//  NSString *tempDirectory = NSTemporaryDirectory();
//
//  NSFileManager *fileManager = [NSFileManager defaultManager];
//
//  [fileManager removeItemAtPath:documentsDirectory error:nil];
//  [fileManager removeItemAtPath:tempDirectory error:nil];
//}

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
