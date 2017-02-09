//
//  BBQNewUploadViewController.m
//  BBQ
//
//  Created by slovelys on 15/10/13.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQNewUploadViewController.h"
#import "BBQNewUploadCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "Dynamic.h"
#import "BBQPublishManager.h"

@interface BBQNewUploadViewController () <
    UICollectionViewDataSource, UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate,
    UINavigationControllerDelegate>

@property(weak, nonatomic) IBOutlet UILabel *photoCountLabel;
@property(weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property(weak, nonatomic) IBOutlet UIImageView *topLeftView;
@property(weak, nonatomic) IBOutlet UIImageView *topRightView;
@property(weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(weak, nonatomic) IBOutlet UIButton *chooseAllBtn;
@property(weak, nonatomic) IBOutlet UIButton *uploadBtn;
@property(weak, nonatomic) IBOutlet UIButton *overleapBtn;
@property(strong, nonatomic) NSMutableArray *ALAssetArray;
@property(strong, nonatomic) ALAssetsGroup *group;
@property(strong, nonatomic) NSMutableArray *cellAry;
@property(strong, nonatomic) NSMutableArray *allItemsAry;
@property(strong, nonatomic) NSMutableArray *selectedAssetURLs;
@property(strong, nonatomic) ALAssetsLibrary *assetsLibrary;
@property (assign, nonatomic) NSTimeInterval maxTimeInterval;
@end

static CGFloat const spaceBetweenItems = 5;
static CGFloat const collectionViewPin = 10;

@implementation BBQNewUploadViewController
- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
    self.assetsLibrary = [[ALAssetsLibrary alloc] init];
  [self.chooseAllBtn setImage:[UIImage imageNamed:@"dagou"]
                     forState:UIControlStateSelected];

  self.uploadBtn.layer.cornerRadius = 16.3;

  self.uploadBtn.layer.masksToBounds = YES;
  [self.uploadBtn setBackgroundColor:[UIColor colorWithHexString:@"ff6440"]];
  [self.uploadBtn setTitle:@"一键上传" forState:UIControlStateNormal];

  [self gainItemsFromGroup:nil];
  self.topLeftView.image = [UIImage imageNamed:@"newUploadLeft"];
  self.topRightView.image = [UIImage imageNamed:@"newUploadRight"];

  self.ALAssetArray = [NSMutableArray array];
  self.collectionView.allowsMultipleSelection = YES;
  self.collectionView.dataSource = self;
  self.collectionView.delegate = self;
  self.cellAry = [NSMutableArray arrayWithCapacity:0];
  self.allItemsAry = [NSMutableArray arrayWithCapacity:0];
  self.selectedAssetURLs = [NSMutableArray arrayWithCapacity:0];

  CGFloat itemWidth = ([UIScreen mainScreen].bounds.size.width -
                       2 * collectionViewPin - 2 * spaceBetweenItems) /
                      3.0;
  self.flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth);
  self.flowLayout.minimumLineSpacing = spaceBetweenItems;

  [self.photoCountLabel
      setAttributedText:[self changePhotoCountLabelTextWithPhotoCount:0]];
  self.photoCountLabel.userInteractionEnabled = YES;

  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
      initWithTarget:self
              action:@selector(chooseAllEvent:)];
  [self.photoCountLabel addGestureRecognizer:tap];
  [self.photoCountLabel becomeFirstResponder];
}

- (NSAttributedString *)changePhotoCountLabelTextWithPhotoCount:
    (NSInteger)count {
  NSString *str = [NSString stringWithFormat:@"全选(%ld/50)", (long)count];
  NSMutableAttributedString *string =
      [[NSMutableAttributedString alloc] initWithString:str];
  [string addAttribute:NSForegroundColorAttributeName
                 value:[UIColor colorWithHexString:@"ff6440"]
                 range:NSMakeRange(2, str.length - 2)];
  return string;
}

- (void)setGroup:(ALAssetsGroup *)group {
  _group = group;
  //    [self.albumButton setTitle:[group
  //    valueForProperty:ALAssetsGroupPropertyName]
  //    forState:UIControlStateNormal];
  [self gainItemsFromGroup:group];
}

