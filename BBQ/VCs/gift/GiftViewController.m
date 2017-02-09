//
//  GiftViewController.m
//  BBQ
//
//  Created by mwt on 15/7/29.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "GiftViewController.h"

#import "Dynamic.h"
#import "GiftCell.h"
#import "LeDouPayViewController.h"
#import "LoadingView.h"
#import "VirtualGiftModel.h"
#import "BBQSendGiftApi.h"

@interface GiftViewController () <
UICollectionViewDataSource, UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate,
UIAlertViewDelegate, UITextFieldDelegate>

@property(weak, nonatomic) IBOutlet UICollectionView *giftview;
@property(weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowlayoutView;

@property(weak, nonatomic) IBOutlet UILabel *lbgiftnum;
@property(weak, nonatomic) IBOutlet UILabel *lbledounum;
@property(weak, nonatomic) IBOutlet UIButton *giveButton;
@property(strong, nonatomic) NSMutableArray *arrGift;
@property (copy, nonatomic) NSArray *giftItems;
@property(assign, nonatomic) int selectno;

//弹窗
@property(weak, nonatomic) IBOutlet UIView *PopView;
//半透明背景
@property(strong, nonatomic) UIView *alphaView;
@property(weak, nonatomic) IBOutlet UIImageView *currentImageView;
@property(weak, nonatomic) IBOutlet UILabel *nameLabel;
@property(weak, nonatomic) IBOutlet UILabel *numLabel;
//选择数量
@property(weak, nonatomic) IBOutlet UITextField *selectNumTextField;
//弹窗布局
@property(weak, nonatomic) IBOutlet NSLayoutConstraint *LayoutCenterY;

//弹出选择数量背景
@property(weak, nonatomic) IBOutlet UIView *selectNumView;

//数量
@property(assign, nonatomic) int count;

@property(strong, nonatomic) LoadingView *loadingView;

@end

@implementation GiftViewController {
    //中心点
    CGPoint rectPoint;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.edgesForExtendedLayout=UIRectEdgeNone;
    
    if (!_guid && _dynamic) {
        _guid = _dynamic.guid;
    }
    self.loadingView =
    [[NSBundle mainBundle] loadNibNamed:@"LoadingView" owner:self options:nil]
    .firstObject;
    [self.view addSubview:self.loadingView];
    [self.view bringSubviewToFront:self.loadingView];
    WS(weakSelf)
    self.loadingView.buttonBlock = ^{
        [weakSelf getgift];
    };
    
    self.giveButton.layer.masksToBounds = YES;
    self.giftview.delegate = self;
    self.giftview.dataSource = self;
    self.selectno = -1;
    self.arrGift = [NSMutableArray array];
    self.count = 1;
    self.selectNumTextField.delegate = self;
    _selectNumTextField.text = [NSString stringWithFormat:@"%d", self.count];
    self.PopView.hidden = YES;
    self.selectNumView.hidden = YES;
    
    CGFloat itemWidth =
    ([UIScreen mainScreen].bounds.size.width - 32 - 2 * 2 - 10) / 2.0;
    self.flowlayoutView.itemSize = CGSizeMake(itemWidth, itemWidth);
    self.flowlayoutView.minimumLineSpacing = 13;
    
    //输入框监听值改变
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(changeCount)
     name:UITextFieldTextDidChangeNotification
     object:self.selectNumTextField];
}

- (void)changeCount {
    self.count = [self.selectNumTextField.text intValue];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.giveButton.layer.cornerRadius =
    CGRectGetHeight(self.giveButton.frame) / 2.0;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getgift];
}

