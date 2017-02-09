//
//  BBQOpeationViewController.m
//  BBQ
//
//  Created by anymuse on 15/12/30.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQOpeationViewController.h"
#import "BBQOperationTableViewCell.h"
#import "BBQOperationExpand.h"
#import "BBQOperationModel.h"
#import <QiniuSDK.h>
#import "WebViewController.h"

@interface BBQOpeationViewController ()<UITableViewDataSource,UITableViewDelegate,BBQOperationTableViewCellDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,
UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *datasource;
@property (strong, nonatomic) NSMutableArray *expandArr;
@property (strong, nonatomic) NSMutableArray *changedArr;
//相册
@property(strong, nonatomic) UIImagePickerController *imagePicker;
//图片转换的data对象
@property(strong, nonatomic) NSData *data;
//图片二进制路径
@property(strong, nonatomic) NSString *filePathStr;
@property(assign, nonatomic) NSInteger cellIndex;
@property(assign, nonatomic) NSInteger successNum;
@property(assign, nonatomic) BOOL needAddFuture;

@end

@implementation BBQOpeationViewController
-(NSMutableArray *)changedArr{
    if (!_changedArr) {
        self.changedArr = [NSMutableArray array];
    }
    return _changedArr;
}
-(NSMutableArray *)datasource{
    if (!_datasource) {
        self.datasource = [NSMutableArray array];
    }
    return _datasource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    
}
-(void)setOperationModel:(BBQOperationModel *)operationModel{
    _operationModel = operationModel;
    self.datasource = [NSMutableArray arrayWithArray:operationModel.expand];
    if (!self.datasource.count) {
        BBQOperationExpand *expand = [[BBQOperationExpand alloc] init];
        [self.datasource addObject:expand];
    }
}
-(void)setupFutureRequest{
    NSDictionary *param = @{
                            @"baobaouid" : TheCurBaoBao.uid,
                            @"expand" : self.expandArr,
                            @"preface" : self.operationModel.preface,
                            };
    [BBQHTTPRequest queryWithType:BBQHTTPRequestTypeAddFuture
                            param:param
                   successHandler:^(AFHTTPRequestOperation *operation,
                                    NSDictionary *responseObject, bool apiSuccess) {
                       NSString *str = @"提交成功！";
                       [SVProgressHUD showSuccessWithStatus:str];
                       //进入网页
                       [self jumpToWebView];
                   }
                     errorHandler:^(NSDictionary *responseObject) {
                         [SVProgressHUD dismiss];
                         NSLog(@"%@", responseObject);
                     }
                   failureHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
                       [SVProgressHUD dismiss];
                       NSLog(@"%@", error.localizedDescription);
                       [self jumpToWebView];
                       
                   }];
}

-(void)setupView{
    _imagePicker = [[UIImagePickerController alloc] init];
    //_imagePicker.allowsEditing = YES;
    _imagePicker.delegate = self;
    self.tableView.rowHeight = 200;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 设置表视图的尾部视图(footerView 添加子视图)
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW,100)];
    UIButton *addbtn = [[UIButton alloc] initWithFrame:CGRectMake((screenW - 120) * 0.5, 40, 120, 40)];
    addbtn.layer.cornerRadius = 20;
    [addbtn setBackgroundColor: UIColorHex(FF6440)];
    addbtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [addbtn setTitle:@"+ 增加场景" forState:UIControlStateNormal];
    [addbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addbtn addTarget:self action:@selector(addSence) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:addbtn];
    footerView.backgroundColor = [UIColor clearColor];
    _tableView.tableFooterView = footerView;  //设置尾部
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"预览" style:UIBarButtonItemStyleDone target:self action:@selector(preview)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    //添加键盘通知keyBordwillShow
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)operationTableViewCell:(BBQOperationTableViewCell *)cell keyBoardWithIndex:(NSInteger)index{
    if (index > 0) {
        NSInteger offset =self.view.frame.size.height-300;
        CGRect listFrame = CGRectMake(0, -offset, self.view.frame.size.width,self.view.frame.size.height);
        [UIView beginAnimations:@"anim" context:NULL];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3];
        //处理移动事件，将各视图设置最终要达到的状态
        
        self.tableView.frame=listFrame;
        
        [UIView commitAnimations];
    }
}