- (void)gainItemsFromGroup:(ALAssetsGroup *)group {
  [self.ALAssetArray removeAllObjects];
    ALAssetsLibrary *assetsLibrary = self.assetsLibrary;
  [assetsLibrary
      enumerateGroupsWithTypes:
          group ? [[group valueForProperty:
                              ALAssetsGroupPropertyType] unsignedIntegerValue]
                : ALAssetsGroupSavedPhotos
      usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        //            if (group) {

        [group setAssetsFilter:[ALAssetsFilter allPhotos]];

        [group enumerateAssetsWithOptions:NSEnumerationReverse
                               usingBlock:^(ALAsset *result, NSUInteger index,
                                            BOOL *stop) {
                                 if (result) {

                                   [self.ALAssetArray addObject:result];
                                 }
                               }];
        [self.collectionView reloadData];

      }
      failureBlock:^(NSError *error) {
        NSLog(@"获取相册失败");
      }];
}

- (BOOL)checkAuthorizationStatus {
  NSString *tipTextWhenNoPhotosAuthorization;
  ALAuthorizationStatus authorizationStatus =
      [ALAssetsLibrary authorizationStatus];
  if (authorizationStatus == ALAuthorizationStatusRestricted ||
      authorizationStatus == ALAuthorizationStatusDenied) {
    NSDictionary *mainInfoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appName =
        [mainInfoDictionary objectForKey:@"CFBundleDisplayName"];
    tipTextWhenNoPhotosAuthorization = [NSString
        stringWithFormat:
            @"请在设备的\"设置-隐私-照片\"选项中，允许%@"
            @"访问你的手机相册",
            appName];
    NSLog(@"%@", tipTextWhenNoPhotosAuthorization);
    // 展示提示语
    return NO;
  }
  return YES;
}

#pragma mark - CollectionView DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  _chooseAllBtn.enabled = (_ALAssetArray.count == 0) ? NO : YES;
  return self.ALAssetArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  BBQNewUploadCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:@"NewUploadCell"
                                                forIndexPath:indexPath];
  cell.chooseView.hidden = NO;
  ALAsset *asset = self.ALAssetArray[indexPath.item];
  UIImage *image = [UIImage imageWithCGImage:[asset thumbnail]];
  cell.imgView.image = image;

  if ([self.selectedAssetURLs
          containsObject:[asset valueForProperty:ALAssetPropertyAssetURL]]) {
    cell.chooseView.highlighted = YES;
  } else {
    cell.chooseView.highlighted = NO;
  }

  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

  ALAsset *asset = [_ALAssetArray objectAtIndex:indexPath.item];

  // 如果已选中，反选
  if ([self.selectedAssetURLs
          containsObject:[asset valueForProperty:ALAssetPropertyAssetURL]]) {
    [self.selectedAssetURLs
        removeObject:[asset valueForProperty:ALAssetPropertyAssetURL]];
  } else {

    if (_selectedAssetURLs.count == 50) {
      [SVProgressHUD showInfoWithStatus:@"一次最多上传50张照片"];
    }
    // 没有选中也没有达到上限，选中
    else {
      [self.selectedAssetURLs
          addObject:[asset valueForProperty:ALAssetPropertyAssetURL]];
    }
  }
  [self.photoCountLabel
      setAttributedText:
          [self changePhotoCountLabelTextWithPhotoCount:_selectedAssetURLs.count]];
  [self.collectionView reloadData];

  // 选中数组个数等于总数组个数且不等于0
  if (_selectedAssetURLs.count == _ALAssetArray.count != 0) {
    [_chooseAllBtn setSelected:YES];
  }
  // 选中照片达到上限
  else if (_selectedAssetURLs.count == 50) {
    [_chooseAllBtn setSelected:YES];
  } else {
    [_chooseAllBtn setSelected:NO];
  }
}

- (void)collectionView:(UICollectionView *)collectionView
    didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
  NSLog(@"1");
}

/// 删除选中
- (void)deleteItem {
  [_ALAssetArray removeObjectsInArray:_selectedAssetURLs];
  [_selectedAssetURLs removeAllObjects];
  [self.collectionView reloadData];
}

- (void)selectAll {
  // 如果选中照片个数等于总照片个数且全选btn是选中状态，那么就去掉所有的选中照片
  if (_selectedAssetURLs.count == _ALAssetArray.count &&
      _chooseAllBtn.selected == YES) {
    [_selectedAssetURLs removeAllObjects];
  }
  // 只要全选btn是选中状态，再次点击的时候就去掉所有的选中照片
  else if (_chooseAllBtn.selected == YES) {
    [_selectedAssetURLs removeAllObjects];
  } else {
    //        [_selectedAssetURLs removeAllObjects];
    for (ALAsset *set in _ALAssetArray) {
      // 防止重复
      if (!([self.selectedAssetURLs
              containsObject:[set valueForProperty:ALAssetPropertyAssetURL]])) {
        [self.selectedAssetURLs
            addObject:[set valueForProperty:ALAssetPropertyAssetURL]];
      }
      // 达到照片数量上限
      if (_selectedAssetURLs.count == 50) {
        break;
      }
    }
  }
  [self.photoCountLabel
      setAttributedText:
          [self changePhotoCountLabelTextWithPhotoCount:_selectedAssetURLs.count]];
  [self.collectionView reloadData];
}

