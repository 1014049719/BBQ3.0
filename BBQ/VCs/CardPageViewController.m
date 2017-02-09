//
//  CardPageViewController.m
//  BBQ
//
//  Created by wth on 15/10/14.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "CardPageViewController.h"
#import "CardPreviewController.h"
#import "ShareView.h"
#import "NoPhotoRemindViewController.h"
#import <UINavigationController+FDFullscreenPopGesture.h>
#import "LoadingView.h"

@interface CardPageViewController () <UIPageViewControllerDelegate,
                                      UIPageViewControllerDataSource>
//背景VCl
@property(strong, nonatomic) UIViewController *backgroundVcl;

// Vcls数组
@property(strong, nonatomic) NSMutableArray *managedVclsArr;

//数据源数组
@property(strong, nonatomic) NSArray *DataArr;

//内容
@property(strong, nonatomic) CardPreviewController *CardPreviewVcl0;

//页码
@property(assign, nonatomic) int intpage;

//判断是否往下翻
@property(assign, nonatomic) BOOL isForward;

//页码label
@property(strong, nonatomic) UILabel *PageLabel;
//手势翻页
@property(strong, nonatomic) UIView *TapView;

//引导页
@property(strong, nonatomic) UIViewController *Lead_CZSVCL;

//转圈提示
@property(strong, nonatomic) LoadingView *loadingView;

@end

@implementation CardPageViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.

  _backgroundVcl = [[UIViewController alloc] init];
  _backgroundVcl.view.backgroundColor = [UIColor whiteColor];
  _backgroundVcl.view.frame = self.view.frame;
  [self setViewControllers:@[ _backgroundVcl ]
                 direction:UIPageViewControllerNavigationDirectionForward
                  animated:NO
                completion:nil];

  //加载数据转圈
  self.loadingView =
      [[NSBundle mainBundle] loadNibNamed:@"LoadingView" owner:self options:nil]
          .firstObject;
  self.loadingView.backgroundColor = [UIColor clearColor];
  [self.backgroundVcl.view addSubview:self.loadingView];

  //    //加点击翻页手势
  //   _TapView=[[UIView alloc]
  //   initWithFrame:CGRectMake(self.view.bounds.size.width/2,80,
  //   self.view.bounds.size.width/2-50, self.view.bounds.size.height)];
  //    _TapView.backgroundColor=[UIColor blackColor];
  ////    TapView.alpha=0.1;
  //    [[UIApplication sharedApplication].keyWindow addSubview:_TapView];

  //    UITapGestureRecognizer *Tap=[[UITapGestureRecognizer alloc]
  //    initWithTarget:self action:@selector(DealTap)];
  //    [_TapView addGestureRecognizer:Tap];

  self.title = @"成长书";

  self.managedVclsArr = [NSMutableArray array];
  self.delegate = self;
  self.dataSource = self;

  //加右侧分享按钮
  UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]
      initWithImage:[UIImage imageNamed:@"fenxiangbaise.png"]
              style:UIBarButtonItemStyleDone
             target:self
             action:@selector(RightBtnClick)];
  //    rightButton.imageInsets=UIEdgeInsetsMake(20, 40, 20, 0);
  self.navigationItem.rightBarButtonItem = rightButton;

  NSLog(@"/...所传数据源数组。。。%lu", (unsigned long)self.DataArr.count);
}

- (void)viewWillDisappear:(BOOL)animated {
    
    _PageLabel.alpha = 0;
    [_PageLabel removeFromSuperview];

    [super viewWillDisappear:animated];
    [[ShareView sharedInstance] dismiss];
    
}

//关闭滑动返回手势
- (BOOL)fd_interactivePopDisabled {
  return YES;
}

//点击移除引导页
- (void)RemovLead_CZSvcl {

  NSLog(@"移除引导页");
  [UIView animateWithDuration:0.2
                   animations:^{

                     self.Lead_CZSVCL.view.alpha = 0;
                   }];
}

