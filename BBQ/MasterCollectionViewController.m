//
//  MasterCollectionViewController.m
//  BBQ
//
//  Created by wth on 15/8/10.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "MasterCollectionViewController.h"
#import "MasterCollectionViewCell.h"
#import "WebViewController.h"
#import "SendToViewController.h"
#import <PopMenu.h>
#import "BBQLeaveListTabbleViewController.h"
#import "BBQDualListViewController.h"

@interface MasterCollectionViewController ()

//相机弹窗
@property(nonatomic, strong) PopMenu *popMenu;

@property(weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowlayoutView;

@end

@implementation MasterCollectionViewController

// static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
  [super viewDidLoad];

  // Uncomment the following line to preserve selection between presentations
  // self.clearsSelectionOnViewWillAppear = NO;

  // Register cell classes
  //    [self.collectionView registerClass:[UICollectionViewCell class]
  //    forCellWithReuseIdentifier:reuseIdentifier];

  // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:
    (UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    
    if (TheCurUser.schooltype.integerValue==3) {
        return 7;
    }
    else{
        
        return 9;
    }
}
// cell大小
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

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

  MasterCollectionViewCell *cell = [collectionView
      dequeueReusableCellWithReuseIdentifier:@"collectionCellFirst"
                                forIndexPath:indexPath];

  NSArray *titleArr = @[
    @"校园公告",
    @"班级公告",
    @"教职工公告",
    @"班级动态",@"请假管理",@"育儿资讯",
    @"意见征询",@"每周食谱",@"成长报告"
  ];
  NSArray *imgAry = @[ @"m0", @"cell1", @"cell2", @"m3",@"cell6",@"cell7",@"cell8", @"cell10" ,@"m1"];
  cell.titleLabel.text = titleArr[indexPath.row];
  cell.imageView.image = [UIImage imageNamed:imgAry[indexPath.row]];

  return cell;
}

// cell点击
- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"..点击了第%ld个Cell", (long)indexPath.row);
    
    NSString *path;
    NSString *annName;
    if (indexPath.row == 0) {
        path = URL_XXGG_MA;
        annName = @"校园公告";
    } else if (indexPath.row == 1) {
        path = URL_BJGG_MA;
        annName = @"班级公告";
    } else if (indexPath.row == 2) {
        path = URL_JZGGG_MA;
        annName = @"教职工公告";
    }else if (indexPath.row==4){
        //请假管理
        BBQLeaveListTabbleViewController *vc = [[UIStoryboard storyboardWithName:@"Family" bundle:nil] instantiateViewControllerWithIdentifier:@"leaveListVC"];
        [self.navigationController pushViewController:vc animated:YES];
        
        return;
    }else if (indexPath.row==5){
        path=URL_HOMEPAGE_YUER;
    }else if (indexPath.row==6){
        path=URL_YJZX;
    }else if (indexPath.row == 7) {
        path = URL_MASTER_MZSP;
    }
    //    else if ( indexPath.row == 3 ) path = URL_MASTER_NRSH;
    //    else if ( indexPath.row == 4 ) path = URL_MASTER_YZXX;
    //    else if ( indexPath.row == 5 ) path = URL_MASTER_ZXBM;
    //    else if ( indexPath.row == 6 ) path = URL_MASTER_YWTJ;
    //    else if ( indexPath.row == 7 ) path = URL_MASTER_YZJY;
    //    else if ( indexPath.row == 10 ) path = URL_HOMEPAGE_YUER;
    
    if (!(indexPath.row == 3 || indexPath.row == 8)) {
        UIStoryboard *sb =
        [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
        WebViewController *vc =
        [sb instantiateViewControllerWithIdentifier:@"WebViewController"];
        vc.annceounmentName = annName;
        vc.url = path;
        if (indexPath.row == 0) {
            vc.title = @"校园公告";
        } else if (indexPath.row == 1) {
            vc.title = @"班级公告";
        } else if (indexPath.row == 2) {
            vc.title = @"教职工公告";
        } else if (indexPath.row == 7) {
            vc.title = @"每周食谱";
        }
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 8) {
        BBQDualListViewController *vc = [[UIStoryboard storyboardWithName:@"Common" bundle:nil] instantiateViewControllerWithIdentifier:@"DualListVC"];
        vc.dualListType = BBQDualListTypeDailyReport;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    } else if (indexPath.row == 3) {
        BBQDualListViewController *vc = [[UIStoryboard storyboardWithName:@"Common" bundle:nil] instantiateViewControllerWithIdentifier:@"DualListVC"];
        vc.dualListType = BBQDualListTypeCheckDynamic;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void)showPopMenuWithButton {

  NSMutableArray *items = [NSMutableArray array];

  MenuItem *menuitem = [MenuItem itemWithTitle:@"照片"
                                      iconName:@"item_photo"
                                     glowColor:[UIColor colorWithRed:255 / 255.0
                                                               green:186 / 255.0
                                                                blue:0
                                                               alpha:0.800]];
  [items addObject:menuitem];

  menuitem = [MenuItem itemWithTitle:@"相册导入"
                            iconName:@"item_gallery"
                           glowColor:[UIColor colorWithRed:126 / 255.0
                                                     green:203 / 255.0
                                                      blue:64 / 255.0
                                                     alpha:0.800]];
  [items addObject:menuitem];

  if (!_popMenu) {
    _popMenu = [[PopMenu alloc] initWithFrame:self.view.bounds items:items];
    _popMenu.menuAnimationType = kPopMenuAnimationTypeNetEase;
  }
  if (_popMenu.isShowed) {
    return;
  }

  //选取
  WS(weakSelf)
  _popMenu.didSelectedItemCompletion = ^(MenuItem *selectedItem) {

    NSLog(@"%@", selectedItem.title);
    UIStoryboard *storyBoard =
        [UIStoryboard storyboardWithName:@"Teacher" bundle:nil];
    SendToViewController *sendVcl =
        [storyBoard instantiateViewControllerWithIdentifier:@"SendToVC"];
//    sendVcl.StyleString = @"拍照";
//    if (selectedItem.index == 0)
//      sendVcl.itemType = UploadItemTypePhoto;
//    else if (selectedItem.index == 1)
//      sendVcl.itemType = UploadItemTypeVideo;
//    else
//      sendVcl.itemType = UploadItemTypeAll;

    [weakSelf.navigationController pushViewController:sendVcl animated:YES];

  };

  [_popMenu showMenuAtView:self.view
                startPoint:CGPointMake(CGRectGetWidth(self.view.bounds),
                                       CGRectGetHeight(self.view.bounds))
                  endPoint:CGPointMake(60, CGRectGetHeight(self.view.bounds))];
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted
during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView
shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
        return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView
shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for
the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView
shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
        return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView
canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath
withSender:(id)sender {
        return NO;
}

- (void)collectionView:(UICollectionView *)collectionView
performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath
withSender:(id)sender {

}
*/

@end
