//
//  GiftCollectionViewController.m
//  BBQ
//
//  Created by wth on 15/8/11.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "GiftCollectionViewController.h"
#import "TeGiftModel.h"
#import "TeGiftCell.h"
#import "GiverRecordTableViewController.h"

@interface GiftCollectionViewController ()

@property(strong, nonatomic) NSMutableArray *dataAry;

@end

@implementation GiftCollectionViewController

// static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
  [super viewDidLoad];

  [self initValues];
  [self getGiftData];
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

- (void)initValues {
  if (self.dataAry == nil) {
    self.dataAry = [NSMutableArray arrayWithCapacity:0];
  }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:
    (UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return self.dataAry.count;
}
// cell大小
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

  CGFloat itemWidth = ([UIScreen mainScreen].bounds.size.width - 60) / 2;
  return CGSizeMake(itemWidth + 10, itemWidth - 10);
}
//上下行距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                                 layout:(UICollectionViewLayout *)
                                            collectionViewLayout
    minimumLineSpacingForSectionAtIndex:(NSInteger)section {

  return 10;
}
//左右间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                                      layout:(UICollectionViewLayout *)
                                                 collectionViewLayout
    minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {

  return 0;
}
//偏移量
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {

  return UIEdgeInsetsMake(15, 12, 15, 12);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  TeGiftCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:@"cell"
                                                forIndexPath:indexPath];

  TeGiftModel *model = self.dataAry[indexPath.row];
    [cell.giftImage setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholder:Placeholder_avatar options:YYWebImageOptionSetImageWithFadeAnimation completion:nil];

  cell.giftNameLabel.text = model.giftName;
  NSString *str = [NSString stringWithFormat:@"共收到 %@ 份", model.giftNum];
  NSMutableAttributedString *string =
      [[NSMutableAttributedString alloc] initWithString:str];
  [string addAttribute:NSForegroundColorAttributeName
                 value:[UIColor redColor]
                 range:NSMakeRange(3, str.length - 3)];
  [cell.giftNumLabel setAttributedText:string];

  return cell;
}

#pragma mark - 网络请求

- (void)getGiftData {
  [SVProgressHUD showWithStatus:@"请稍候..."];
  [BBQHTTPRequest
       queryWithType:BBQHTTPRequestTypeGetAllGiftData
               param:nil
      successHandler:^(AFHTTPRequestOperation *operation,
                       NSDictionary *responseObject, bool apiSuccess) {
        [SVProgressHUD dismiss];
        dispatch_async(
            dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
              NSArray *tempAry = responseObject[@"data"][@"arr"];
              for (NSDictionary *tempDic in tempAry) {
                TeGiftModel *model = [[TeGiftModel alloc] initWithDic:tempDic];
                [self.dataAry addObject:model];
              }
              dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
              });
            });
      } errorHandler:nil
      failureHandler:nil];
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  TeGiftModel *model = self.dataAry[indexPath.row];
  [self performSegueWithIdentifier:@"giftJumpToGiverRecord"
                            sender:model.giftID];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
// preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

  if ([segue.identifier isEqualToString:@"giftJumpToGiverRecord"]) {
    GiverRecordTableViewController *grvc = segue.destinationViewController;
    grvc.giftID = sender;
  }
}

@end
