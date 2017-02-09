//
//  jyexViewController.m
//  BBQ
//
//  Created by mwt on 15/8/9.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "jyexViewController.h"
#import "WebViewController.h"
#import <Masonry.h>
#import "UIView+Common.h"
#import "BBQSelectButton.h"
#import <KxMenu.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "TestJSObject.h"
#import "BBQLeaveListTabbleViewController.h"
#import "KxMenuItem+BBQSchoolClassItme.h"
#import "XTSegmentControl.h"

@interface jyexViewController ()

@property(weak, nonatomic) IBOutlet UIButton *btnGrowing;
@property(weak, nonatomic) IBOutlet UIButton *btnZTC;
@property(weak, nonatomic) IBOutlet UIButton *btnYuer;

@property(weak, nonatomic) IBOutlet UIWebView *webview;
@property(weak, nonatomic) IBOutlet UIActivityIndicatorView *ativityIndicator;
@property(weak, nonatomic) IBOutlet UIImageView *ivRedline;

@property(nonatomic, assign) int selectno;

//刷新页面计数值
@property(nonatomic, assign) int nRefreshPageCount;

//登录用户上个子controller.
@property(nonatomic, retain) UIViewController *subController;

@property(strong, nonatomic) XTSegmentControl *mySegmentControl;
@property(strong, nonatomic) iCarousel *myCarousel;
@property(assign, nonatomic) NSInteger oldSelectedIndex;
@property (strong, nonatomic) BBQSelectButton *selectBtn;
@property (copy, nonatomic) NSNumber *baobaoid;
@property (copy, nonatomic) NSNumber *schoolid;
@property (copy, nonatomic) NSNumber *classid;

@end

#define _basebuttontag 1000

@implementation jyexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view.
    
    /*
     self.webview.delegate = self;
     
     CGRect rect = self.ivRedline.frame;
     rect.size.width = self.btnGrowing.frame.size.width;
     self.ivRedline.frame = rect;
     
     //取刷新页面计数值
     self.nRefreshPageCount = [_GLOBAL getRefreshPageCount];
     
     [self loadViewConent];
     */
    
    self.edgesForExtendedLayout=UIRectEdgeNone;
    
    
    
    [self setupSegmentItems];
    
    //切换宝宝刷新数据
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(refreshWebView)
     name:kSetNeedsRefreshEntireDataNotification
     object:nil];
    self.webview.delegate = self;
    //接收JS调用通知跳转
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(CZS_Action:)
                                                 name:@"CZS_Action"
                                               object:nil];
    
   //添加上方导航按钮
    [self addselectBtn];
}

