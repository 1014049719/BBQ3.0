//
//  ReceivedGiftViewController.m
//  BBQ
//
//  Created by anymuse on 15/8/4.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "ReceivedGiftViewController.h"
#import "ReceivedGiftCell.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import "GiftViewController.h"

@interface ReceivedGiftViewController ()
@property(weak, nonatomic) IBOutlet UIButton *goShoppingButton;
@property(weak, nonatomic) IBOutlet UITableView *tableView;
@property(weak, nonatomic) IBOutlet UIImageView *fbztxImageView;
@property(weak, nonatomic) IBOutlet UILabel *giftInfoLabel;

@end

@implementation ReceivedGiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.goShoppingButton.layer.masksToBounds = YES;
    self.goShoppingButton.layer.cornerRadius =
    CGRectGetHeight(self.goShoppingButton.frame) / 2;
    self.fbztxImageView.layer.masksToBounds = YES;
    self.fbztxImageView.layer.cornerRadius =
    CGRectGetHeight(self.fbztxImageView.frame) / 2;
    self.tableView.tableFooterView = [UIView new];
    
    [self.dynamic bk_addObserverForKeyPath:@"giftdata" options:NSKeyValueObservingOptionNew task:^(id obj, NSDictionary *change) {
        [self.tableView reloadData];
    }];
    
    [self.fbztxImageView setImageWithURL:[NSURL URLWithString:self.dynamic.fbztx] placeholder:Placeholder_avatar options:YYWebImageOptionRefreshImageCache | YYWebImageOptionSetImageWithFadeAnimation completion:nil];
    [self countGift];
}

- (void)countGift {
    __block NSInteger giftCount = 0;
    dispatch_async(
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                       [self.dynamic.giftdata
                        enumerateObjectsUsingBlock:^(Gift *model, NSUInteger idx,
                                                     BOOL *stop) {
                            giftCount += [model.giftcount integerValue];
                        }];
                       NSString *string =
                       [NSString stringWithFormat:@"%@本次收到%@份礼物", self.dynamic.crenickname,
                        @(giftCount)];
                       NSMutableAttributedString *attributedString =
                       [[NSMutableAttributedString alloc] initWithString:string];
                       [attributedString
                        addAttribute:NSForegroundColorAttributeName
                        value:[UIColor colorWithHexString:@"ff6440"]
                        range:[string
                               rangeOfString:[NSString stringWithFormat:
                                              @"%@", @(giftCount)]]];
                       dispatch_async(dispatch_get_main_queue(), ^{
                           self.giftInfoLabel.attributedText = attributedString;
                       });
                   });
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return self.dynamic.giftdata.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReceivedGiftCell *cell =
    [tableView dequeueReusableCellWithIdentifier:@"ReceivedGiftCell"
                                    forIndexPath:indexPath];
    
    cell.model = self.dynamic.giftdata[indexPath.row];
    if (self.tableView.dragging == NO && self.tableView.decelerating == NO) {
        [cell loadImages];
    }
    return cell;
}

- (CGFloat)tableView:(nonnull UITableView *)tableView
heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:@"ReceivedGiftCell"
                                    cacheByIndexPath:indexPath
                                       configuration:^(ReceivedGiftCell *cell) {
                                           cell.model =
                                           self.dynamic.giftdata[indexPath.row];
                                       }];
}

- (void)tableView:(nonnull UITableView *)tableView
didEndDisplayingCell:(nonnull UITableViewCell *)cell
forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [(ReceivedGiftCell *)cell cancelAllOperations];
}

#pragma mark - Scroll Delegate
// -------------------------------------------------------------------------------
//	scrollViewDidEndDragging:willDecelerate:
//  Load images for all onscreen rows when scrolling is finished.
// -------------------------------------------------------------------------------
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self loadImagesForOnscreenRows];
    }
}

// -------------------------------------------------------------------------------
//	scrollViewDidEndDecelerating:scrollView
//  When scrolling stops, proceed to load the app icons that are on screen.
// -------------------------------------------------------------------------------
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self loadImagesForOnscreenRows];
}

- (void)loadImagesForOnscreenRows {
    if (self.dynamic.giftdata.count > 0) {
        NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths) {
            ReceivedGiftCell *cell =
            (ReceivedGiftCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            [cell loadImages];
        }
    }
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ReceivedGiftToShopSegue"]) {
        GiftViewController *gvc = segue.destinationViewController;
        gvc.dynamic = self.dynamic;
    }
}

@end
