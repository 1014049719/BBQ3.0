//
//  FriendDataShowViewController.m
//  BBQ
//
//  Created by wth on 15/8/11.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "FriendDataShowViewController.h"
#import "setFriendTableViewController.h"
#import "OneFriendDataCell.h"
#import "TwoFriendDataCell.h"
#import "ThreeFriendDataCell.h"
#import <UINavigationBar+Awesome.h>
#import "NSString+Common.h"
#import <IMYThemeConfig.h>

@interface FriendDataShowViewController () <UITableViewDelegate,
UITableViewDataSource,UINavigationBarDelegate>

//导航
@property (strong, nonatomic) UINavigationBar *navBar;

@property(weak, nonatomic) IBOutlet UITableView *FriendDataShowTableview;
@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;

@property(weak, nonatomic) IBOutlet UIImageView *headerIamge;
@property(weak, nonatomic) IBOutlet UILabel *nameLabel;

@property(weak, nonatomic) IBOutlet UILabel *dynaNumLabel;
@property(weak, nonatomic) IBOutlet UILabel *photoNumLabel;

@property(copy, nonatomic) NSString *gxName;
@end

@implementation FriendDataShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航
    _navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    [_navBar lt_setBackgroundColor:[UIColor clearColor]];
    _navBar.translucent = YES;
    _navBar.delegate = self;
    UINavigationItem *backItem = [[UINavigationItem alloc] initWithTitle:@""];
    backItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    UINavigationItem *rightItem = [[UINavigationItem alloc] initWithTitle:@""];
    
    
    [_navBar pushNavigationItem:backItem animated:NO];
    [_navBar pushNavigationItem:rightItem animated:NO];
    [self.view addSubview:_navBar];

    self.view.backgroundColor = [UIColor whiteColor];
    self.FriendDataShowTableview.delegate = self;
    self.FriendDataShowTableview.dataSource = self;
    self.FriendDataShowTableview.tableFooterView = [UIView new];
    
    if (self.model) {
        [self.headerIamge setImageWithURL:[NSURL URLWithString:self.model.avatar] placeholder:Placeholder_avatar options:YYWebImageOptionSetImageWithFadeAnimation completion:nil];
        
        self.photoNumLabel.text = self.model.pic_num;
        self.dynaNumLabel.text = self.model.fbdt_num;
        self.nameLabel.text = self.model.nickName;
        
        // 无权限修改
        
        if ([self.model.qx intValue] > TheCurBaoBao.qx.intValue && TheCurBaoBao.qx.intValue != 0) {
            rightItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"edit"] style:UIBarButtonItemStyleDone target:self action:@selector(didClickRightItem)];
        }
    }
}

- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    [self.navigationController popViewControllerAnimated:YES];
    return YES;
}

- (void)didClickRightItem {
    [self performSegueWithIdentifier:@"frinedsToModifyVC" sender:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar
     lt_setBackgroundColor:[UIColor clearColor]];
    self.navigationController.navigationBar.translucent = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
    self.navigationController.navigationBar.translucent = NO;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        OneFriendDataCell *cell =
        [tableView dequeueReusableCellWithIdentifier:@"guanxiCell"
                                        forIndexPath:indexPath];
        _gxName = [NSString relationshipWithID:self.model.gxid.numberValue gxname:self.model.gxName];
        cell.relationNameLabel.text = _gxName;
        return cell;
    } else {
        
        TwoFriendDataCell *cell =
        [tableView dequeueReusableCellWithIdentifier:@"qinzikaCell"
                                        forIndexPath:indexPath];
        
        if ([self.model.qzb_flag intValue] == 1) {
            cell.qzkLabel.text = @"已购买";
        } else {
            cell.qzkLabel.text = @"未购买";
        }
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //点击后选中状态消失
    [_FriendDataShowTableview deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
// preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"frinedsToModifyVC"]) {
        setFriendTableViewController *sfvc = segue.destinationViewController;
        sfvc.model = self.model;
        @weakify(self)
        sfvc.block = ^(NSString *string) {
            @strongify(self)
            _gxName = string;
            [self.FriendDataShowTableview reloadData];
        };
    }
}

@end