-(void)addselectBtn{

    _selectBtn = [BBQSelectButton buttonWithType:UIButtonTypeCustom];
    [_selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _selectBtn.frame = CGRectMake(50, 20, kScreen_Width - 100, 40);
    [_selectBtn setTitle:[TheCurBaoBao.curSchool.schoolname stringByAppendingString:TheCurBaoBao.curClass.classname] forState:UIControlStateNormal];
    [_selectBtn setImage:[UIImage imageNamed:@"daosanjiao"] forState:UIControlStateNormal];
    [_selectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.navigationController.view addSubview:_selectBtn];
}

- (void)CZS_Action:(NSNotification *)notification {
    if ([notification.userInfo[@"action"] isEqual:@"cmd_intoqj"]) {
        BBQLeaveListTabbleViewController *vc = [[UIStoryboard storyboardWithName:@"Family" bundle:nil] instantiateViewControllerWithIdentifier:@"leaveListVC"];
        vc.params = notification.userInfo[@"para"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)refreshWebView {
    if (_myCarousel && _mySegmentControl) {
        [_myCarousel removeFromSuperview];
        _myCarousel = nil;
        [_mySegmentControl removeFromSuperview];
        _mySegmentControl = nil;
    }
    [self setupSegmentItems];
}

- (void)setIcarouselScrollEnabled:(BOOL)icarouselScrollEnabled {
    _myCarousel.scrollEnabled = icarouselScrollEnabled;
}

- (void)configSegmentItems {
#if TARGET_PARENT
    if ((TheCurBaoBao.qx.integerValue == 1 || TheCurBaoBao.qx.integerValue == 2) && (TheCurBaoBao.curSchool && TheCurBaoBao.curClass)) {
        _segmentItems =
        [NSMutableArray arrayWithArray:@[ @"直通车", @"育儿" ]];
            self.navigationItem.title = @"";
        
        
    } else {
        _segmentItems = [NSMutableArray arrayWithArray:@[ @"育儿" ]];
        self.navigationItem.title = @"育儿";
    }
#else
    _segmentItems =
    [NSMutableArray arrayWithArray:@[ @"直通车", @"成长", @"育儿" ]];
#endif
}

- (void)dealloc {
    [_selectBtn removeFromSuperview];
    _selectBtn = nil;
}

- (void)selectBtnClick:(UIButton *)sender {
    NSMutableArray *nameAry = [NSMutableArray arrayWithCapacity:0];
    for (BBQSchoolDataModel *school in TheCurBaoBao.baobaoschooldata) {
        NSString *schoolname = school.schoolname;
        for (BBQClassDataModel *class in school.classdata) {
            KxMenuItem *item = [KxMenuItem menuItem:[schoolname stringByAppendingString:class.classname] image:nil target:self action:@selector(kxmenuItemClick:)];
            item.schoolclassname = [schoolname stringByAppendingString:class.classname];
            item.schoolid = [school.schoolid stringValue];
            item.classid = [class.classid stringValue];
            [nameAry addObject:item];
        }
    }
    [KxMenu showMenuInView:self.navigationController.view fromRect:sender.frame menuItems:nameAry];
}

- (void)kxmenuItemClick:(KxMenuItem *)item {
    [_selectBtn setTitle:item.title forState:UIControlStateNormal];
    _schoolid = [NSNumber numberWithString:item.schoolid];
    _classid = [NSNumber numberWithString:item.classid];
    [KxMenu dismissMenu];
    [self loadContentAtWebview:(UIWebView *)self.myCarousel.currentItemView idx:self.myCarousel.currentItemIndex];
}

- (void)setupSegmentItems {
    
    [self configSegmentItems];
    _oldSelectedIndex = 0;
#if TARGET_PARENT
    if ((TheCurBaoBao.qx.integerValue == 1 || TheCurBaoBao.qx.integerValue == 2) && (TheCurBaoBao.curSchool && TheCurBaoBao.curClass)) {
        //添加myCarousel
        _myCarousel = ({
            iCarousel *icarousel = [[iCarousel alloc] init];
            icarousel.dataSource = self;
            icarousel.delegate = self;
            icarousel.scrollSpeed = 1.0;
            icarousel.type = iCarouselTypeLinear;
            icarousel.pagingEnabled = YES;
            icarousel.clipsToBounds = YES;
            icarousel.bounceDistance = 0.2;
            [self.view addSubview:icarousel];
            [icarousel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.view)
                .insets(UIEdgeInsetsMake(kMySegmentControl_Height, 0, 0, 0));
            }];
            icarousel;
        });
        
        //添加滑块
        __weak typeof(_myCarousel) weakCarousel = _myCarousel;
        _mySegmentControl = [[XTSegmentControl alloc]
                             initWithFrame:CGRectMake(0, 0, kScreen_Width, kMySegmentControl_Height)
                             Items:_segmentItems
                             selectedBlock:^(NSInteger index) {
                                 if (index == _oldSelectedIndex) {
                                     return;
                                 }
                                 [weakCarousel scrollToItemAtIndex:index animated:NO];
                             }];
        [self.view addSubview:_mySegmentControl];
        self.icarouselScrollEnabled = YES;
    } else {
        [_myCarousel removeFromSuperview];
        _myCarousel = nil;
        [_mySegmentControl removeFromSuperview];
        _mySegmentControl = nil;
    }
#else
    _myCarousel = ({
        iCarousel *icarousel = [[iCarousel alloc] init];
        icarousel.dataSource = self;
        icarousel.delegate = self;
        icarousel.scrollSpeed = 1.0;
        icarousel.type = iCarouselTypeLinear;
        icarousel.pagingEnabled = YES;
        icarousel.clipsToBounds = YES;
        icarousel.bounceDistance = 0.2;
        [self.view addSubview:icarousel];
        [icarousel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view)
            .insets(UIEdgeInsetsMake(kMySegmentControl_Height, 0, 0, 0));
        }];
        icarousel;
    });
    
    //添加滑块
    __weak typeof(_myCarousel) weakCarousel = _myCarousel;
    _mySegmentControl = [[XTSegmentControl alloc]
                         initWithFrame:CGRectMake(0, 0, kScreen_Width, kMySegmentControl_Height)
                         Items:_segmentItems
                         selectedBlock:^(NSInteger index) {
                             if (index == _oldSelectedIndex) {
                                 return;
                             }
                             [weakCarousel scrollToItemAtIndex:index animated:NO];
                         }];
    [self.view addSubview:_mySegmentControl];
    self.icarouselScrollEnabled = YES;
