//
//  BBQBabyMaterialViewController.m
//  BBQ
//
//  Created by anymuse on 15/12/2.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQBabyMaterialViewController.h"
#import <UINavigationBar+Awesome.h>
#import "BBQBabyMaterialCell.h"
#import "BBQSchoolDataModel.h"
#import "BBQClassDataModel.h"
#import "BBQBabyModifyViewController.h"
#import <Masonry.h>
#import "UIImageView+Extension.h"
#import <UINavigationController+FDFullscreenPopGesture.h>
#import <QiniuSDK.h>
#import "BBQInviteBaobaoData.h"
#import "BBQInviteMemberdata.h"
#import "BBQInviteModel.h"
#import "BBQDynamicTableViewController.h"

@interface BBQBabyMaterialViewController ()<UITableViewDelegate,
UITableViewDataSource,UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UINavigationBarDelegate>
@property(weak, nonatomic) IBOutlet UITableView *babyDataTableview;
@property(weak, nonatomic) IBOutlet UIImageView *headerIcon;
@property(weak, nonatomic) IBOutlet UILabel *nameLabel;
@property(weak, nonatomic) IBOutlet UILabel *ageLabel;
//刷新页面计数值
@property (weak, nonatomic) IBOutlet UIImageView *coverImage;
@property(nonatomic, assign) int nRefreshPageCount;
@property(nonatomic, strong) BBQSchoolDataModel *school;
@property(nonatomic, strong)  BBQClassDataModel *classmodel;
@property (weak, nonatomic) IBOutlet UIView *CoverView;
//相册
@property(strong, nonatomic) UIImagePickerController *imagePicker;
//图片转换的data对象
@property (weak, nonatomic) IBOutlet UIButton *coverButton;
@property(strong, nonatomic) NSData *data;
//图片二进制路径
@property(strong, nonatomic) NSString *filePathStr;
@property (weak, nonatomic) IBOutlet UIView *choiceView;

@property(strong, nonatomic) NSMutableArray *imageAry;
@property(strong, nonatomic) UploadFileModel *uploadFileModel;
@property(copy, nonatomic) NSString *nameStr;
@property(assign, nonatomic) NSInteger birthdayYear;
@property(assign, nonatomic) NSInteger birthdayMonth;
@property(assign, nonatomic) NSInteger birthdayDay;
@property (strong, nonatomic) UINavigationBar *navBar;
@property(copy, nonatomic) NSString *birthdayStr;
@property(copy, nonatomic) NSString *genderStr;
@property(copy, nonatomic) NSString *placeStr;
@property(copy, nonatomic) NSString *schoolStr;
@property(copy, nonatomic) NSString *classStr;

@end

@implementation BBQBabyMaterialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.baby && !self.inviteModel) {
        self.baby = TheCurBaoBao;
    }
    
    [self.view addSubview:self.navBar];
    //相册
    _imagePicker = [[UIImagePickerController alloc] init];
    _imagePicker.allowsEditing = YES;
    _imagePicker.delegate = self;
    self.choiceView.layer.masksToBounds = YES;
    self.choiceView.layer.cornerRadius = 10.0;
    [self.headerIcon doBorderWidth:2.0 color:[UIColor whiteColor] cornerRadius:self.headerIcon.size.width/2];
#ifdef TARGET_PARENT
    self.school = [self.baby.baobaoschooldata firstObject];
    self.classmodel = [_school.classdata firstObject];
#else
    self.school = [TheCurUser.schooldata firstObject];
    self.classmodel = [TheCurUser.classdata firstObject];
#endif
    _CoverView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    _babyDataTableview.delegate = self;
    _babyDataTableview.dataSource = self;
    //去除多余分割线
    self.babyDataTableview.tableFooterView = [UIView new];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(displayHeadView) name:kSetNeedsRefreshBaobaoHeadNotification object:nil];
    [self displayBabyInfo];
    
    
}

- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar lt_reset];
}

