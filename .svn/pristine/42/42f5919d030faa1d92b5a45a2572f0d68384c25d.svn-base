//
//  BBQAttentionViewController.m
//  BBQ
//  Created by wenjing on 15/11/19.
//  Copyright © 2015年 bbq. All rights reserved.

#import "BBQAttentionViewController.h"
#import "BBQAttentionCell.h"
#import "BBQAttentionClassCell.h"
#import "BBQClassDataModel.h"
#import "BBQAttentionClassWithBaby.h"
#import "BBQBabyDataCreateViewController.h"
#import "BBQSchoolDataModel.h"
#import "BBQInviteViewController.h"
#import "UIBarButtonItem+Extention.h"
#import "BBQLoginManager.h"
#import "AppDelegate.h"
#import "BBQCreateBBCell.h"
#import "BBQNewLoginViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface BBQAttentionViewController ()<UITableViewDataSource,UITableViewDelegate,BBQCreateBBCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *crebabies;
@property (nonatomic, strong) NSMutableArray *attbabies;
@property (nonatomic, strong) NSMutableArray *classinfos;
@property (nonatomic, strong) BBQBabyModel *deletemodel;
@property (nonatomic, assign) NSInteger deleteSection;
@property (weak, nonatomic) IBOutlet UIView *coverView;
@property (weak, nonatomic) IBOutlet UILabel *deleteNameLabel;

@end

@implementation BBQAttentionViewController
- (NSMutableArray *)classinfos
{
    if (!_classinfos) {
        self.classinfos = [[NSMutableArray alloc] init];
    }
    return _classinfos;
}
- (NSMutableArray *)crebabies
{
    if (!_crebabies) {
        self.crebabies = [[NSMutableArray alloc] init];
    }
    return _crebabies;
}