#pragma mark 键盘将隐藏
-(void)kbWillHide:(NSNotification *)noti{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.tableView.frame = rect;
    [UIView commitAnimations];
    
}
-(void)preview{
    if (self.needAddFuture) {
        [SVProgressHUD showWithStatus:@"请稍候..."];
        [self setupExpandArr];
        if (self.changedArr.count) {
            for (NSNumber * number in self.changedArr) {
                BBQOperationExpand *expand = self.datasource[number.integerValue];
                NSData *data = UIImageJPEGRepresentation(expand.img, 1.0);
                @weakify(self)
                [[QNUploadManager sharedInstanceWithConfiguration:nil] putData:data key:nil token:TheCurUser.qntoken complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                    @strongify(self)
                    //下面为上传成功
                    if (info.isOK) {
                        ++_successNum ;
                        NSString *strFilePath =
                        [NSString stringWithFormat:@"http://%@/%@", TheCurUser.qndns, resp[@"key"]];
                        [self.expandArr replaceObjectAtIndex:number.integerValue withObject:@{
                                                                                              @"imgurl": strFilePath ?: @"",
                                                                                              @"memo": expand.memo ?: @"",
                                                                                              }];
                        if (_successNum==self.changedArr.count) {
                            [self setupFutureRequest];
                        }
                    }
                } option:nil];
            }
        }else{
            [self setupFutureRequest];
        }
        
    }else{
        BOOL hasSence = NO;
        for (BBQOperationExpand *expand in self.datasource) {
            if (expand.imgurl) {
                hasSence = YES;
                break;
            }
        }
        if (hasSence) {
            [self jumpToWebView];
        }else{
            [SVProgressHUD showErrorWithStatus:@"请至少选择一个场景"];
        }
        
        
    }
    
}

- (void)uploadData:(NSData *)data atIndex:(NSInteger)index {
    
}

-(void)addSence{
    if (self.datasource.count>=20) {
        [SVProgressHUD showErrorWithStatus:@"最多20个场景"];
        return;
    }
    BBQOperationExpand *expand = [[BBQOperationExpand alloc] init];
    [self.datasource addObject:expand];
    [self.tableView reloadData];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datasource.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BBQOperationTableViewCell *cell = [BBQOperationTableViewCell cellWithTableView:tableView];
    cell.delegate = self;
    BBQOperationExpand *expand = self.datasource[indexPath.row];
    expand.index = indexPath.row;
    cell.expand = expand;
    return cell;
    
}
-(void)operationTableViewCell:(BBQOperationTableViewCell *)cell getdesc:(NSString *)descStr index:(NSInteger)index{
    BBQOperationExpand *expand = self.datasource[self.cellIndex];
    expand.memo = descStr;
    [self.datasource replaceObjectAtIndex:self.cellIndex withObject:expand];
    self.needAddFuture =YES;
}
-(void)operationTableViewCellDidDelete:(BBQOperationTableViewCell *)cell index:(NSInteger)index{
    [self.datasource removeObjectAtIndex:index];
    self.needAddFuture = YES;
    [self.tableView reloadData];
}
-(void)operationTableViewCellImageButtonClick:(BBQOperationTableViewCell *)cell index:(NSInteger)index{
    self.cellIndex = index;
    //创建UIActionSheet
    UIActionSheet *actionSheet =
    [[UIActionSheet alloc] initWithTitle:@"选择照片"
                                delegate:self
                       cancelButtonTitle:@"取消"
                  destructiveButtonTitle:@"来自相册"
                       otherButtonTitles:@"拍照", nil];
    [actionSheet showInView:self.view];
}

// UIActionSheet选择事件
- (void)actionSheet:(UIActionSheet *)actionSheet
clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0: {
            _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //跳转到相册
            [self presentViewController:_imagePicker animated:YES completion:nil];
        } break;
        case 1: {
            _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:_imagePicker animated:YES completion:nil];
        } break;
        default:
            break;
    }
}

// imagePickerView代理 照片选择完成
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    
    BBQOperationExpand *expand = self.datasource[self.cellIndex];
    expand.img = image;
    [self.datasource replaceObjectAtIndex:self.cellIndex withObject:expand];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:self.cellIndex inSection:0];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    [self.changedArr addObject:[NSNumber numberWithInteger:self.cellIndex]];
    self.needAddFuture =YES;
    //完成后返回界面
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

// imagePickerView代理 照片选择取消
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    //取消后返回界面
    [self dismissViewControllerAnimated:NO completion:nil];
}

/**
 *  当用户开始拖拽scrollView时调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
-(void)jumpToWebView{
    //进入网页
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[WebViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}
-(void)setupExpandArr{
    self.expandArr = [NSMutableArray array];
    for (BBQOperationExpand *expand in self.datasource) {
        [self.expandArr addObject:@{
                                    @"imgurl": expand.imgurl ?: @"",
                                    @"memo": expand.memo ?: @"",
                                    }];
    }
}
@end
