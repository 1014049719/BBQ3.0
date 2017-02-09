//
//  CardTableViewController.m
//  BBQ
//
//  Created by anymuse on 15/7/22.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "CardTableViewController.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import "ChoosePhotoAmountViewController.h"
#import "CardUpCell.h"
#import "CardMiddleCell.h"
#import "CardBottomCell.h"
#import "BuyCardView.h"
#import "OrderDetailViewController.h"
#import "HelpViewController.h"

#import "AppMacro.h"

#import "NotificationMacro.h"
#import "CommonAll.h"
#import <Masonry.h>
#import "CardPopTableViewController.h"
#import "helpDetailViewController.h"

@interface CardTableViewController ()

@property(weak, nonatomic) IBOutlet NSLayoutConstraint *horizontalSpace1;
@property(weak, nonatomic) IBOutlet NSLayoutConstraint *horizontalSpace2;
@property(weak, nonatomic) IBOutlet NSLayoutConstraint *horizontalSpace3;

@property(weak, nonatomic) IBOutlet UILabel *textLabel;

@property(strong, nonatomic) IBOutletCollection(NSLayoutConstraint)
    NSArray *itemSpace;
@property(weak, nonatomic) IBOutlet NSLayoutConstraint *itemWidth;
@property(weak, nonatomic) IBOutlet UIView *topBgView;

@property(weak, nonatomic) IBOutlet NSLayoutConstraint *leftLineSpace;
@property(weak, nonatomic) IBOutlet NSLayoutConstraint *rightLineSpace;
@property(strong, nonatomic) IBOutletCollection(NSLayoutConstraint)
    NSArray *separateLineSpace;
//购买按钮
@property(weak, nonatomic) IBOutlet UIButton *buyButton;
@property(weak, nonatomic) IBOutlet UIButton *buyButton1;

@property(weak, nonatomic) IBOutlet UIView *bottomView;

@property(strong, nonatomic) UIButton *lastButton;

@property(assign, nonatomic) NSInteger currentPhotoChoice;
//照片数量
@property(weak, nonatomic) IBOutlet UILabel *currentPhotoChoiceLabel;

@property(assign, nonatomic) NSInteger currentPrice;
//购买浮窗
@property(strong, nonatomic) BuyCardView *buyCardView;

 //网络接口

@property(nonatomic, assign) int opening; //是否开通亲子卡。
@property(nonatomic, strong) NSDictionary *dicQinzidata; //亲子包数据
//套餐数据
@property(nonatomic, strong) NSArray *tcdata;
@property(nonatomic, strong) NSArray *baobaoqzk;
@property(nonatomic, assign) int qzkbz; //亲子卡标志（1是有）

//介绍内容数组
@property(nonatomic, strong) NSArray *qzktxtArr;

@property(nonatomic, assign) NSInteger curTcdataNo; //选中的套餐序号

//@property (nonatomic, assign) NSInteger curPricedataNo; //选中的照片序号
@property(nonatomic, assign) float totalPrice; //总价格

@property(nonatomic, strong) NSString *orderid; //购买相关数据
@property(nonatomic, strong) NSDictionary *charge;
@property(nonatomic, strong) NSNumber *ordertime;
@property(nonatomic, strong) NSNumber *orderprice;

//成长书按钮
@property(weak, nonatomic) IBOutlet UIButton *chengzhangshuBtn;

//购买者名称
@property(weak, nonatomic) IBOutlet UILabel *lbBuyerName;
//已成功开通并使用亲子体验卡
//@property (weak, nonatomic) IBOutlet UILabel *lbQzkDesc;
//购买者头像
@property(weak, nonatomic) IBOutlet UIImageView *ivAvatar;
//可使用日期范围
@property(weak, nonatomic) IBOutlet UILabel *lbDateRange;