- (NSMutableArray *)attbabies
{
    if (!_attbabies) {
        self.attbabies = [[NSMutableArray alloc] init];
    }
    return _attbabies;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _coverView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupData) name:@"baobaoDataChange" object:nil];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithtTarget:self anction:@selector(back) image:@"nav_back_arrow" title:nil];
    [self setupData];
}
-(void)back{
    if (self.type == BBQAttentionViewTypeNormal) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[BBQNewLoginViewController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
    }
}
- (void)showAlertWithName:(NSString *)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil, nil];
    [alert show];
}
-(void)pushToInviteController{
    [self performSegueWithIdentifier:@"pushToInviteController" sender:nil];
    
}
-(void)pushTobabyDataCreateVC{
    [self performSegueWithIdentifier:@"pushTobabyDataCreateVC" sender:nil];
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"pushToInviteController"]) {
        BBQInviteViewController *inviteVc = segue.destinationViewController;
        inviteVc.crebabies = self.crebabies;
        inviteVc.type = (self.type ==BBQAttentionViewTypeLogin)?BBQInviteViewTypeLogin:BBQInviteViewTypeNormal;
    }else if ([segue.identifier isEqualToString:@"pushTobabyDataCreateVC"]) {
        BBQBabyDataCreateViewController *createVc = segue.destinationViewController;
        createVc.type = (self.type ==BBQAttentionViewTypeLogin)?BBQBabyDataCreateTypeLogin:BBQBabyDataCreateTypeNormal;
    }
}
-(void)setupData{
    if (self.crebabies.count) {
        [self.crebabies removeAllObjects];
    }
    if (self.attbabies.count) {
        [self.attbabies removeAllObjects];
    }
    if (self.classinfos.count) {
        [self.classinfos removeAllObjects];
    }
    for (BBQBabyModel *baby in TheCurUser.baobaodata) {
        if (baby.qx.integerValue == BBQAuthorityTypeAdmin) {
            [self.crebabies addObject:baby];
        }else{
            [self.attbabies addObject:baby];
        }
        for (BBQSchoolDataModel *school in baby.baobaoschooldata) {
            for (BBQClassDataModel *class in school.classdata) {
                BBQAttentionClassWithBaby *model = [[BBQAttentionClassWithBaby alloc] init];
                model.showname = baby.realname;
                model.uid = baby.uid.stringValue;
                model.schoolname = school.schoolname;
                model.classmodel = class;
                model.schooltype = school.schooltype;
                model.schoolavartar = school.schoolavartar;
                [self.classinfos addObject:model];
            }
        }
    }
    [self.tableView reloadData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 1:
            return (self.crebabies.count) ? self.crebabies.count:1 ;
            break;
        case 2:
            return self.attbabies.count ?self.attbabies.count :1;
            break;
        case 3:
            return self.classinfos.count;
            break;
        default:
            return 1;
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section?70:110;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section ==2) {
        return YES;
    }else
        return NO;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 2 && self.attbabies.count){
         return  UITableViewCellEditingStyleDelete;
     }else
         return UITableViewCellEditingStyleNone;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = indexPath.section;
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [UIView animateWithDuration:0.5 animations:^{
            self.coverView.alpha = 1.0;
        }];
        BBQBabyModel *model = [[BBQBabyModel alloc] init];
        model = self.attbabies[indexPath.row];
        self.deleteNameLabel.text = [NSString stringWithFormat:@"确定删除%@吗？",model.realname];
        self.deletemodel = model;
        self.deleteSection =section;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger section = indexPath.section;
    if (section ==1) {
        BBQAttentionCell *cell =
        [tableView dequeueReusableCellWithIdentifier:@"babyAttentionCell"];
        if (self.crebabies.count) {
            cell.curBaobao = self.crebabies[indexPath.row];
            cell.nodataView.alpha = 0.0;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else{
           cell.nodataView.alpha = 1.0;
           cell.nodataLabel.text = @"您还没创建自己的宝宝";
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        return cell;
    }else if(section == 2){
        BBQAttentionCell *cell =[tableView dequeueReusableCellWithIdentifier:@"babyAttentionCell"];
        if (self.attbabies.count) {
            cell.curBaobao = self.attbabies[indexPath.row];
            cell.nodataView.alpha = 0.0;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else{
            cell.nodataView.alpha = 1.0;
            cell.nodataLabel.text = @"您还没关注任何宝宝";
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        return cell;
    }else if(section == 3){
        BBQAttentionClassCell *cell =[tableView dequeueReusableCellWithIdentifier:@"babyAttentionClassCell"];
        cell.curBaobao = self.classinfos[indexPath.row];
        return cell;
    }else{
        BBQCreateBBCell *cell =[tableView dequeueReusableCellWithIdentifier:@"babyCreateCell"];
        cell.delegate = self;
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 1:{
            if (self.crebabies.count==0) return;
            TheCurBaoBao = self.crebabies[indexPath.row];
        }
            break;
        case 2:{
            if (self.attbabies.count==0) return;
            TheCurBaoBao = self.attbabies[indexPath.row];
        }break;
        case 3:{
            if (self.classinfos.count==0) return;
            BBQAttentionClassWithBaby *baby = self.classinfos[indexPath.row];
            NSString *baobaouid =nil;
            NSRange range = [baby.uid rangeOfString:@","];
            if (range.length >0) {
                baobaouid = [baby.uid substringToIndex:range.location];
            }else{
                baobaouid = baby.uid;
            }
            for (BBQBabyModel *model in TheCurUser.baobaodata)
                if ([model.uid.stringValue isEqualToString:baobaouid]) {
                    TheCurBaoBao = model;
                    if (self.didSelectClassBlock) {
                        self.didSelectClassBlock(baby.classmodel.classname);
                    }
                    break;
                }
        }break;
        default:
            return;
            break;
    }
    if (self.type == BBQAttentionViewTypeNormal) {
        if (((UITabBarController*)([UIApplication sharedApplication].keyWindow.rootViewController)).selectedIndex !=0) {
            ((UITabBarController*)([UIApplication sharedApplication].keyWindow.rootViewController)).selectedIndex =0;
        }
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [((AppDelegate *)[UIApplication sharedApplication].delegate)
         setupTabBarController];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section ==0) {
        return 0;
    }else
        return 50;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
        headerView.backgroundColor = UIColorHex(eeeeee);;
        UILabel *label = [[UILabel alloc] init];
        [headerView addSubview:label];
        NSString *imageName = nil;
        switch (section) {
            case 1:
                label.text = @"已创建的宝宝";
                imageName =@"create";
                break;
            case 2:
                label.text = @"已关注的宝宝";
                imageName =@"attentionBB";
                break;
            case 3:
                label.text = @"已加入的班级";
                imageName =@"joinin";
                break;
            default:
                break;
        }
        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(15, 15, imageView.size.width, imageView.size.height);
        label.frame = CGRectMake(CGRectGetMaxX(imageView.frame) + 15, 15, 150, 20);
        [headerView addSubview:imageView];
        return headerView;
    }else{
        return nil;
    }
}
- (IBAction)sureClick {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"baobaouid"] =self.deletemodel.uid;
    [BBQHTTPRequest
     queryWithType:BBQHTTPRequestTypeCancelBaobao
     param:params
     successHandler:^(AFHTTPRequestOperation *operation,
                      NSDictionary *responseObject, bool apiSuccess) {
         [TheCurUser deleteABaby:self.deletemodel];
         if (TheCurBaoBao == self.deletemodel) {
             TheCurBaoBao = [TheCurUser.baobaodata firstObject];
         }
         [self setupData];
     } errorHandler:nil
     failureHandler:nil];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.coverView.alpha = 0.0;
    }];
}
- (IBAction)cancelClick {
    [UIView animateWithDuration:0.5 animations:^{
        self.coverView.alpha = 0.0;
    }];
}
-(void)createBBCell:(BBQCreateBBCell *)cell DidClickViewWithTag:(NSInteger)tag{
    if (tag ==100) {
        [self pushTobabyDataCreateVC];
    }else{
        [self pushToInviteController];
    }
}
//关闭滑动返回手势
- (BOOL)fd_interactivePopDisabled {
    return (TheCurUser.baobaodata.count&&TheCurBaoBao)?NO:YES;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