//赠送
- (IBAction)clickSend:(UIButton *)sender {
    NSString *str;
    if (self.selectno < 0) {
        str = @"请先选择礼物";
        [SVProgressHUD showErrorWithStatus:str];
        return;
    }
    
    if (!self.guid) {
        str = @"动态不存在";
        [SVProgressHUD showErrorWithStatus:str];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"请稍候..."];
    VirtualGiftModel *model = [self.arrGift objectAtIndex:self.selectno];
    Gift *gift = [[Gift alloc] initWithDynamic:_dynamic giftID:model.giftid count:self.selectNumTextField.text.numberValue items:_giftItems];
    BBQSendGiftApi *api = [[BBQSendGiftApi alloc] initWithGift:gift];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [_dynamic addGift:gift];
        NSString *str = @"您的礼物已成功送出，谢谢亲，么么哒~";
        [SVProgressHUD showSuccessWithStatus:str];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [MTA trackCustomKeyValueEvent:kMTAGitfCount props:@{ @"count" : gift.giftcount }];
        });
        dispatch_after(
                       dispatch_time(DISPATCH_TIME_NOW,
                                     (int64_t)(HUD_DURATION(str) * NSEC_PER_SEC)),
                       dispatch_get_main_queue(), ^{
                           [self.navigationController popViewControllerAnimated:YES];
                       });
    } failure:^(YTKBaseRequest *request) {
        ShowApiError
    }];
}

- (IBAction)clickBuyLedou:(UIButton *)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
    LeDouPayViewController *vc =
    [sb instantiateViewControllerWithIdentifier:@"LeDouPayViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

//弹窗数量选择
- (IBAction)selectNumBtnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 10: {
            NSLog(@"10");
            _selectNumTextField.text = @"10";
            self.count = 10;
        } break;
        case 11: {
            NSLog(@"66");
            _selectNumTextField.text = @"66";
            self.count = 66;
        } break;
        case 12: {
            NSLog(@"99");
            _selectNumTextField.text = @"99";
            self.count = 99;
        } break;
        case 13: {
            NSLog(@"188");
            _selectNumTextField.text = @"188";
            self.count = 188;
            
        } break;
        default:
            break;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return self.arrGift.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GiftCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:@"GiftCell"
                                              forIndexPath:indexPath];
    
    VirtualGiftModel *giftdata = [self.arrGift objectAtIndex:indexPath.row];
    
    cell.selectedImg.hidden = NO;
    cell.lbgiftname.text = giftdata.giftname;
    if ([giftdata.ldcount intValue] == 0) {
        cell.lbLedounum.text = @"免费";
    } else {
        cell.lbLedounum.text =
        [NSString stringWithFormat:@"%@ 乐豆", [giftdata.ldcount stringValue]];
    }
    [cell.ivgift setImageWithURL:[NSURL URLWithString:giftdata.imgurl]
                         options:YYWebImageOptionSetImageWithFadeAnimation];
    
    return cell;
}

#pragma mark cell点击代理

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    GiftCell *cell =
    (GiftCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    cell.selectedImg.image = [UIImage imageNamed:@"selected"];
    
    NSLog(@"点击select num = %lu开始弹窗",
          (unsigned long)collectionView.indexPathsForSelectedItems.count);
    
    self.selectno = (int)indexPath.row;
    
    //加载弹窗数据
    VirtualGiftModel *giftdata = [self.arrGift objectAtIndex:indexPath.row];
    [_currentImageView setImageWithURL:[NSURL URLWithString:giftdata.imgurl]
                               options:YYWebImageOptionSetImageWithFadeAnimation];
    _nameLabel.text = giftdata.giftname;
    if ([giftdata.ldcount intValue] == 0) {
        _numLabel.text = @"免费";
    } else {
        _numLabel.text =
        [NSString stringWithFormat:@"%@ 乐豆", [giftdata.ldcount stringValue]];
    }
    //创建popVcl弹窗
    [self creatPopView];
}