//已记录成长瞬间数量
@property(weak, nonatomic) IBOutlet UILabel *countMomentLabel;
//已拍摄照片数量
@property(weak, nonatomic) IBOutlet UILabel *countPhotoLabel;
//已消耗乐豆
@property(weak, nonatomic) IBOutlet UILabel *countBeanLabel;
//已使用云存储
@property(weak, nonatomic) IBOutlet UILabel *countCloudLabel;
//套餐包含云存储容量
@property(weak, nonatomic) IBOutlet UILabel *includeCloudLabel;
//套餐包含乐豆数量
@property(weak, nonatomic) IBOutlet UILabel *includeBeanLabel;
//总价
@property(weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property(weak, nonatomic) IBOutlet UILabel *totalPriceLabel1;

//有效期
@property(weak, nonatomic) IBOutlet UILabel *howManyMonthLabel;
//折扣信息
@property(weak, nonatomic) IBOutlet UILabel *discountLabel;

//平装版按钮
@property(weak, nonatomic) IBOutlet UIButton *czspzBtn;
//成长书图片
@property(weak, nonatomic) IBOutlet UIImageView *czsImageview;

//刷新页面计数值
@property(nonatomic, assign) int nRefreshPageCount;
//本页面是否是当前页面
@property(nonatomic, assign) BOOL isCurrentPage;

//幼儿园是否开通服务View
@property(weak, nonatomic) IBOutlet UIView *openingView;
@property(weak, nonatomic) IBOutlet UIView *openingView1;

//已选择label
@property(weak, nonatomic) IBOutlet UILabel *selectLabel;
@property(weak, nonatomic) IBOutlet UILabel *selectLabel1;

@end

static NSInteger const kButtonBaseTag = 10;
@implementation CardTableViewController {

  //透明背景
  UIView *alphaView;
  //加介绍图Tbvcl
  CardPopTableViewController *CardPopTbvcl;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [self configureView];

  self.chengzhangshuBtn.selected = YES;
  self.selectLabel.text = @"已选择:亲子服务+成长书";
  self.selectLabel1.text = @"已选择:成长书";

  self.openingView.hidden = YES;
  self.openingView1.hidden = YES;

  self.czspzBtn.selected = YES;
  self.lastButton = _czspzBtn;

  //加载数据，刷新页面
  [self loadViewConent];

  //注册消息
  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(updateQzk:)
             name:NOTIFICATION_Update_BuyResult
           object:nil];
  //需要刷新页面
  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(needToRefreshEntireData)
             name:kSetNeedsRefreshEntireDataNotification
           object:nil];
}

//每次进入设定默认值
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.chengzhangshuBtn.selected = YES;
  self.selectLabel.text = @"已选择:亲子服务+成长书";
  self.selectLabel1.text = @"已选择:成长书";

  UIButton *btn_pz = (UIButton *)[self.view viewWithTag:10];
  btn_pz.enabled = YES;
  btn_pz.selected = YES;
  self.lastButton = btn_pz;
  UIButton *btn_jz = (UIButton *)[self.view viewWithTag:11];
  btn_jz.enabled = YES;
  btn_jz.selected = NO;
  //改变显示数据
  self.curTcdataNo = 0;
  [self changeQzkSelect];
  [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];

  self.isCurrentPage = YES;

//  //判断是否需要刷新
//  if (self.nRefreshPageCount != [_GLOBAL getRefreshPageCount]) {
//    self.nRefreshPageCount = [_GLOBAL getRefreshPageCount];
//    [self loadViewConent];
//  }
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];

  self.isCurrentPage = NO;
}

- (void)needToRefreshEntireData {
  //是当前页面才刷新
  if (self.isCurrentPage)
    [self loadViewConent];
}

- (void)loadViewConent {
  //设置家长头像、宝宝名称、亲属关系
  [self setQzkInfo];
  //取数据
  [self getQzk:TheCurBaoBao.uid.stringValue];
}

