//
//  QBAlbumsViewController.m
//  QBImagePicker
//
//  Created by Katsuma Tanaka on 2015/04/06.
//  Copyright (c) 2015 Katsuma Tanaka. All rights reserved.
//

#import "QBAlbumsViewController.h"

// Views
#import "QBAlbumCell.h"

// ViewControllers
#import "QBImagePickerController.h"
#import "QBAssetsViewController.h"

@interface QBImagePickerController (Private)

@property(nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property(nonatomic, strong) NSBundle *assetBundle;

@end

@interface QBAlbumsViewController ()

@end

@implementation QBAlbumsViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  // Configure navigation item
  self.navigationItem.title = NSLocalizedStringFromTableInBundle(
      @"title", @"QBImagePicker", self.imagePickerController.assetBundle, nil);
  self.navigationItem.prompt = self.imagePickerController.prompt;
}

#pragma mark - Actions

- (IBAction)cancel:(id)sender {
  if ([self.imagePickerController.delegate
          respondsToSelector:@selector(qb_imagePickerControllerDidCancel:)]) {
    [self.imagePickerController.delegate
        qb_imagePickerControllerDidCancel:self.imagePickerController];
  }
}

- (IBAction)done:(id)sender {
  if ([self.imagePickerController.delegate
          respondsToSelector:@selector(qb_imagePickerController:
                                                didSelectAssets:)]) {
    [self fetchAssetsFromSelectedAssetURLsWithCompletion:^(NSArray *assets) {
      [self.imagePickerController.delegate
          qb_imagePickerController:self.imagePickerController
                   didSelectAssets:assets];
    }];
  }
}

- (void)updateSelectionInfo {
  NSMutableArray *selectedAssetURLs =
      self.imagePickerController.selectedAssetURLs;

  if (selectedAssetURLs.count > 0) {
    NSBundle *bundle = self.imagePickerController.assetBundle;
    NSString *format;
    if (selectedAssetURLs.count > 1) {
      format = NSLocalizedStringFromTableInBundle(
          @"items_selected", @"QBImagePicker", bundle, nil);
    } else {
      format = NSLocalizedStringFromTableInBundle(
          @"item_selected", @"QBImagePicker", bundle, nil);
    }

    NSString *title =
        [NSString stringWithFormat:format, selectedAssetURLs.count];
    [(UIBarButtonItem *)self.toolbarItems[1] setTitle:title];
  } else {
    [(UIBarButtonItem *)self.toolbarItems[1] setTitle:@""];
  }
}