- (void)displayBabyInfo {
    [self displayHeadView];
#ifdef TARGET_PARENT
    if (TheCurBaoBao.qx.integerValue == BBQAuthorityTypeAdmin || TheCurBaoBao.qx.integerValue ==BBQAuthorityTypeManager) {
        self.coverButton.hidden = NO;
    }else{
        self.coverButton.hidden = YES;
    }
#else
    self.coverButton.hidden = YES;
#endif
    if (self.baby) {
        self.nameStr = self.baby.realname;
        self.birthdayYear = self.baby.birthyear.integerValue;
        self.birthdayMonth = self.baby.birthmonth.integerValue;
        self.birthdayDay = self.baby.birthday.integerValue;
    }else{
        self.nameStr = self.inviteModel.baobaodata.username;
        self.birthdayYear = [self.inviteModel.baobaodata.birthyear integerValue];
        self.birthdayMonth = [self.inviteModel.baobaodata.birthmonth integerValue];
        self.birthdayDay = [self.inviteModel.baobaodata.birthday integerValue];
        
    }
    self.nameLabel.text = self.nameStr;
    self.schoolStr= self.school.schoolname;
    self.classStr = self.classmodel.classname;
    if (self.birthdayYear) {
        self.birthdayStr = [NSString stringWithFormat:@"%ld年%ld月%ld日",(long)self.birthdayYear,
                            (long)self.birthdayMonth, (long)self.birthdayDay];}
    if (self.baby) {
        if ([self.baby.gender isEqual:@1])
            self.genderStr =@"男";
        else if([self.baby.gender isEqual:@2])
            self.genderStr =@"女";
        if (self.school.resideprovince.length){
            self.placeStr = [NSString stringWithFormat:@"%@%@%@",_school.resideprovince,_school.residecity,_school.residedist];
        }
        
    }else{
        if ([self.inviteModel.baobaodata.gender isEqual:@1])
            self.genderStr =@"男";
        else if([self.inviteModel.baobaodata.gender isEqual:@2])
            self.genderStr =@"女";
        if (self.inviteModel.baobaodata.resideprovince.length){
            self.placeStr = [NSString stringWithFormat:@"%@%@%@",self.inviteModel.baobaodata.resideprovince,self.inviteModel.baobaodata.residecity,self.inviteModel.baobaodata.residedist];
        }
    }
    if (self.birthdayYear ==0) {
        self.ageLabel.text = @"0岁";
    }else
        self.ageLabel.text = [CommonFunc getAgeWithYear:self.birthdayYear
                                                  month:self.birthdayMonth
                                                    day:self.birthdayDay];
}

- (void)displayHeadView {
    [self.coverImage setImageWithURL:[NSURL URLWithString:self.baby.coverurl] placeholder:[UIImage imageNamed:@"coverImage.jpg"]];
    NSString * avatarStr = self.baby?self.baby.avartar:self.inviteModel.baobaodata.avartar;
    [self.headerIcon DispNetorLocalImg:avatarStr];
}