// cell高度
- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {

  if (indexPath.row == 0) {

    NSLog(@".....................%d", _qzkbz);
    if (_qzkbz == 1) {

      return 216;
    } else {

      return 0;
    }

  } else if (indexPath.row == 1) {

    return 360;
  } else if (indexPath.row == 2) {

    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"rlflag"] == YES) {

      return 0;
    } else {

      return 43;
    }
  } else if (indexPath.row == 4) {
    //        BOOL flag = [[NSUserDefaults standardUserDefaults]
    //        boolForKey:@"rlflag"];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"rlflag"] == YES) {

      return 75;
    } else {

      return 0;
    }
  }
  if ([[NSUserDefaults standardUserDefaults] boolForKey:@"rlflag"] == YES) {

    return 0;
  } else {

    return 318;
  }
}

- (void)updateViewConstraints {
  [super updateViewConstraints];

  CGFloat width = [UIScreen mainScreen].bounds.size.width - 90 - 140;

  self.horizontalSpace1.constant = width / 3;
  self.horizontalSpace2.constant = width / 3;
  self.horizontalSpace3.constant = width / 3;

  [super updateViewConstraints];
}

//更新亲子卡
- (void)updateQzk:(NSNotification *)note {
  [self getQzk:TheCurBaoBao.uid.stringValue];
}

//成长书套餐按钮
- (IBAction)chengzhangshuBtnClick:(UIButton *)sender {

  //    int include_czs = pickJsonIntValue(self.dicQinzidata, @"include_czs");
  //    if ( include_czs )   {
  //        sender.selected = YES;
  //        return;
  //    }

  if (sender.selected == YES) {
    sender.selected = NO;
    self.selectLabel.text = @"已选择:亲子服务";
    self.selectLabel1.text = @"已选择:";
    //改变显示数据
    self.curTcdataNo = 2;
    [self changeQzkSelect];

    UIButton *btn_pz = (UIButton *)[self.view viewWithTag:10];
    btn_pz.enabled = NO;
    UIButton *btn_jz = (UIButton *)[self.view viewWithTag:11];
    btn_jz.enabled = NO;

  } else {
    sender.selected = YES;
    self.selectLabel.text = @"已选择:亲子服务+成长书";
    self.selectLabel1.text = @"已选择:成长书";

    //改变显示数据
    self.curTcdataNo =
        (self.lastButton.tag - kButtonBaseTag) % [self.tcdata count];
    [self changeQzkSelect];

    UIButton *btn_pz = (UIButton *)[self.view viewWithTag:10];
    btn_pz.enabled = YES;
    UIButton *btn_jz = (UIButton *)[self.view viewWithTag:11];
    btn_jz.enabled = YES;
  }
}

//选择成长书类型
- (IBAction)didMakeAChoice:(UIButton *)button {

  if (self.opening == 0) {
    [SVProgressHUD showErrorWithStatus:@"您"
                   @"宝宝的幼儿园还未开通成长书，暂时不能开通。"];
    return;
  }

  //    if (self.lastButton != button) {
  //        if (!self.lastButton) {
  //            self.lastButton = button;
  //            return;
  //        }
  //        self.lastButton.selected = NO;
  //        self.lastButton = button;
  //    }
  for (int i = 0; i < 2; i++) {
    UIButton *btn = (UIButton *)[self.view viewWithTag:i + 10];
    btn.selected = NO;
  }

  button.selected = YES;
  self.lastButton = button;
  self.curTcdataNo = (button.tag - kButtonBaseTag) % [self.tcdata count];
  [self changeQzkSelect];

  switch (button.tag) {
  case 10: {

    _czsImageview.image = [UIImage imageNamed:@"czs_pz"];
  } break;
  case 11: {

    _czsImageview.image = [UIImage imageNamed:@"czs_jz"];

  } break;
  default:
    break;
  }
}

//成长书 了解更多 按钮
- (IBAction)aboutMoreBtnClick:(id)sender {

  helpDetailViewController *detailVct =
      [self.storyboard instantiateViewControllerWithIdentifier:@"detailVct"];

  switch (self.czspzBtn.selected) {
  case YES:

    detailVct.urlStr = @"bbq.php?mod=help&ac=helpinfo&aid=5358";
    break;
  case NO:

    detailVct.urlStr = @"bbq.php?mod=help&ac=helpinfo&aid=5323";
    break;

  default:
    break;
  }
  NSLog(@"%@", detailVct.urlStr);
  [self.navigationController pushViewController:detailVct animated:YES];
}