- (void)fetchAssetsFromSelectedAssetURLsWithCompletion:
    (void (^)(NSArray *assets))completion {
  // Load assets from URLs
  // The asset will be ignored if it is not found
  ALAssetsLibrary *assetsLibrary = self.imagePickerController.assetsLibrary;
  NSMutableArray *selectedAssetURLs =
      self.imagePickerController.selectedAssetURLs;

  __block NSMutableArray *assets = [NSMutableArray array];

  void (^checkNumberOfAssets)(void) = ^{
    if (assets.count == selectedAssetURLs.count) {
      if (completion) {
        completion([assets copy]);
      }
    }
  };

  for (NSURL *assetURL in selectedAssetURLs) {
    [assetsLibrary assetForURL:assetURL
        resultBlock:^(ALAsset *asset) {
          if (asset) {
            // Add asset
            [assets addObject:asset];

            // Check if the loading finished
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
                                             // Add asset
                                             [assets addObject:result];

                                             // Check if the loading finished
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

#pragma mark - Checking for Selection Limit

- (BOOL)isMinimumSelectionLimitFulfilled {
  return (self.imagePickerController.minimumNumberOfSelection <=
          self.imagePickerController.selectedAssetURLs.count);
}

- (BOOL)isMaximumSelectionLimitReached {
  NSUInteger minimumNumberOfSelection =
      MAX(1, self.imagePickerController.minimumNumberOfSelection);

  if (minimumNumberOfSelection <=
      self.imagePickerController.maximumNumberOfSelection) {
    return (self.imagePickerController.maximumNumberOfSelection <=
            self.imagePickerController.selectedAssetURLs.count);
  }

  return NO;
}

#pragma mark - UITableViewDataSource
- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  if (self.didSelectAlbumAtIndex) {
    self.didSelectAlbumAtIndex(indexPath.row);
    [self.navigationController popViewControllerAnimated:YES];
  }
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return self.assetsGroups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  QBAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AlbumCell"
                                                      forIndexPath:indexPath];
  cell.tag = indexPath.row;
  cell.borderWidth = 1.0 / [[UIScreen mainScreen] scale];

  // Thumbnail
  ALAssetsGroup *assetsGroup = self.assetsGroups[indexPath.row];

  NSUInteger numberOfAssets = MIN(3, [assetsGroup numberOfAssets]);

  if (numberOfAssets > 0) {
    NSRange range = NSMakeRange([assetsGroup numberOfAssets] - numberOfAssets,
                                numberOfAssets);
    NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:range];

    cell.imageView3.hidden = YES;
    cell.imageView2.hidden = YES;

    [assetsGroup enumerateAssetsAtIndexes:indexes
                                  options:0
                               usingBlock:^(ALAsset *result, NSUInteger index,
                                            BOOL *stop) {
                                 if (!result || cell.tag != indexPath.row)
                                   return;

                                 UIImage *thumbnail = [UIImage
                                     imageWithCGImage:[result thumbnail]];

                                 if (index == NSMaxRange(range) - 1) {
                                   cell.imageView1.hidden = NO;
                                   cell.imageView1.image = thumbnail;
                                 } else if (index == NSMaxRange(range) - 2) {
                                   cell.imageView2.hidden = NO;
                                   cell.imageView2.image = thumbnail;
                                 } else {
                                   cell.imageView3.hidden = NO;
                                   cell.imageView3.image = thumbnail;
                                 }
                               }];
  } else {
    cell.imageView3.hidden = NO;
    cell.imageView2.hidden = NO;

    // Set placeholder image
    UIImage *placeholderImage =
        [self placeholderImageWithSize:cell.imageView1.frame.size];
    cell.imageView1.image = placeholderImage;
    cell.imageView2.image = placeholderImage;
    cell.imageView3.image = placeholderImage;
  }

  // Album title
  cell.titleLabel.text =
      [assetsGroup valueForProperty:ALAssetsGroupPropertyName];

  // Number of photos
  cell.countLabel.text =
      [NSString stringWithFormat:@"%lu", (long)assetsGroup.numberOfAssets];

  return cell;
}

- (UIImage *)placeholderImageWithSize:(CGSize)size {
  UIGraphicsBeginImageContext(size);
  CGContextRef context = UIGraphicsGetCurrentContext();

  UIColor *backgroundColor = [UIColor colorWithRed:(239.0 / 255.0)
                                             green:(239.0 / 255.0)
                                              blue:(244.0 / 255.0)
                                             alpha:1.0];
  UIColor *iconColor = [UIColor colorWithRed:(179.0 / 255.0)
                                       green:(179.0 / 255.0)
                                        blue:(182.0 / 255.0)
                                       alpha:1.0];

  // Background
  CGContextSetFillColorWithColor(context, [backgroundColor CGColor]);
  CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));

  // Icon (back)
  CGRect backIconRect =
      CGRectMake(size.width * (16.0 / 68.0), size.height * (20.0 / 68.0),
                 size.width * (32.0 / 68.0), size.height * (24.0 / 68.0));

  CGContextSetFillColorWithColor(context, [iconColor CGColor]);
  CGContextFillRect(context, backIconRect);

  CGContextSetFillColorWithColor(context, [backgroundColor CGColor]);
  CGContextFillRect(context, CGRectInset(backIconRect, 1.0, 1.0));

  // Icon (front)
  CGRect frontIconRect =
      CGRectMake(size.width * (20.0 / 68.0), size.height * (24.0 / 68.0),
                 size.width * (32.0 / 68.0), size.height * (24.0 / 68.0));

  CGContextSetFillColorWithColor(context, [backgroundColor CGColor]);
  CGContextFillRect(context, CGRectInset(frontIconRect, -1.0, -1.0));

  CGContextSetFillColorWithColor(context, [iconColor CGColor]);
  CGContextFillRect(context, frontIconRect);

  CGContextSetFillColorWithColor(context, [backgroundColor CGColor]);
  CGContextFillRect(context, CGRectInset(frontIconRect, 1.0, 1.0));

  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();

  return image;
}

@end