//点击翻页
- (void)DealTap {

  NSLog(@"dianjieshoushi...............");

  //        if (self.intpage+1>=self.DataArr.count) {
  //
  //             nil;
  //        }else{
  //
  //            WS(weakSelf)
  //             if (self.viewControllers.firstObject==self.CardPreviewVcl0) {
  //
  //                 [self setViewControllers:@[self.CardPreviewVcl1]
  //                 direction:UIPageViewControllerNavigationDirectionForward
  //                 animated:YES completion:^(BOOL finished) {
  //
  //                     weakSelf.intpage+=1;
  //                     weakSelf.PageLabel.text=[NSString
  //                     stringWithFormat:@"%d/16",self.intpage+1];
  //                     [weakSelf.CardPreviewVcl
  //                     UpLoadWebUrlData:weakSelf.DataArr[weakSelf.intpage][@"viewurl"]];
  //                 }];
  //
  //             }else if
  //             (self.viewControllers.firstObject==self.CardPreviewVcl1) {
  //
  //                 [self setViewControllers:@[self.CardPreviewVcl0]
  //                 direction:UIPageViewControllerNavigationDirectionForward
  //                 animated:YES completion:^(BOOL finished) {
  //
  //                     weakSelf.intpage+=1;
  //                     weakSelf.PageLabel.text=[NSString
  //                     stringWithFormat:@"%d/16",self.intpage+1];
  //                     [weakSelf.CardPreviewVcl
  //                     UpLoadWebUrlData:weakSelf.DataArr[weakSelf.intpage][@"viewurl"]];
  //                 }];
  //             }
  //
  //        }
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  //请求成长书数据
  [self RequestCZSUrl];

  //    判断应用是否为第一次启动
  if (![[NSUserDefaults standardUserDefaults] boolForKey:@"CZS_LeadVcl"]) {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"CZS_LeadVcl"];
    NSLog(@"第一次进入成长书预览");

    // 进入预览引导
    [self CreatCZS_LeadVcl];
  }
}

//创建成长书引导提示
- (void)CreatCZS_LeadVcl {

  //新用户引导提示
  _Lead_CZSVCL = [[UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil]
      instantiateViewControllerWithIdentifier:@"Lead_CZSVCL"];
  //加移除手势
  UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc]
      initWithTarget:self
              action:@selector(RemovLead_CZSvcl)];
  [_Lead_CZSVCL.view addGestureRecognizer:Tap];
  [[UIApplication sharedApplication].keyWindow addSubview:_Lead_CZSVCL.view];
}

//请求成长书URL
- (void)RequestCZSUrl {
  NSString *strUID;
  if (_baobaouid && _baobaouid.length > 0) {
    strUID = _baobaouid;
  } else {
    strUID = TheCurBaoBao.uid;
  }
  NSDictionary *ParamDic = @{ @"baobaouid" : strUID };
  NSLog(@".....宝宝id。。。%@", ParamDic[@"baobaouid"]);

  [BBQHTTPRequest queryWithType:BBQHTTPRequestTypeCZSyulan
      param:ParamDic
      successHandler:^(AFHTTPRequestOperation *operation,
                       NSDictionary *responseObject, bool apiSuccess) {

        //转圈消失
        [self.loadingView dismiss];
        NSLog(@".....请求数据。。。%@", responseObject[@"data"][@"num"]);

        if ([responseObject[@"data"][@"num"] intValue] > 0) {

          //传数据源数组
          self.DataArr = responseObject[@"data"][@"urlarr"];
          //设置PageVcls个数
          [self setPageVcls];
        } else {

          //没有照片提示页面
          [self setNoPhotoRemindVcl];
        }

      }
      errorHandler:^(NSDictionary *responseObject) {

        //转圈消失
        [self.loadingView dismiss];
        NSLog(@"。。。错误结果。。。%@", responseObject[@"msg"]);
      }
      failureHandler:^(AFHTTPRequestOperation *operation, NSError *error) {

        //转圈消失
        [self.loadingView dismiss];
        NSLog(@"。。。网络失败结果。。。%@", error);
      }];
}

- (void)setPageVcls {

  for (int i = 0; i < 3; i++) {

    self.CardPreviewVcl0 =
        [[UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil]
            instantiateViewControllerWithIdentifier:@"CardPreviewVcl"];
    self.CardPreviewVcl0.CZS_URL = self.DataArr[i][@"viewurl"];
    [self.managedVclsArr addObject:self.CardPreviewVcl0];
  }

  self.intpage = 0;

  //默认往下翻页
  self.isForward = YES;

  [self setViewControllers:@[ self.managedVclsArr[self.intpage] ]
                 direction:UIPageViewControllerNavigationDirectionForward
                  animated:NO
                completion:nil];

  //设置页码
  [self setPageLabel];
}