//设置家长头像、宝宝名称、亲属关系
- (void)setQzkInfo {
  NSString *info;
  // if ( TheCurBaoBao.gxid > 0 )  {
  //    info = [NSString
  //    stringWithFormat:@"%@%@",TheCurBaoBao.sNickname,[TJYEXLoginUserInfo
  //    relationshipLabelText:TheCurBaoBao.gxid gxname:TheCurBaoBao.gxname]];
  //}
  // else {
  info = [NSString stringWithFormat:@"%@", TheCurBaoBao.realname];
  //}
  self.lbBuyerName.text = info;
    [self.ivAvatar setImageWithURL:[NSURL URLWithString:TheCurBaoBao.avartar] placeholder:Placeholder_avatar];
}

- (void)configureView {
  CGFloat width =
      (CGRectGetWidth(self.tableView.frame) - 4 * self.itemWidth.constant) /
      5.0;
  for (NSLayoutConstraint *constraint in self.itemSpace) {
    constraint.constant = width;
  }

  self.topBgView.layer.masksToBounds = YES;
  self.topBgView.layer.cornerRadius = 5;
  self.bottomView.layer.masksToBounds = YES;
  self.bottomView.layer.cornerRadius = 5;
  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  self.view.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];

  self.leftLineSpace.constant = (kScreenWidth - 32) / 3.0;
  self.rightLineSpace.constant = (kScreenWidth - 32) / 3.0;
  for (NSLayoutConstraint *constraint in self.separateLineSpace) {
    constraint.constant = self.leftLineSpace.constant / 2.0 - 17.5;
  }
  self.buyButton.layer.masksToBounds = YES;
  self.buyButton1.layer.masksToBounds = YES;
  self.buyButton.layer.cornerRadius =
      CGRectGetHeight(self.buyButton.frame) / 2.0;
  self.buyButton1.layer.masksToBounds = YES;
  self.buyButton1.layer.cornerRadius =
      CGRectGetHeight(self.buyButton1.frame) / 2.0;
  [self updateViewConstraints];
}

///点击帮助按钮
- (IBAction)didClickHelp:(id)sender {

  UIStoryboard *storyBoard =
      [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
  HelpViewController *sendVcl =
      [storyBoard instantiateViewControllerWithIdentifier:@"HelpViewVC"];
  [self.navigationController pushViewController:sendVcl animated:YES];
}

///亲子卡内容上面的的按钮
- (IBAction)didClickQzkDesc:(id)sender {

  NSLog(@"弹出浮层。。。。");
  NSLog(@"......%f", self.view.bounds.origin.y);

  //加半透明背景
  alphaView = [[UIView alloc]
      initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,
                               self.tableView.contentSize.height)];
  alphaView.backgroundColor = [UIColor blackColor];
  alphaView.alpha = 0.4;
  [self.view addSubview:alphaView];
  self.tableView.scrollEnabled = NO;

  //加手势
  UITapGestureRecognizer *tap =
      [[UITapGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(dealTap)];
  [alphaView addGestureRecognizer:tap];

  //加介绍图浮层
  CardPopTbvcl =
      [self.storyboard instantiateViewControllerWithIdentifier:@"CardPopTbvcl"];
  //传递数据源
  if (self.qzktxtArr.count > 0) {
    CardPopTbvcl.DataSourceArr = self.qzktxtArr;
  }
  [self.view addSubview:CardPopTbvcl.view];
  [CardPopTbvcl.view mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.view).offset(self.tableView.contentOffset.y + 30);
    make.height.mas_equalTo(self.tableView.bounds.size.height - 60);
    make.width.mas_equalTo(kScreenWidth - 40);
    make.centerX.equalTo(self.view);

  }];
  CardPopTbvcl.view.layer.cornerRadius = 7;
  //手势
  UITapGestureRecognizer *tap1 =
      [[UITapGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(dealTap1)];
  [CardPopTbvcl.view addGestureRecognizer:tap1];
}

