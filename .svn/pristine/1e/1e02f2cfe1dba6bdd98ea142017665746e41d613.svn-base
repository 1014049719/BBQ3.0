//
//  DynamicViewController.m
//  BBQ
//
//  Created by wth on 15/8/11.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "DynamicViewController.h"
#import "DynamicPageViewController.h"
#import <PopMenu.h>
#import "SendToViewController.h"
#import "BBQIndicatorBar.h"
#import "AppDelegate.h"

@interface DynamicViewController ()

//当前选中button
@property(strong, nonatomic) UIButton *currentBtn;
//滑动红线
@property(weak, nonatomic) IBOutlet UIImageView *redLineImageView;
@property(weak, nonatomic) IBOutlet UIButton *cameraButton;

// PageVcl
@property(strong, nonatomic) DynamicPageViewController *dynamicPageVcl;

//相机弹窗
@property(nonatomic, strong) PopMenu *popMenu;
@property(weak, nonatomic) IBOutlet BBQIndicatorBar *indicatorBar;
@property(weak, nonatomic) IBOutlet NSLayoutConstraint *indicatorBarTopCons;

@end

@implementation DynamicViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
  [super viewDidLoad];

  UIButton *button = (UIButton *)[self.view viewWithTag:10];
  button.selected = YES;
  [button.titleLabel setFont:[UIFont systemFontOfSize:17]];
  self.currentBtn = button;

  self.indicatorBar.topCons = self.indicatorBarTopCons;
  self.indicatorBar.vc = self;
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  if (self.popMenu.isShowed) {
    [self.popMenu dismissMenu];
  }
}

//相机 弹出浮层
- (IBAction)camera:(id)sender {
  self.popMenu.isShowed ? [self.popMenu dismissMenu] : [self showPopMenu];
}

//-(void)showPopMenu{
//
//    NSMutableArray *items = [NSMutableArray array];
//
//    MenuItem *menuitem=[MenuItem itemWithTitle:@"照片" iconName:@"item_photo"
//    glowColor:[UIColor colorWithRed:255/255.0 green:186/255.0 blue:0
//    alpha:0.800]];
//    [items addObject:menuitem];
//
//    //    menuitem=[MenuItem itemWithTitle:@"视频" iconName:@"item_video"
//    glowColor:[UIColor colorWithRed:255/255.0 green:123/255.0 blue:123/255.0
//    alpha:0.800]];
//    //    [items addObject:menuitem];
//
//    menuitem=[MenuItem itemWithTitle:@"批量导入" iconName:@"item_gallery"
//    glowColor:[UIColor colorWithRed:126/255.0 green:203/255.0 blue:64/255.0
//    alpha:0.800]];
//    [items addObject:menuitem];
//
//    if (!_popMenu) {
//        _popMenu = [[PopMenu alloc] initWithFrame:self.view.bounds
//        items:items];
//        _popMenu.menuAnimationType = kPopMenuAnimationTypeNetEase;
//    }
//    if (_popMenu.isShowed) {
//        return;
//    }
//
//    //选取
//    WS(weakSelf)
//    _popMenu.didSelectedItemCompletion = ^(MenuItem *selectedItem) {
//
//        NSLog(@"%@",selectedItem.title);
//
//        SendToViewController *sendVcl=[weakSelf.storyboard
//        instantiateViewControllerWithIdentifier:@"SendToVC"];
//
//        if (selectedItem.index == 0 )
//            sendVcl.itemType = UploadItemTypePhoto;
//        else if ( selectedItem.index == 1 )
//            sendVcl.itemType = UploadItemTypeAll;
//        else
//            sendVcl.itemType = UploadItemTypeVideo;
//
//        [weakSelf.navigationController pushViewController:sendVcl
//        animated:YES];
//
//    };
//
//    //    [_popMenu showMenuAtView:self.view];
//
//    [_popMenu showMenuAtView:self.view
//    startPoint:CGPointMake(CGRectGetWidth(self.view.bounds) ,
//    CGRectGetHeight(self.view.bounds)) endPoint:CGPointMake(60,
//    CGRectGetHeight(self.view.bounds))];
//
//}