- (void)didClickRightItem {
    [self performSegueWithIdentifier:@"pushToBabyDataModify" sender:nil];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
#ifdef TARGET_PARENT
    return 1;
#else
    return 2;
#endif
    
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
#ifdef TARGET_PARENT
    return 6;
#else
    if (section ==0) {
        return 6;
    }else{
        return 3;
    }
#endif
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return (section ==0)? 0:44;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section ==1) {
        return @"家长信息";
    }else return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *arr1 =
    @[ @"姓名",
       @"生日",
       @"性别",
       @"地区",
       @"学校",
       @"班级",
       @"宝宝动态"];
    NSArray *arr2 =
    @[ @"姓名",
       @"关系",
       @"手机号"];
    BBQBabyMaterialCell *cell =
    [tableView dequeueReusableCellWithIdentifier:@"babyDataidentifier"];
    if (indexPath.section ==0) {
        cell.Label1.text = arr1[indexPath.row];
    }else{
        cell.Label1.text = arr2[indexPath.row];
    }
    switch (indexPath.row) {
        case 0:
            if (indexPath.section ==0)
                cell.Label2.text = self.nameStr;
            else
                cell.Label2.text = self.inviteModel.memberdata.nickname?:self.baby.gxrealname;
            break;
        case 1:
            if (indexPath.section ==0)
                cell.Label2.text = _birthdayStr;
            else
                cell.Label2.text = self.inviteModel.memberdata.gxname?[NSString stringWithFormat:@"%@的%@",self.nameStr,self.inviteModel.memberdata.gxname]:self.baby.gxapplyname?[NSString stringWithFormat:@"%@的%@",self.nameStr,self.baby.gxapplyname]:@"";
            break;
        case 2:
            if (indexPath.section ==0)
                cell.Label2.text = _genderStr;
            else
                cell.Label2.text = self.inviteModel.memberdata.username?:self.baby.gxusername;
            break;
        case 3:
            cell.Label2.text = _placeStr;
            break;
        case 4:
            cell.Label2.text = _schoolStr;
            break;
        case 5:
            cell.Label2.text = _classStr;
            break;
        case 6:
            cell.Label2.text = @"";
            UIImageView *jiantouImageView = [[UIImageView alloc]
                                             initWithImage:[UIImage imageNamed:@"xiayibu_set"]];
            [cell.contentView addSubview:jiantouImageView];
            [jiantouImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(18, 18));
                make.centerY.mas_equalTo(cell);
                make.right.equalTo(cell).offset(-16);
            }];
            break;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 6: {
            BBQDynamicViewModel *viewModel = [BBQDynamicViewModel viewModelForBaby:self.baby.uid];
            BBQDynamicTableViewController *vc = [[BBQDynamicTableViewController alloc] initWithViewModel:viewModel];
            vc.navigationItem.title = self.baby.realname;
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        default:
            break;
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"pushToBabyDataModify"]) {
        BBQBabyModifyViewController *vc = segue.destinationViewController;
        vc.type = BBQBabyModifyTypeNormal;
        return;
    }
}
- (IBAction)changeCoverImage {
    [UIView animateWithDuration:0.5 animations:^{
        self.CoverView.alpha = 1.0;
    }];
}
- (IBAction)clickPhoto {
    _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //跳转到相册
    [self presentViewController:_imagePicker animated:YES completion:nil];
    
}
- (IBAction)cameral:(id)sender {
    _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:_imagePicker animated:YES completion:nil];
}
- (IBAction)cancelClick {
    [UIView animateWithDuration:0.5 animations:^{
        self.CoverView.alpha = 0.0;
    }];
}
// imagePickerView代理 照片选择完成
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [UIView animateWithDuration:0.5 animations:^{
        self.CoverView.alpha = 0.0;
    }];
    UIImage *image = info[UIImagePickerControllerEditedImage];
    NSString *filenameGuid = [NSString stringWithUUID];
    NSDictionary *dicFileInfo =
    [CommonFunc saveJYEXPic:image fileguid:filenameGuid mode:@"L"];
    
    if (!dicFileInfo) {
        [SVProgressHUD showErrorWithStatus:@"保存文件失败"];
        return;
    }
    
    NSString *filepath = dicFileInfo[@"slt"][@"filepath"];
    UIImage *imagefile = [UIImage imageWithContentsOfFile:filepath];
    if (self.imageAry == nil) {
        self.imageAry = [NSMutableArray arrayWithCapacity:0];
    }
    if (self.uploadFileModel == nil) {
        self.uploadFileModel = [[UploadFileModel alloc] init];
    }
    self.uploadFileModel.fileData = UIImageJPEGRepresentation(imagefile, 1);
    self.uploadFileModel.fileName = filepath;
    [self.imageAry addObject:self.uploadFileModel];
    [SVProgressHUD showWithStatus:@"请稍候"];
    //刚换按钮图片
    [self.coverImage setImage:imagefile];
    //保存后 上传图片请求
    QNUploadManager *manager = [QNUploadManager sharedInstanceWithConfiguration:nil];
    @weakify(self)
    [manager putFile:self.uploadFileModel.fileName key:nil token:TheCurUser.qntoken complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        @strongify(self)
        if (info.isOK) {
            NSString *strFilePath =
            [NSString stringWithFormat:@"http://%@/%@", TheCurUser.qndns, resp[@"key"]];
            [self upLoadBaoBaoCover:strFilePath];
        }
    } option:nil];
    //完成后返回界面
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)upLoadBaoBaoCover:(NSString *)strFilePath{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"baobaouid"] = TheCurBaoBao.uid;
    params[@"coverurl"] = strFilePath;
    [BBQHTTPRequest
     queryWithType:BBQHTTPRequestTypeBaobaoCover
     param:params
     successHandler:^(AFHTTPRequestOperation *operation,
                      NSDictionary *responseObject, bool apiSuccess) {
         NSLog(@"%@",responseObject);
         TheCurBaoBao.coverurl = strFilePath;
         if (self.returnCoverImageBlock != nil) {
             self.returnCoverImageBlock(strFilePath);
         }
         [SVProgressHUD showSuccessWithStatus:@"封面上传成功"];
     } errorHandler:^(NSDictionary *responseObject) {
         [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
     }
     failureHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
         [SVProgressHUD showErrorWithStatus:@"网络繁忙"];
     }];
    
}
// imagePickerView代理 照片选择取消
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    //取消后返回界面
    [self dismissViewControllerAnimated:NO completion:nil];
    [UIView animateWithDuration:0.5 animations:^{
        self.CoverView.alpha = 0.0;
    }];
}

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    [self.navigationController popViewControllerAnimated:YES];
    return YES;
}

- (UINavigationBar *)navBar {
    if (!_navBar) {
        _navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
        [_navBar lt_setBackgroundColor:[UIColor clearColor]];
        _navBar.translucent = YES;
        _navBar.delegate = self;
        UINavigationItem *backItem = [[UINavigationItem alloc] initWithTitle:@""];
        backItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        UINavigationItem *rightItem = [[UINavigationItem alloc] initWithTitle:@""];
#ifdef TARGET_PARENT
        rightItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"edit"] style:UIBarButtonItemStyleDone target:self action:@selector(didClickRightItem)];
#endif
        [_navBar pushNavigationItem:backItem animated:NO];
        [_navBar pushNavigationItem:rightItem animated:NO];
    }
    return _navBar;
}
@end