//单击手势
- (void)dealTap {

  alphaView.hidden = YES;
  CardPopTbvcl.view.hidden = YES;
  self.tableView.scrollEnabled = YES;
}
- (void)dealTap1 {

  alphaView.hidden = YES;
  CardPopTbvcl.view.hidden = YES;
  self.tableView.scrollEnabled = YES;
}

#pragma mark - 点击购买按钮
- (IBAction)didClickBuyButton:(id)sender {

  if (self.opening == 0) {
    [SVProgressHUD showErrorWithStatus:@"您"
                   @"宝宝的幼儿园还未开通成长书，不能购买。"];
    return;
  }

  //当前购买有亲子卡
  if (self.qzkbz == 1) {
    [SVProgressHUD showErrorWithStatus:@"您宝宝已经是会员了,不需要再次购买。"];
    return;
  }

  self.buyCardView = [[BuyCardView alloc] init];
  [self.buyCardView showBuyCardViewWithPrice:self.totalPrice];
  [self.buyCardView.confirmButton addTarget:self
                                     action:@selector(confirmToPay)
                           forControlEvents:UIControlEventTouchUpInside];
}

- (void)confirmToPay {

  if (self.buyCardView.payWay == ChosedNull) {
    [SVProgressHUD showErrorWithStatus:@"请先选择一种支付方式"];
    return;
  }

  // NSLog(@"支付方式%ld", self.buyCardView.payWay);
  //[self.buyCardView hideSelf];
  //[self.rootVC performSegueWithIdentifier:@"CheckPayInfoSegue" sender:self];

  [self buyQzk:TheCurBaoBao.uid.stringValue
         qzkid:[self.dicQinzidata objectForKey:@"qzkid"]
          tcid:[[self.tcdata objectAtIndex:self.curTcdataNo]
                   objectForKey:@"tcid"]
       priceid:[NSNumber numberWithInt:0]
       paytype:(self.buyCardView.payWay == ChosedPayWayAlipay ? @1 : @2)];

  ////priceid:[[self.pricedata objectAtIndex:self.curPricedataNo]
  ///objectForKey:@"priceid"]
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if (self.opening == 0) {
    //[SVProgressHUD showErrorWithStatus:@"您宝宝的幼儿园还未开通成长书，暂时不能开通。"];
    return;
  }

  //选择照片
  if ([segue.identifier isEqualToString:@"ChoosePhotoAmountSegue"]) {
    /*
    ChoosePhotoAmountViewController *vc = segue.destinationViewController;
    vc.currentChoice = self.curPricedataNo;
    vc.pricedata = self.pricedata;
    vc.block = ^(NSInteger multiple) {
        self.curPricedataNo = multiple%[self.pricedata count];
        //更新价格等
        [self changeQzkSelect];

    };
    */
    return;
  }
}

//- (void)updateViewConstraints {
//    CGFloat width = (CGRectGetWidth(self.tableView.frame) - 4 *
//    self.itemWidth.constant) / 5.0;
//    for (NSLayoutConstraint *constraint in self.itemSpace) {
//        constraint.constant = width;
//    }
//    [super updateViewConstraints];
//}

//------------------------------------------------------
//用服务端提取数据后，初始化相关内容
- (void)DispQinziDesc:(NSArray *)baobaoqzk qzkqk:(NSDictionary *)qzkqk {
  //当前未购买有亲子卡
  if (self.qzkbz == 0) {
    //        [self procNoBugQzk];
    //        return;
  }

  //显示固定的描述内容
  if (qzkqk) {
    self.countMomentLabel.text = [NSString
        stringWithFormat:@"%d条动态", pickJsonIntValue(qzkqk, @"dynanum")];
    self.countPhotoLabel.text = [NSString
        stringWithFormat:@"%d张照片", pickJsonIntValue(qzkqk, @"photonum")];
    self.countBeanLabel.text = [NSString
        stringWithFormat:@"%d个乐豆", pickJsonIntValue(qzkqk, @"ledounum")];
    self.countCloudLabel.text = [NSString
        stringWithFormat:@"%dM空间", pickJsonIntValue(qzkqk, @"storagesize")];

    ////可使用日期范围
    int starttime = pickJsonIntValue(qzkqk, @"startime");
    int endtime = pickJsonIntValue(qzkqk, @"endtime");

    self.lbDateRange.text =
        [NSString stringWithFormat:@"可使用日期%@至%@",
                                   [CommonFunc getDateString:starttime],
                                   [CommonFunc getDateString:endtime]];
  }
}

