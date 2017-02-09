//
//  RelationshipViewController.m
//  JYEX
//
//  Created by 朱琨 on 15/7/5.
//  Copyright © 2015年 广州洋基. All rights reserved.
//

#import "RelationshipViewController.h"
#import "AddRelationshipViewController.h"
#import "BBQRelationshipCollectionCell.h"

@interface RelationshipViewController () <UICollectionViewDataSource,
                                          UICollectionViewDelegate,
                                          UICollectionViewDelegateFlowLayout>
@property(weak, nonatomic) IBOutlet UIButton *dad;

@property(strong, nonatomic) UIButton *lastButton;
@property(strong, nonatomic) IBOutletCollection(UIButton) NSArray *allButton;

@property(strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property(weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property(strong, nonatomic) NSMutableArray *btnTitleAry;

@end

static CGFloat const spaceBetweenItems = 5;
static CGFloat const collectionViewPin = 10;

@implementation RelationshipViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  [self initValues];
  self.collectionView.allowsMultipleSelection = YES;
  self.collectionView.dataSource = self;
  self.collectionView.delegate = self;

  CGFloat itemWidth = ([UIScreen mainScreen].bounds.size.width -
                       2 * collectionViewPin - 2 * spaceBetweenItems) /
                      3.0;
  self.flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth / 2);
  self.flowLayout.minimumLineSpacing = spaceBetweenItems;

  self.btnTitleAry = [NSMutableArray
      arrayWithObjects:@"爸爸", @"妈妈", @"爷爷", @"奶奶", @"外公",
                       @"外婆", @"舅舅", @"姑妈", @"姐姐", @"哥哥",
                       @"叔叔", @"姥姥", @"姥爷", @"干妈", @"小姨",
                       @"阿姨", @"舅妈", @"婶婶", @"姨妈", @"姨父",
                       @"干爸爸", @"姑父", @"伯母", @"姑姑", @"伯父",
                       @"  添加", nil];
}

- (void)initValues {
  if (self.model == nil) {
    self.model = [[RelationshipModel alloc] init];
  }
}

- (IBAction)chooseButton:(UIButton *)sender {
  /**
   * 给model赋值
   *1.已选择关系的名称
   *2.已选择关系的tag, tag从201开始, 用于网络请求修改个人信息时需减去200
   */
  self.model.relationshipTag = [NSNumber numberWithLong:sender.tag];
  self.model.relaName = sender.titleLabel.text;
  // 回调
  if (self.relationshipCallBack) {
    self.relationshipCallBack(self.model);
    [self.navigationController popViewControllerAnimated:YES];
  }
  // 更改button选中状态
  for (UIButton *button in self.allButton) {
    button.selected = NO;
  }
  sender.selected = YES;
}

#pragma mark - CollectionView DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return 26;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  BBQRelationshipCollectionCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:@"relationshipCell"
                                                forIndexPath:indexPath];
  [cell.btn setTitle:[_btnTitleAry objectAtIndex:indexPath.row]
            forState:UIControlStateNormal];
  cell.btn.tag = 201 + indexPath.row;
  [cell.btn addTarget:self
                action:@selector(btnClick:)
      forControlEvents:UIControlEventTouchUpInside];

  if (indexPath.row == 25) {
    [cell.btn setBackgroundImage:[UIImage imageNamed:@"relationship_button_add"]
                        forState:UIControlStateNormal];
    [cell.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  } else {
    [cell.btn setBackgroundImage:[UIImage imageNamed:@"relationship_button"]
                        forState:UIControlStateNormal];
    [cell.btn setBackgroundImage:[UIImage imageNamed:@"relationship_button_sel"]
                        forState:UIControlStateSelected];
    [cell.btn setTitleColor:[UIColor colorWithHexString:@"ff6440"]
                   forState:UIControlStateNormal];
  }

  if ([self.model.relaName isEqualToString:cell.btn.titleLabel.text]) {
    cell.btn.selected = YES;
  }

  return cell;
}

- (void)btnClick:(UIButton *)sender {
  if (sender.selected == NO) {
    if (sender.tag == 226) {
      [self performSegueWithIdentifier:@"AddNewRelation" sender:nil];
    } else {
      /**
       * 给model赋值
       *1.已选择关系的名称
       *2.已选择关系的tag, tag从201开始, 用于网络请求修改个人信息时需减去200
       */
      self.model.relationshipTag = [NSNumber numberWithLong:sender.tag];
      self.model.relaName = sender.titleLabel.text;
      if (self.relationshipCallBack) {
        self.relationshipCallBack(self.model);
        [self.navigationController popViewControllerAnimated:YES];
      }
    }
  }
  sender.selected = !sender.selected;
}

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)collectionView:(UICollectionView *)collectionView
    didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
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

  if ([segue.identifier isEqualToString:@"AddNewRelation"]) {
    AddRelationshipViewController *vc = segue.destinationViewController;
    vc.block = ^(NSString *relationname) {
      self.model.relationshipTag = [NSNumber numberWithInt:300];
      self.model.relaName = relationname;
      // 回调
      if (self.relationshipCallBack) {
        self.relationshipCallBack(self.model);
      }
    };
  }
}

@end