//设置页码
- (void)setPageLabel {

  //底部页码
  _PageLabel = [[UILabel alloc]
      initWithFrame:CGRectMake(self.view.bounds.size.width / 2 - 35,
                               kScreenHeight - 28, 70, 24)];
  _PageLabel.textColor = [UIColor whiteColor];
  _PageLabel.backgroundColor =
      [UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:0.3];
  _PageLabel.text =
      [NSString stringWithFormat:@"%d/%lu", self.intpage + 1,
                                 (unsigned long)self.DataArr.count];
  _PageLabel.textAlignment = NSTextAlignmentCenter;
  _PageLabel.font = [UIFont systemFontOfSize:15];
  _PageLabel.layer.cornerRadius = 11;
  _PageLabel.layer.masksToBounds = YES;
  [[UIApplication sharedApplication].keyWindow addSubview:_PageLabel];
}

// DataSource
- (UIViewController *)pageViewController:
                          (UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController {

  //页数-1
  if (self.intpage <= 0) {

    return nil;
  } else {

    self.isForward = NO;
    if (self.intpage == self.DataArr.count - 1) {

      return self.managedVclsArr[1];
    } else {

      return self.managedVclsArr[0];
    }
  }
}

- (UIViewController *)pageViewController:
                          (UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController {

  //页数+1
  if (self.intpage + 1 >= self.DataArr.count) {

    return nil;
  } else {

    self.isForward = YES;
    if (self.intpage >= 1 || self.intpage == self.DataArr.count - 2) {

      return self.managedVclsArr[2];
    } else {

      return self.managedVclsArr[1];
    }
  }
}

//翻页完成代理
- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:
       (NSArray<UIViewController *> *)previousViewControllers
       transitionCompleted:(BOOL)completed {

  if (completed) {

    if (_isForward == YES) {

      self.intpage += 1;

      //前进 页码到14页时 数组不再增删
      if (self.intpage < 2 || self.intpage > self.DataArr.count - 2) {

        nil;
      } else {

        [self.managedVclsArr removeObjectAtIndex:0];
        self.CardPreviewVcl0 =
            [[UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil]
                instantiateViewControllerWithIdentifier:@"CardPreviewVcl"];
        self.CardPreviewVcl0.CZS_URL =
            self.DataArr[self.intpage + 1][@"viewurl"];
        [self.managedVclsArr addObject:self.CardPreviewVcl0];
      }

    } else {

      self.intpage -= 1;

      //后退 页码到3页时 数组不再增删
      if (self.intpage < 1 || self.intpage >= self.DataArr.count - 2) {

        nil;
      } else {

        [self.managedVclsArr removeObjectAtIndex:2];
        self.CardPreviewVcl0 =
            [[UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil]
                instantiateViewControllerWithIdentifier:@"CardPreviewVcl"];
        self.CardPreviewVcl0.CZS_URL =
            self.DataArr[self.intpage - 1][@"viewurl"];
        [self.managedVclsArr insertObject:self.CardPreviewVcl0 atIndex:0];
      }
    }
  }

  if (finished) {

    _PageLabel.text =
        [NSString stringWithFormat:@"%d/%lu", self.intpage + 1,
                                   (unsigned long)self.DataArr.count];
    NSLog(@"。。。翻页到第%d页。。。", self.intpage + 1);
  }
}

//设置无照片空白页
- (void)setNoPhotoRemindVcl {

  //没有照片提示页面
  NoPhotoRemindViewController *NoPhotoRemindVcl =
      [[UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil]
          instantiateViewControllerWithIdentifier:@"NoPhotoRemindVcl"];
  [self setViewControllers:@[ NoPhotoRemindVcl ]
                 direction:UIPageViewControllerNavigationDirectionForward
                  animated:NO
                completion:nil];
  //移除页码
  [_PageLabel removeFromSuperview];
}

//分享按钮事件
- (void)RightBtnClick {

  NSDictionary *dic = self.DataArr[self.intpage];
  ShareView *shareView = [ShareView sharedInstance];
  shareView.shareType = BBQShareTypeCZS;
  shareView.shareURL = dic[@"shareurl"];
  shareView.shareTitle = dic[@"sharetitle"];
  shareView.shareContent = dic[@"sharecontent"];
  [shareView showShareView];
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

@end