//用户选择套餐或照片后，修改相关数据
- (void)changeQzkSelect {
  NSDictionary *curTcdata = [self.tcdata objectAtIndex:self.curTcdataNo];
  // NSDictionary *curPricedata = [self.pricedata
  // objectAtIndex:self.curPricedataNo];

  // int tcmonthnum = pickJsonIntValue(curTcdata, @"tcmonthnum");
  int ledounum = pickJsonIntValue(curTcdata, @"ledounum");
  // int tczk = pickJsonIntValue(curTcdata, @"tczk");
  float price = pickJsonFloatValue(curTcdata, @"price", 0.0);
  int photonum = pickJsonIntValue(self.dicQinzidata, @"photonum");

  //修改总价格
  self.totalPrice = price; // price * tcmonthnum * tczk / 100;
  self.totalPriceLabel.text =
      [NSString stringWithFormat:@"¥%.0f", self.totalPrice];
  self.totalPriceLabel1.text =
      [NSString stringWithFormat:@"¥%.0f", self.totalPrice];
  self.howManyMonthLabel.text =
      @""; //[NSString stringWithFormat:@"%d个月",tcmonthnum];
  // if ( tczk < 100 )
  //    self.discountLabel.text = [NSString
  //    stringWithFormat:@"%.1f折",(float)tczk/100.0];
  // else
  self.discountLabel.text = @"";

  //修改乐豆数
  self.includeBeanLabel.text =
      [NSString stringWithFormat:@"赠送%d乐豆", ledounum];
  //修改照片数
  self.currentPhotoChoiceLabel.text =
      [NSString stringWithFormat:@"%d张/学期", photonum];
}

//学校没有开通亲子卡
//-(void)procNoQzk
//{
//
//    self.lbQzkDesc.text = @"您宝宝的学校暂未开通会员业务";
//
//}
//
////宝宝没有购买亲子卡
//-(void)procNoBugQzk
//{
//    self.lbQzkDesc.text = @"暂未购买会员服务";
//}

