//
//  MainCollectionViewController.m
//  BBQ
//
//  Created by wth on 15/8/6.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "MainCollectionViewController.h"
#import "MainCollectionViewCell.h"
#import "WebViewController.h"
#import "BBQClassDataModel.h"
#import "BaobaoListTableViewController.h"
#import "CreateAnnouncementTableViewController.h"
#import "BBQChooseStatusViewController.h"
#import "BBQLeaveListTabbleViewController.h"

@interface MainCollectionViewController ()
@property(weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowlayoutView;

@end

@implementation MainCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
// preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"firstPageToBabyList"]) {
        BaobaoListTableViewController *vc = segue.destinationViewController;
        vc.needJumpToCalendarVC = YES;
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:
(UICollectionView *)collectionView {
    
    if (TheCurUser.schooltype.integerValue==3) {
        return 1;
    }
    else{
        
        return 3;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    
    if (section == 1) {
        
        return 1;
    } else if (section == 0) {
        
        if (TheCurUser.schooltype.integerValue==3) {
            return 10;
        }
        else{
            
            return 11;
        }
        
    } else{
        
        return 8;
    }
    
}

// cell大小
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        
        return CGSizeMake(self.view.bounds.size.width, 62);
    }
    
    CGFloat itemWidth = ([UIScreen mainScreen].bounds.size.width - 7) / 4;
    return CGSizeMake(itemWidth, itemWidth);
}
//上下行距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)
collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 1;
}
//左右间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)
collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}
//偏移量
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(1, 1, 1, 1);
}

//显示cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MainCollectionViewCell *cell1 = [collectionView
                                     dequeueReusableCellWithReuseIdentifier:@"collectionCellFirst"
                                     forIndexPath:indexPath];
    
    UICollectionViewCell *cell2 =
    [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2"
                                              forIndexPath:indexPath];
    // Configure the cell
    //    NSArray
    //    *titleArr1=@[@"通知公告",@"请假管理",@"宝宝考勤",@"意见征询",@"事件提醒",@"内容审核",@"家园沟通",@"班务统计"];
    NSArray *titleArr1 = @[
                           @"校园公告",@"班级公告",@"教职工公告",@"布置作业",@"宝宝考勤",@"我的考勤",@"请假管理",@"育儿资讯",@"意见征询",@"家园沟通",@"每周食谱"];
    NSArray *titleArr2 = @[
                           @"早餐",
                           @"午餐",
                           @"午睡",
                           @"喝水",
                           @"学习",
                           @"情绪",
                           @"健康",
                           @"寄语"
                           ];
    if (indexPath.section == 1) {
        
        return cell2;
    }
    
    if (indexPath.section == 2) {
        cell1.imageView.image = [UIImage
                                 imageNamed:[NSString
                                             stringWithFormat:@"cell%ld", (long)indexPath.row + 11]];
        cell1.lbText.text = titleArr2[indexPath.row];
    } else {
        
        cell1.imageView.image = [UIImage
                                 imageNamed:[NSString stringWithFormat:@"cell%ld", (long)indexPath.row]];
        
        cell1.lbText.text = titleArr1[indexPath.row];
    }
    return cell1;
}

#pragma mark - UICollectionViewDelegate
// cell点击
- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    BBQClassDataModel *model = TheCurUser.classdata.firstObject;
    if (indexPath.section == 2) {
        UIStoryboard *sb =
        [UIStoryboard storyboardWithName:@"DailyReport" bundle:nil];
        BBQChooseStatusViewController *vc =
        [sb instantiateViewControllerWithIdentifier:@"ChooseStatusVC"];
        vc.flag = indexPath.row;
        vc.classuid = model.classid.stringValue;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.section == 0) {
        NSString *path;
        NSString *annName;
        if (indexPath.row == 6) {
            BBQLeaveListTabbleViewController *vc = [[UIStoryboard storyboardWithName:@"Family" bundle:nil] instantiateViewControllerWithIdentifier:@"leaveListVC"];
            [self.navigationController pushViewController:vc animated:YES];
            return;
        }
        if (indexPath.row == 0) {
            path = [NSString stringWithFormat:URL_XXGG_TE, model.classid];
            annName = @"校园公告";
        } else if (indexPath.row == 1) {
            path = [NSString stringWithFormat:URL_BJGG_TE, model.classid];
            annName = @"班级公告";
        } else if (indexPath.row == 2) {
            path = [NSString stringWithFormat:URL_JZGGG_TE, model.classid];
            annName = @"教职工公告";
        } else if (indexPath.row == 3) {
            path = [NSString stringWithFormat:URL_ZZ_TE, model.classid];
            annName = @"布置作业";
        } else if (indexPath.row == 4) {
            path = [NSString stringWithFormat:URL_XSKQGL, model.classid];
        } else if (indexPath.row == 5) {
            path = [NSString stringWithFormat:URL_WODEKQ, TheCurUser.member.uid];
        }else if (indexPath.row == 7) {
            path = URL_HOMEPAGE_YUER;
        }else if (indexPath.row == 8) {
            path = URL_YJZX;
        }else if (indexPath.row == 9) {
            path = URL_JYGT;
        }else if (indexPath.row == 10) {
            path = URL_MZSP;
        }
        //        else if ( indexPath.row == 4 ) path = URL_SJTX;
        //        else if ( indexPath.row == 5 ) path =[NSString
        //        stringWithFormat:URL_NRSH,model.classuid];
        
        //        else if ( indexPath.row == 7 ) path =[NSString
        //        stringWithFormat:URL_BWTJ,model.classuid];
        UIStoryboard *sb =
        [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
        WebViewController *vc =
        [sb instantiateViewControllerWithIdentifier:@"WebViewController"];
        vc.annceounmentName = annName;
        vc.url = path;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