- (IBAction)chooseAllEvent:(UIButton *)sender {
  [self selectAll];
  _chooseAllBtn.selected = !_chooseAllBtn.selected;
  if (_chooseAllBtn.selected == NO) {
    [_selectedAssetURLs removeAllObjects];
  }
}
- (IBAction)uploadEvent:(id)sender {
  if (_selectedAssetURLs.count > 0) {
      [self fetchAssetsFromSelectedAssetURLsWithCompletion:^(NSArray *assets) {
          Dynamic *dynamic = [Dynamic dynamicWithMediaType:BBQDynamicMediaTypeBatch object:TheCurBaoBao];
          
          if (assets.count) {
              dynamic.graphtime = @(self.maxTimeInterval);
          } else {
              dynamic.graphtime = @([[NSDate date] timeIntervalSince1970]);
          }
          
          NSArray *attachments = [assets bk_map:^id(ALAsset *asset) {
              Attachment *attachment = [Attachment attachmentWithAsset:asset dynamic:dynamic];
              return attachment;
          }];
          
          [dynamic.attachinfo addObjectsFromArray:attachments];
          
          [[BBQPublishManager sharedManager] addDynamic:dynamic];
          [self dismissViewControllerAnimated:YES completion:nil];
      }];
  } else {
    [SVProgressHUD showInfoWithStatus:@"请选择上传照片"];
  }
}

/// 跳过
- (IBAction)overleapEvent:(id)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSDictionary *)saveSelectPicture:(UIImage *)picImg {
  NSString *filenameGuid = [NSString stringWithUUID];
  NSDictionary *dicFileInfo =
      [CommonFunc saveJYEXPic:picImg fileguid:filenameGuid mode:@"L"];

  return dicFileInfo;
}

- (void)fetchAssetsFromSelectedAssetURLsWithCompletion:
(void (^)(NSArray *assets))completion {
    // Load assets from URLs
    // The asset will be ignored if it is not found
    ALAssetsLibrary *assetsLibrary = self.assetsLibrary;
//    NSMutableOrderedSet *selectedAssetURLs =
//    self.selectedAssetURLs;
    
    __block NSMutableArray *assets = [NSMutableArray array];
    
    void (^checkNumberOfAssets)(void) = ^{
        if (assets.count == self.selectedAssetURLs.count) {
            if (completion) {
                completion([assets copy]);
            }
        }
    };
    
    void (^checkMaxDate)(ALAsset *) = ^(ALAsset *asset) {
        NSTimeInterval timeInteravl = [[asset valueForProperty:ALAssetPropertyDate] timeIntervalSince1970];
        self.maxTimeInterval = MAX(self.maxTimeInterval, timeInteravl);
    };
    
    for (NSURL *assetURL in self.selectedAssetURLs) {
        [assetsLibrary assetForURL:assetURL
                       resultBlock:^(ALAsset *asset) {
                           if (asset) {
                               // Add asset
                               [assets addObject:asset];
                               checkMaxDate(asset);
                               checkNumberOfAssets();
                           } else {
                               [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupPhotoStream
                                                            usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                                                                [group enumerateAssetsWithOptions:NSEnumerationReverse
                                                                                       usingBlock:^(ALAsset *result,
                                                                                                    NSUInteger index,
                                                                                                    BOOL *stop) {
                                                                                           if ([result.defaultRepresentation.url
                                                                                                isEqual:assetURL]) {
                                                                                               [assets addObject:result];checkMaxDate(asset);                       // Check if the loading finished
                                                                                               checkNumberOfAssets();
                                                                                               *stop = YES;
                                                                                           }
                                                                                       }];
                                                            }
                                                          failureBlock:^(NSError *error) {
                                                              NSLog(@"Error: %@", [error localizedDescription]);
                                                          }];
                           }
                       }
                      failureBlock:^(NSError *error) {
                          NSLog(@"Error: %@", [error localizedDescription]);
                      }];
    }
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (self.showNewGuiderBlock != nil) {
        self.showNewGuiderBlock();
    }
}

@end