//详情界面
- (void)dispDetailController {
  UIStoryboard *sb = [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
  OrderDetailViewController *vc =
      [sb instantiateViewControllerWithIdentifier:@"OrderDetailViewController"];

  vc.strName =
      [[self.tcdata objectAtIndex:self.curTcdataNo] objectForKey:@"tcname"];
  // vc.strDesc = [NSString stringWithFormat:@"%d个月,每月%d张照片",
  //              [[[self.tcdata objectAtIndex:self.curTcdataNo]
  //              objectForKey:@"tcmonthnum"] intValue],
  //              [[[self.pricedata objectAtIndex:self.curPricedataNo]
  //              objectForKey:@"photonum"] intValue]
  //              ];
  vc.strDesc = [NSString
      stringWithFormat:@"每学期%d张照片",
                       [[self.dicQinzidata objectForKey:@"photonum"] intValue]];
  vc.strOrdrer = self.orderid;
  vc.strOrderTime = [CommonFunc getCurrentTime];
  vc.strOrderMoney =
      [NSString stringWithFormat:@"%.2f元", [self.orderprice floatValue]];
  vc.strOrderUser = TheCurUser.member.nickname;
  vc.charge = self.charge;
  vc.buytype = BUY_QZK;

  //可以定义回调

  [self.navigationController pushViewController:vc animated:YES];
}

//查询亲子卡
- (void)getQzk:(NSString *)baobaouid {
  NSDictionary *params = @{ @"baobaouid" : baobaouid };

  //    [self PostMsg:URL_GET_QZK data:params ResponseTarget:self
  //    ResponseSelector:@selector(syncCallback_PostMsg:)];

  //    return;
  //    [SVProgressHUD showWithStatus:@"请稍候..."];
  [BBQHTTPRequest
       queryWithType:BBQHTTPRequestTypeGetQZK
               param:params
      successHandler:^(AFHTTPRequestOperation *operation,
                       NSDictionary *responseObject, bool apiSuccess) {
        dispatch_async(dispatch_get_main_queue(), ^{
          //            [SVProgressHUD dismiss];
          int cmdcode = pickJsonIntValue(responseObject, @"cmdcode");
          if (21 == cmdcode) { //获取亲子包
            NSDictionary *dicData = [responseObject objectForKey:@"data"];
            if (dicData) {
              self.opening = pickJsonIntValue(dicData, @"opening");
              if (0 == self.opening) {
                //没开通亲子卡，显示亲子卡未开通页面；
                self.openingView.hidden = NO;
                self.openingView1.hidden = NO;
              } else {
                self.openingView.hidden = YES;
                self.openingView1.hidden = YES;
              }

              self.qzkbz = pickJsonIntValue(dicData, @"qzkbz");
              self.dicQinzidata = [dicData objectForKey:@"qinzidata"];
              self.qzktxtArr = [self.dicQinzidata objectForKey:@"qzktxt"];
              self.tcdata = [self.dicQinzidata objectForKey:@"tcdata"];

              NSLog(@"套餐数据内容。。。。。%@", self.tcdata);

              // self.pricedata = [self.dicQinzidata objectForKey:@"pricedata"];

              self.baobaoqzk = [dicData objectForKey:@"baobaoqzk"];
              NSDictionary *qzkqk = [dicData objectForKey:@"qzkqk"];

              self.curTcdataNo = 0;
              // self.curPricedataNo = 0;

              [self DispQinziDesc:self.baobaoqzk qzkqk:qzkqk];
              [self changeQzkSelect];

              [self.tableView reloadData];
            }
          }
        });
      } errorHandler:nil
      failureHandler:nil];
}

//购买亲子卡
- (void)buyQzk:(NSString *)baobaouid
         qzkid:(NSNumber *)qzkid
          tcid:(NSNumber *)tcid
       priceid:(NSNumber *)priceid
       paytype:(NSNumber *)paytype {
  NSDictionary *params = @{
    @"baobaouid" : baobaouid,
    @"qzkid" : qzkid,
    @"tcid" : tcid,
    @"priceid" : priceid,
    @"paytype" : paytype,
  };

  [SVProgressHUD showWithStatus:@"请稍候..."];
  [BBQHTTPRequest
       queryWithType:BBQHTTPRequestTypeBuyQZK
               param:params
      successHandler:^(AFHTTPRequestOperation *operation,
                       NSDictionary *responseObject, bool apiSuccess) {
        [SVProgressHUD dismiss];
        dispatch_async(dispatch_get_main_queue(), ^{

          NSDictionary *dicData = [responseObject objectForKey:@"data"];

          if (dicData) {
            self.orderid = pickJsonStrValue(dicData, @"orderid");
            self.charge = [dicData objectForKey:@"charge"];
            self.ordertime = [NSNumber
                numberWithInteger:[[dicData
                                      objectForKey:@"ordertime"] integerValue]];
            self.orderprice = [NSNumber
                numberWithFloat:[[dicData objectForKey:@"price"] floatValue]];

            //调用ping＋＋
            //[self jumpToPingpp];

            // NSLog(@"支付方式%ld", self.buyCardView.payWay);
            [self.buyCardView hideSelf];
            //[self.rootVC performSegueWithIdentifier:@"CheckPayInfoSegue"
            //sender:self];
            [self dispDetailController];
          }
        });
      } errorHandler:nil
      failureHandler:nil];
}

@end
