//
//  advertisementViewController.m
//  BBQ
//
//  Created by wth on 15/12/4.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "advertisementViewController.h"
#import "WebViewController.h"
#import "AppDelegate.h"
#import "BBQadvertisementModel.h"
#import <UINavigationController+FDFullscreenPopGesture.h>
#import "BBQLoginADApi.h"

@interface advertisementViewController ()

//跳过按钮
@property (weak, nonatomic) IBOutlet UIButton *TiaoGuoBtn;
//网络图片
@property (weak, nonatomic) IBOutlet UIImageView *AdvertisementImageview;
@property(assign,nonatomic) int TimeNum;
@property(assign,nonatomic) int TimeNum2;

//要跳转网页url
@property(strong,nonatomic)NSString *UrlStr;

//计时器
@property(strong,nonatomic) NSTimer *timer;
@property(strong,nonatomic) NSTimer *timer2;
//判断是否已经点击
@property(assign,nonatomic)BOOL isTap;

@end

@implementation advertisementViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.TimeNum2=5;
    self.TiaoGuoBtn.hidden=YES;
    _timer2=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(DealTimer2) userInfo:nil repeats:YES];
    [_timer2 fire];
    
    //请求数据
    [self RequestAdvertisementData];
    
    _isTap=NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    TheCurUser.didFinishAD = YES;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (!_isTap) {
        if (self.showNewUploadBlock != nil) {
            self.showNewUploadBlock();
        }
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    if (_isTap==YES) {
        _isTap = NO;
        [self.navigationController popViewControllerAnimated:NO];
    }
}

- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}

-(void)RequestAdvertisementData{
    
//    NSDictionary *ParamDic=@{@"appType":self.TypeNumStr};
    @weakify(self)
    [[[BBQLoginADApi alloc] initWithAppType:self.TypeNumStr] startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        @strongify(self)
        BBQadvertisementModel *model = [BBQadvertisementModel modelWithJSON:request.responseJSONObject[@"data"][@"List"]];
        [self.AdvertisementImageview setImageWithURL:[NSURL URLWithString:model.pagePic] placeholder:nil];
        [_timer2 invalidate];
        self.TiaoGuoBtn.hidden=NO;
        //计时器
        self.TimeNum=[model.showTime intValue]+1;
        _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(DealTimer) userInfo:nil repeats:YES];
        [self.TiaoGuoBtn setTitle:[NSString stringWithFormat:@"跳过 %d",self.TimeNum]forState:UIControlStateNormal];
        [_timer fire];
        //添加手势 跳转
        if ( ![model.pageUrl isEqualToString:@""]) {
            
            self.UrlStr=model.pageUrl;
            
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dealTap)];
            [self.AdvertisementImageview addGestureRecognizer:tap];
        }
    } failure:nil];
//    
//    [BBQHTTPRequest queryWithType:BBQHTTPRequestTypeAdvertisementLogin param:ParamDic successHandler:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject, bool apiSuccess) {
//        
//        BBQadvertisementModel *model = [BBQadvertisementModel mj_objectWithKeyValues:responseObject[@"data"][@"List"]];
//        [self.AdvertisementImageview setImageWithURL:[NSURL URLWithString:model.pagePic] placeholder:nil];
//        
//        [_timer2 invalidate];
//        self.TiaoGuoBtn.hidden=NO;
//        //计时器
//        self.TimeNum=[model.showTime intValue]+1;
//        _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(DealTimer) userInfo:nil repeats:YES];
//        [self.TiaoGuoBtn setTitle:[NSString stringWithFormat:@"跳过 %d",self.TimeNum]forState:UIControlStateNormal];
//        [_timer fire];
//        
//        
//        //添加手势 跳转
//        if ( ![model.pageUrl isEqualToString:@""]) {
//            
//            self.UrlStr=model.pageUrl;
//            
//            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dealTap)];
//            [self.AdvertisementImageview addGestureRecognizer:tap];
//        }
//        
//    } errorHandler:^(NSDictionary *responseObject) {
//        
//    } failureHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//    }];
//    
}


//处理手势跳转界面
-(void)dealTap{
    _isTap=YES;
    //进入网页
    WebViewController *WebVcl =
    [[UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil]
     instantiateViewControllerWithIdentifier:@"WebViewController"];
    WebVcl.url = self.UrlStr;
    [self.navigationController pushViewController:WebVcl animated:YES];
    
}

//倒计时
-(void)DealTimer{
    
    if (self.TimeNum>1) {
        self.TimeNum-=1;
    }else{
        [_timer invalidate];
        if (_isTap!=YES) {
            [self.navigationController popViewControllerAnimated:NO];
        }
    }
    [self.TiaoGuoBtn setTitle:[NSString stringWithFormat:@"跳过 %d",self.TimeNum]forState:UIControlStateNormal];
}

-(void)DealTimer2{
    
    if (self.TimeNum2>1) {
        self.TimeNum2-=1;
    }else{
        [_timer2 invalidate];
        [self.navigationController popViewControllerAnimated:NO];
    }
}

//跳过按钮事件 消失广告
- (IBAction)TiaoguoBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
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