#endif
    
    [self loadViewConent];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //判断是否需要刷新
    //    if ( self.nRefreshPageCount != [_GLOBAL getRefreshPageCount]) {
    //        self.nRefreshPageCount = [_GLOBAL getRefreshPageCount];
    //        [self loadViewConent];
    //    }
    //    [self setupSegmentItems];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _baobaoid = TheCurBaoBao.uid;
    _schoolid = TheCurBaoBao.curSchool.schoolid;
    _classid = TheCurBaoBao.curClass.classid;
    //    if (_myCarousel) {
    //        UIWebView *curView = (UIWebView *)_myCarousel.currentItemView;
    //        curView.backgroundColor = [UIColor whiteColor];
    //    }
    if (TheCurBaoBao.qx.integerValue == 3 || !TheCurBaoBao.curClass || !TheCurBaoBao.curSchool) {
        _selectBtn.hidden = YES;
        _selectBtn.userInteractionEnabled = NO;
        self.navigationController.navigationItem.title = @"育儿";
    } else {
        _selectBtn.hidden = NO;
        _selectBtn.userInteractionEnabled = YES;
    }
    if (_selectBtn) {
        [_selectBtn setTitle:[TheCurBaoBao.curSchool.schoolname stringByAppendingString:TheCurBaoBao.curClass.classname] forState:UIControlStateNormal];
    }
    
        [self refreshWebView];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _selectBtn.hidden = YES;
    _selectBtn.userInteractionEnabled = NO;
}

#pragma mark iCarousel M
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return _segmentItems.count;
}

- (UIView *)carousel:(iCarousel *)carousel
  viewForItemAtIndex:(NSInteger)index
         reusingView:(UIView *)view {
    
    UIWebView *viewss = (UIWebView *)view;
    if (viewss) {
        viewss.backgroundColor = [UIColor whiteColor];
    } else {
        viewss = [[UIWebView alloc] init];
        viewss.backgroundColor = [UIColor whiteColor];
        viewss.frame =
        CGRectMake(0, 0, carousel.frame.size.width, carousel.frame.size.height);
    }
    viewss.delegate = self;
    
    [viewss setSubScrollsToTop:(index == carousel.currentItemIndex)];
    [self loadContentAtWebview:viewss idx:index];
    //    if ([UIDevice currentDevice].systemVersion.floatValue > 8.0) {
    //        carousel.currentItemView.frame = CGRectMake(0, 0,
    //        carousel.frame.size.width, carousel.frame.size.height);
    //    }
    return viewss;
}

- (void)carouselDidScroll:(iCarousel *)carousel {
    [self.view endEditing:YES];
    if (_mySegmentControl) {
        float offset = carousel.scrollOffset;
        if (offset > 0) {
            [_mySegmentControl moveIndexWithProgress:offset];
        }
    }
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel {
    if (_mySegmentControl) {
        _mySegmentControl.currentIndex = carousel.currentItemIndex;
    }
    if (_oldSelectedIndex != carousel.currentItemIndex) {
        _oldSelectedIndex = carousel.currentItemIndex;
        UIWebView *curView = (UIWebView *)carousel.currentItemView;
        curView.delegate = self;
        //        curView.frame = CGRectMake(0, 0, carousel.frame.size.width,
        //        carousel.frame.size.height);
        //        if ([UIDevice currentDevice].systemVersion.floatValue > 8.0) {
        //            carousel.currentItemView.frame = CGRectMake(0, 0,
        //            carousel.frame.size.width, carousel.frame.size.height - 49);
        //        }
        curView.backgroundColor = [UIColor whiteColor];
        [self loadContentAtWebview:curView idx:carousel.currentItemIndex];
    }
    [carousel.visibleItemViews
     enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
         [obj setSubScrollsToTop:(obj == carousel.currentItemView)];
     }];
}