- (void)createAlertView {
    UIAlertView *alertView =
    [[UIAlertView alloc] initWithTitle:@"账户余额不足，请先充值"
                               message:nil
                              delegate:self
                     cancelButtonTitle:@"取消"
                     otherButtonTitles:@"充值", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 1: {
            UIStoryboard *sb =
            [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
            LeDouPayViewController *vc =
            [sb instantiateViewControllerWithIdentifier:@"LeDouPayViewController"];
            
            [self.navigationController pushViewController:vc animated:YES];
        } break;
            
        default:
            break;
    }
}

- (void)creatPopView {
    
    _alphaView = [[UIView alloc] initWithFrame:self.view.bounds];
    _alphaView.backgroundColor = [UIColor blackColor];
    _alphaView.alpha = 0.3;
    [self.view addSubview:_alphaView];
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(dealTap)];
    [_alphaView addGestureRecognizer:tap];
    
    CGRect frameNow = _PopView.frame;
    frameNow.origin = CGPointMake(300, -300);
    _PopView.frame = frameNow;
    
    _PopView.hidden = NO;
    [self.view bringSubviewToFront:_PopView];
    UITapGestureRecognizer *tap2 =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(dealTap2)];
    [_PopView addGestureRecognizer:tap2];
    
    [UIView animateWithDuration:0.3
                          delay:0
         usingSpringWithDamping:0.7
          initialSpringVelocity:0.5
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         CGRect rectFrame = _PopView.frame;
                         rectFrame.origin = self.view.frame.origin;
                         
                         _PopView.frame = rectFrame;
                         
                     }
                     completion:^(BOOL finished) {
                         nil;
                     }];
    
    //键盘frame监听
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(dealKeyboardFrameChange:)
     name:UIKeyboardWillChangeFrameNotification
     object:nil];
}
//键盘frame改变
- (void)dealKeyboardFrameChange:(NSNotification *)notifi {
    
    NSDictionary *info = [notifi userInfo];
    CGPoint KeyboardPoint =
    [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].origin;
    [UIView animateWithDuration:0.2
                     animations:^{
                         
                         _LayoutCenterY.constant = kScreenHeight - KeyboardPoint.y;
                     }];
}

- (void)dealTap {
    
    NSLog(@"tap......");
    [_selectNumTextField resignFirstResponder];
    
    _alphaView.hidden = YES;
    _PopView.hidden = YES;
}
- (void)dealTap2 {
    
    NSLog(@"tap2......");
    [_selectNumTextField resignFirstResponder];
    _selectNumView.hidden = YES;
}

//加减按钮事件
- (IBAction)decreaseBtnClick:(id)sender {
    
    if (self.count > 1) {
        
        self.count = [self.selectNumTextField.text intValue];
        self.count--;
        _selectNumTextField.text = [NSString stringWithFormat:@"%d", self.count];
    }
    _selectNumView.hidden = NO;
}
- (IBAction)addBtnClick:(id)sender {
    
    self.count = [self.selectNumTextField.text intValue];
    self.count++;
    _selectNumTextField.text = [NSString stringWithFormat:@"%d", self.count];
    _selectNumView.hidden = NO;
}

- (IBAction)giftNumFieldEditDidEnd:(id)sender {
    int num = [_selectNumTextField.text intValue];
    if (num > 0)
        self.count = num;
    else {
        _selectNumTextField.text = [NSString stringWithFormat:@"%d", self.count];
    }
}

//关闭按钮
- (IBAction)closeBtnClick:(id)sender {
    
    _alphaView.hidden = YES;
    _PopView.hidden = YES;
}

- (void)collectionView:(UICollectionView *)collectionView
didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    GiftCell *cell =
    (GiftCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.selectedImg.image = [UIImage imageNamed:@"unselected"];
}

///获取虚拟礼物
- (void)getgift {
    [BBQHTTPRequest queryWithType:BBQHTTPRequestTypeGiftAndUserInfo
                            param:@{
                                    @"gifttype" : @1
                                    }
                   successHandler:^(AFHTTPRequestOperation *operation,
                                    NSDictionary *responseObject, bool apiSuccess) {
                       [self.arrGift removeAllObjects];
                       self.giftItems = responseObject[@"data"][@"giftdata"];
                       for (NSDictionary *dicGift in responseObject[@"data"][@"giftdata"]) {
                           VirtualGiftModel *model =
                           [[VirtualGiftModel alloc] initWithDic:dicGift];
                           // 只显示免费的礼物
                           if ([model.ldcount intValue] == 0) {
                               [self.arrGift addObject:model];
                           }
                       }
                       NSNumber *ledou = responseObject[@"data"][@"myledou"];
                       dispatch_async_on_main_queue((^{
                           self.lbledounum.text = [NSString
                                                   stringWithFormat:@"%ld", (long)(long)ledou.integerValue];
                           [self.giftview reloadData];
                           [self.loadingView dismiss];
                       }));
                       
                   }
                     errorHandler:^(NSDictionary *responseObject) {
                         if (self.loadingView.isShowing) {
                             self.loadingView.status = BBQLoadingViewStatusError;
                         }
                     }
                   failureHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
                       if (self.loadingView.isShowing) {
                           self.loadingView.status = BBQLoadingViewStatusError;
                       }
                   }];
}

@end
