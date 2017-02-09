//
//  babyDatatShowViewController.m
//  BBQ
//
//  Created by wth on 15/7/23.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "babyDatatShowViewController.h"
#import "babyDataShowCell.h"
#import <UINavigationBar+Awesome.h>
#import "babyDataResetViewController.h"
#import <Masonry.h>
#import "BBQDynamicTableViewController.h"

@interface babyDatatShowViewController () <UITableViewDelegate,
UITableViewDataSource>
@property(weak, nonatomic) IBOutlet UITableView *babyDataTableview;
@property(weak, nonatomic) IBOutlet UIImageView *headerIcon;
@property(weak, nonatomic) IBOutlet UILabel *nameLabel;
@property(weak, nonatomic) IBOutlet UILabel *ageLabel;
//刷新页面计数值
@property(nonatomic, assign) int nRefreshPageCount;

@end

@implementation babyDatatShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (!self.baby) {
        self.baby = TheCurBaoBao;
    }
    _babyDataTableview.delegate = self;
    _babyDataTableview.dataSource = self;
    //去除多余分割线
    self.babyDataTableview.tableFooterView = [UIView new];
    
    [self displayBabyInfo];
    
    if (self.baby.qx.integerValue == BBQAuthorityTypeAdmin) {
        self.navigationItem.rightBarButtonItem =
        [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"edit"]
                                         style:UIBarButtonItemStyleDone
                                        target:self
                                        action:@selector(didClickRightItem)];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar
     lt_setBackgroundColor:[UIColor clearColor]];
    self.navigationController.navigationBar.translucent = YES;
    
    //  //判断是否需要刷新
    //  if (self.nRefreshPageCount != [_GLOBAL getRefreshPageCount]) {
    //    self.nRefreshPageCount = [_GLOBAL getRefreshPageCount];
    //
    //    [self displayBabyInfo];
    //
    //    [self.babyDataTableview reloadData];
    //  }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar lt_reset];
}

- (void)displayBabyInfo {
    [self displayHeadView];
    
    self.nameLabel.text = self.baby.realname;
    self.ageLabel.text = [CommonFunc getAgeWithYear:self.baby.birthyear.intValue
                                              month:self.baby.birthmonth.intValue
                                                day:self.baby.birthday.intValue];
    ;
}

- (void)displayHeadView {
    [self.headerIcon setImageWithURL:[NSURL URLWithString:self.baby.avartar] placeholder:[UIImage imageNamed:@"placeholder"]];
}

- (void)didClickRightItem {
    [self performSegueWithIdentifier:@"pushToBabyDataModify" sender:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
#ifdef TARGET_PARENT
    
    return 5;
    
#else
    
    return 6;
    
#endif
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *arr1 =
    @[ @"姓名",
       @"生日",
       @"性别",
       @"幼儿园",
       @"班级",
       @"宝宝动态" ];
    // NSArray *arr2=@[@"于洋洋",@"2000年10月",@"女",@"红太阳幼儿园",@"大一班"];
    
    babyDataShowCell *cell =
    [tableView dequeueReusableCellWithIdentifier:@"babyDataidentifier"];
    cell.Label1.text = arr1[indexPath.row];
    // cell.Label2.text=arr2[indexPath.row];
    if (indexPath.row == 0)
        cell.Label2.text = self.baby.realname;
    else if (indexPath.row == 1) {
        cell.Label2.text =
        [NSString stringWithFormat:@"%@年%@月%@日", self.baby.birthyear,
         self.baby.birthmonth, self.baby.birthday];
    } else if (indexPath.row == 2) {
        if (self.baby.gender.integerValue == 1) {
            cell.Label2.text = @"男";
        } else if (self.baby.gender.integerValue == 2) {
            cell.Label2.text = @"女";
        } else {
            cell.Label2.text = @"";
        }
    } else if (indexPath.row == 3)
        cell.Label2.text = self.baby.curSchool.schoolname;
    else if (indexPath.row == 4)
        cell.Label2.text = self.baby.curClass.classname;
    else if (indexPath.row == 5) {
        cell.Label2.text = @"";
        UIImageView *jiantouImageView = [[UIImageView alloc]
                                         initWithImage:[UIImage imageNamed:@"xiayibu@3x.png"]];
        [cell.contentView addSubview:jiantouImageView];
        [jiantouImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(18, 18));
            make.centerY.mas_equalTo(cell);
            make.right.equalTo(cell).offset(-16);
        }];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 5: {
            BBQDynamicViewModel *viewModel = [BBQDynamicViewModel viewModelForBaby:self.baby.uid];
            BBQDynamicTableViewController *vc = [[BBQDynamicTableViewController alloc] initWithViewModel:viewModel];
            vc.navigationItem.title = self.baby.realname;
            [self.navigationController pushViewController:vc animated:YES];
        } break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
// preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    //选择照片
    if ([segue.identifier isEqualToString:@"pushToBabyDataModify"]) {
        babyDataResetViewController *vc = segue.destinationViewController;
        vc.baby = self.baby;
        return;
    }
}

@end