- (void)loadViewConent {
    if (self.subController) {
        [self.subController.view removeFromSuperview];
        [self.subController removeFromParentViewController];
        self.subController = nil;
    }
    
#ifdef TARGET_PARENT
    if (TheCurBaoBao.qx.integerValue == 3  || !TheCurBaoBao.curSchool || !TheCurBaoBao.curClass ) { //非圈主
        UIStoryboard *sb =
        [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
        WebViewController *vc =
        [sb instantiateViewControllerWithIdentifier:@"WebViewController"];
        vc.url = URL_HOMEPAGE_YUER;
        
        [self addChildViewController:vc];
        [self.view addSubview:vc.view];
        
        self.subController = vc;
        return;
    }
    if (TheCurBaoBao.qx.integerValue == 1) {
        [self loadContent:0];
    } else {
        [self loadContent:1];
    }
#else
    [self loadContent:0];
#endif
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickSelectButn:(id)sender {
    UIButton *btn = (UIButton *)sender;
    
    CGRect rect = self.ivRedline.frame;
    rect.origin.x = (btn.tag - _basebuttontag) * btn.frame.size.width;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    self.ivRedline.frame = rect;
    [UIView commitAnimations];
    
    [self loadContent:((int)(btn.tag - _basebuttontag))];
}

- (void)loadContentAtWebview:(UIWebView *)webview idx:(NSInteger)no {
    NSString *url;
    
    //园长
#ifdef TARGET_MASTER
    
    if (no == 1)
        url = URL_HOMEPAGE_GROWING_MASTER;
    else if (no == 0)
        url = URL_HOMEPAGE_JIAYUAN_MASTER;
    else
        url = URL_HOMEPAGE_YUER;
    
    //老师
#elif TARGET_TEACHER
    
    if (no == 1)
        url = URL_HOMEPAGE_GROWING_TEACHER;
    else if (no == 0)
        url = URL_HOMEPAGE_JIAYUAN_TEACHER;
    else
        url = URL_HOMEPAGE_YUER;
    
    //家长
#else
    
    if (no == 1)
        url = URL_HOMEPAGE_YUER;
    else if (no == 0)
        url = [CS_URL_BASE stringByAppendingString:[NSString stringWithFormat:@"mh.php?mod=workbench_jiazhang&ac=jzztc_menu&in_mobile=1&baobaouid=%@&classid=%@&schoolid=%@&_self=1", TheCurBaoBao.uid, _classid, _schoolid]];
//        url = [NSString stringWithFormat:URL_HOMEPAGE_JIAYUAN_PARENT,TheCurBaoBao.uid, _classid, _schoolid];
//        url = URL_HOMEPAGE_JIAYUAN_PARENT;
//    else
//        url = URL_HOMEPAGE_YUER;
#endif
    
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    
    [webview beginLoading];
}

- (void)loadContent:(int)no {
    NSString *url;
    
    self.selectno = no;
    
    //园长
#ifdef TARGET_MASTER
    
    if (no == 0)
        url = URL_HOMEPAGE_GROWING_MASTER;
    else if (no == 1)
        url = URL_HOMEPAGE_JIAYUAN_MASTER;
    else
        url = URL_HOMEPAGE_YUER;
    
    //老师
#elif TARGET_TEACHER
    
    if (no == 0)
        url = URL_HOMEPAGE_GROWING_TEACHER;
    else if (no == 1)
        url = URL_HOMEPAGE_JIAYUAN_TEACHER;
    else
        url = URL_HOMEPAGE_YUER;
    
    //家长
#else
    
    if (no == 0)
//        url = [NSString stringWithFormat:URL_HOMEPAGE_JIAYUAN_PARENT,TheCurBaoBao.uid, _classid, _schoolid];
//        url = URL_HOMEPAGE_GROWING_PARENT;
        url = [CS_URL_BASE stringByAppendingString:[NSString stringWithFormat:@"mh.php?mod=workbench_jiazhang&ac=jzztc_menu&in_mobile=1&baobaouid=%@&classid=%@&schoolid=%@&_self=1", TheCurBaoBao.uid, _classid, _schoolid]];
    else if (no == 1)
        url = URL_HOMEPAGE_YUER;
//    else
//        url = URL_HOMEPAGE_YUER;
#endif
    
    [self.webview
     loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

#pragma mark -
#pragma mark UIWebViewDelegate Methods

- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString *sMethod = [request HTTPMethod];
    if (sMethod && ([sMethod isEqualToString:@"POST"] ||
                    [sMethod isEqualToString:@"post"])) {
        return YES;
    }
    
    NSString *path = [[request URL] absoluteString];
    NSLog(@"url:%@\r\n", path);
    
    NSString *url;
    
    //园长
#ifdef TARGET_MASTER
    
    if (self.selectno == 0)
        url = PATH_HOMEPAGE_GROWING_MASTER;
    else if (self.selectno == 1)
        url = PATH_HOMEPAGE_JIAYUAN_MASTER;
    else
        url = PATH_HOMEPAGE_YUER;
    
    //老师
#elif TARGET_TEACHER
    
    if (self.selectno == 0)
        url = PATH_HOMEPAGE_GROWING_TEACHER;
    else if (self.selectno == 1)
        url = PATH_HOMEPAGE_JIAYUAN_TEACHER;
    else
        url = PATH_HOMEPAGE_YUER;
    
    //家长
#else
    
    if (self.selectno == 0)
        url = PATH_HOMEPAGE_GROWING_PARENT;
    else if (self.selectno == 1)
        url = PATH_HOMEPAGE_JIAYUAN_PARENT;
    else
        url = PATH_HOMEPAGE_YUER;
#endif
    
    NSRange range1 = [path rangeOfString:url];
    if ([path rangeOfString:@"_self=1"].length > 0 ||
        [path rangeOfString:@"action=login"].length > 0) {
        return YES;
    }
    if (range1.length == 0 && ![path isEqualToString:@"about:blank"]) {
        
        UIStoryboard *sb =
        [UIStoryboard storyboardWithName:@"RootTabBar" bundle:nil];
        WebViewController *vc =
        [sb instantiateViewControllerWithIdentifier:@"WebViewController"];
        vc.url = path;
        [self.navigationController pushViewController:vc animated:YES];
        return NO;
    }
    
    self.ativityIndicator.hidden = NO;
    if (![self.ativityIndicator isAnimating]) {
        [self.ativityIndicator startAnimating];
    }
    
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [webView endLoading];
    [self.ativityIndicator stopAnimating];
    self.ativityIndicator.hidden = YES;
    
    /*
     //结束同步界面
     [self restoreRefleshHeadView:webView index:(int)webView.tag-1];
     */
    
    if ([error code] == -999 || [error code] == 102) {
        return;
    }
    
    NSString *err;
//    if ([[Global instance] getNetworkStatus] == NotReachable) {
//        err = @"无法加载页面，请检查网络。";
//    } else {
//        err = @"无法加载页面，请稍候...再试。";
//    }
    [self.webview loadHTMLString:err baseURL:nil];
    
    NSDictionary *dic = [error userInfo];
    NSString *err1 = [[NSString alloc]
                      initWithFormat:@"加载页面%@失败 %@ 请检查网络",
                      ((NSString *)
                       [dic objectForKey:@"NSErrorFailingURLStringKey"]),
                      [error localizedDescription]];
    NSLog(@"%@\r\n", err1);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [webView endLoading];
    [self.ativityIndicator stopAnimating];
    self.ativityIndicator.hidden = YES;
    
    JSContext *context = [webView
                          valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    TestJSObject *testJO = [TestJSObject new];
    context[@"client"] = testJO;
    
    //    CGSize actualSize = [webView sizeThatFits:CGSizeZero];
    //
    //    CGRect newFrame = webView.frame;
    //    newFrame.size.height = actualSize.height;
    //    webView.frame = newFrame;
    
    /*
     NSString *titleHTML = [webView
     stringByEvaluatingJavaScriptFromString:@"document.title"];
     NSLog(@"load finish: title=%@",titleHTML);
     
     //结束同步界面
     [self restoreRefleshHeadView:webView index:(int)(webView.tag-1)];
     
     NSDate *date = [NSDate date];
     //if ( webView.tag == 1) self.m_Date1 = date;
     //else if ( webView.tag == 2) self.m_Date2 = date;
     //else if ( webView.tag == 3) self.m_Date3 = date;
     //else
     if ( webView.tag == 4) self.m_Date4 = date;
     //else self.m_Date5 = date;
     
     //修改分栏目红点
     [self updateSubLanmu:webView.tag-1];
     */
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