- (void)showPopMenu {
  if (_popMenu.isShowed) {
    [_popMenu dismissMenu];
    return;
  }
  NSMutableArray *items = [NSMutableArray array];
  MenuItem *menuItem = [MenuItem itemWithTitle:@"照片" iconName:@"item_"
                                                                  @"photo"];
  [items addObject:menuItem];

  //        menuItem = [MenuItem itemWithTitle:@"视频" iconName:@"item_video"];
  //        [items addObject:menuItem];

  menuItem = [MenuItem itemWithTitle:@"批量导入" iconName:@"item_gallery"];
  [items addObject:menuItem];

  CGRect frame = self.view.frame;
  frame.origin.y -= 64;
  self.popMenu = [[PopMenu alloc] initWithFrame:frame items:items];
  self.popMenu.perRowItemCount = 2;
  WS(weakSelf)

  _popMenu.didSelectedItemCompletion = ^(MenuItem *selectedItem) {
    SendToViewController *sendVcl = [weakSelf.storyboard
        instantiateViewControllerWithIdentifier:@"SendToVC"];
    switch (selectedItem.index) {
    case 0: {
      sendVcl.itemType = UploadItemTypePhoto;
    } break;
    //                case 1: {
    //                    //UIStoryboard *sb = [UIStoryboard
    //                    storyboardWithName:@"RootTabBar" bundle:nil];
    //                    //GiftViewController *vc = [sb
    //                    instantiateViewControllerWithIdentifier:@"GiftViewController"];
    //                    //[(UINavigationController
    //                    *)weakSelf.selectedViewController
    //                    pushViewController:vc animated:YES];
    //
    //                }
    //                    break;
    case 1: {
      sendVcl.itemType = UploadItemTypeAll;
    } break;

    default:
      break;
    }
    [weakSelf.navigationController pushViewController:sendVcl animated:YES];
  };
  self.popMenu.menuAnimationType = kPopMenuAnimationTypeSina;

  [_popMenu showMenuAtView:self.view];
}

- (void)editDynamicWithMorePhoto {
  SendToViewController *vc =
      [self.storyboard instantiateViewControllerWithIdentifier:@"SendToVC"];
  vc.itemType = UploadItemTypeAll;
  [self.navigationController pushViewController:vc animated:YES];
}

//上方选择按钮
- (IBAction)selsctBtnClick:(UIButton *)sender {

  for (int i = 0; i < 3; i++) {
    UIButton *btn = (UIButton *)[self.view viewWithTag:10 + i];
    btn.selected = NO;
    [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
  }

  sender.selected = YES;
  self.currentBtn = sender;
  [UIView animateWithDuration:0.15
                   animations:^{

                     [sender.titleLabel setFont:[UIFont systemFontOfSize:17]];
                   }];

  [self popRedLine];
  //自动滑动下面的pageVcl
  [self.dynamicPageVcl MovetoPageOfIndex:sender.tag - 10];
}
- (void)popRedLine {

  CGRect frame = _redLineImageView.frame;
  frame.origin.x = _currentBtn.frame.origin.x;

  [UIView animateWithDuration:0.3
      delay:0
      usingSpringWithDamping:0.9
      initialSpringVelocity:0.7
      options:UIViewAnimationOptionCurveEaseOut
      animations:^{

        self.redLineImageView.frame = frame;
      }
      completion:^(BOOL finished) {
        nil;
      }];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  self.dynamicPageVcl =
      (DynamicPageViewController *)segue.destinationViewController;

  // pageVcl传值改变选定按钮
  WS(weakSelf)
  self.dynamicPageVcl.block = ^(NSInteger index) {
    for (int i = 0; i < 3; i++) {
      UIButton *btn = (UIButton *)[weakSelf.view viewWithTag:10 + i];
      btn.selected = NO;
      [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    }

    UIButton *button = (UIButton *)[weakSelf.view viewWithTag:10 + index];
    button.selected = YES;
    [UIView animateWithDuration:0
                     animations:^{

                       [button.titleLabel setFont:[UIFont systemFontOfSize:17]];
                     }];
    weakSelf.currentBtn = button;

    [weakSelf popRedLine];
  };
}

@end
