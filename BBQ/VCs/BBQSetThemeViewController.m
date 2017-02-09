//
//  BBQSetThemeViewController.m
//  BBQ
//
//  Created by slovelys on 15/12/21.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQSetThemeViewController.h"
#import "BBQSetThemeCell.h"
#import <IMYThemeConfig.h>
#import <UIColor+IMY_Theme.h>
#import "BBQThemeManager.h"
#import "AppDelegate.h"

@interface BBQSetThemeViewController () <
UICollectionViewDataSource, UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *imgDataSource;
@property (strong, nonatomic) NSMutableArray *nameDataSource;
@property (strong, nonatomic) IMYThemeManager *manager;

@end

static CGFloat const spaceBetweenItems = 5;
static CGFloat const collectionViewPin = 10;

@implementation BBQSetThemeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置皮肤";
    _manager = [IMYThemeManager sharedIMYThemeManager];
    _imgDataSource = [NSMutableArray arrayWithObjects:@"themeDefault.jpg",@"themeLego.jpg", @"themeXiaoP.png", nil];
    _nameDataSource = [NSMutableArray arrayWithObjects:@"默认", @"乐高世界", @"小P优优", nil];
    self.collectionView.allowsMultipleSelection = YES;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    CGFloat itemWidth = ([UIScreen mainScreen].bounds.size.width -
                         2 * collectionViewPin - 2 * spaceBetweenItems) /
    2.0;
    self.flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth - 10);
    self.flowLayout.minimumLineSpacing = spaceBetweenItems;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return _imgDataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BBQSetThemeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"setThemeCell" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:_imgDataSource[indexPath.item]];
    cell.nameLabel.text = _nameDataSource[indexPath.item];
//    NSString *ss = [[BBQThemeManager sharedInstance] getTheCurThemeType];
    
    
    if (indexPath.item == 0) {
        cell.selectedImgView.hidden = (_manager.themePath == nil) ? NO : YES;
    }
    if (indexPath.item == 1) {
        cell.selectedImgView.hidden = ([_manager.themePath hasSuffix:kThemeLego]) ? NO : YES;
    }
    if (indexPath.item == 2) {
        cell.selectedImgView.hidden = ([_manager.themePath hasSuffix:kThemeXiaoP]) ? NO : YES;
    }
//    switch (indexPath.item) {
//        case 0:
//            cell.selectedImgView.hidden = (_manager.themePath == nil) ? NO : YES;
//            break;
//        case 1:
//            cell.selectedImgView.hidden = ([_manager.themePath hasSuffix:kThemeLego]) ? YES : NO;
//            break;
//        case 2:
//            cell.selectedImgView.hidden = ([_manager.themePath hasSuffix:kThemeXiaoP]) ? YES : NO;
//            break;
//            
//        default:
//            break;
//    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    BBQSetThemeCell *cell = (BBQSetThemeCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell.selectedImgView.hidden == NO) return;
    switch (indexPath.item) {
        case 0:
            _manager.themePath = nil;
            TheCurUser.themeType = BBQThemeTypeDefault;
            break;
        case 1:
            _manager.themePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:kThemeLego];
            TheCurUser.themeType = BBQThemeTypeLego;
            break;
        case 2:
            _manager.themePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:kThemeXiaoP];
            TheCurUser.themeType = BBQThemeTypeXiaoP;
            break;
            
        default:
            break;
    }
    [TheCurUser save];
    [[BBQThemeManager sharedInstance] switchTheme:indexPath.item + 1];
    [((AppDelegate *)[UIApplication sharedApplication].delegate)
     setupTabBarController];
    [((AppDelegate *)[UIApplication sharedApplication].delegate)
     setupAppearance];
    [collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
