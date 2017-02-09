//
//  CreateAnnouncementTableViewController.m
//  BBQ
//
//  Created by slovelys on 15/10/9.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "CreateAnnouncementTableViewController.h"
#import "TitleCell.h"
#import "ContentCell.h"
#import "PhotoCell.h"
#import "CreateToCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import <QiniuSDK.h>
#import "UIImage+Scale.h"
#import <BlocksKit+UIKit.h>
#import "UIImage+FixOrientation.h"
#import "QBAssetsViewController.h"
#import "QBImagePickerController.h"
#import "Dynamic.h"

@interface CreateAnnouncementTableViewController () <QBImagePickerControllerDelegate>

@property(strong, nonatomic) GCPlaceholderTextView *titleTextView;

@property(strong, nonatomic) GCPlaceholderTextView *contentTextView;
/// 照片数组
@property(strong, nonatomic) NSMutableArray *photosArray;
/// 拍照数组
@property(strong, nonatomic) NSMutableArray *takephotosArrary;

@property(strong, nonatomic) NSMutableArray *selectedAssetURLs;
/// 日志栏目ID
@property(copy, nonatomic) NSString *classID;
/// 日志栏目所属用户ID
@property(copy, nonatomic) NSString *spaceuid;
/// 栏目名称
@property (copy, nonatomic) NSString *classuname;
/// 图片信息
@property(copy, nonatomic) NSString *photoInfo;
/// 保存图片信息数组
@property(strong, nonatomic) NSMutableArray *photoInfoAry;
/// 保存图片信息数组
@property(strong, nonatomic) NSMutableArray *alassetAry;

@property (strong, nonatomic) Dynamic *dynamic;

@end

@implementation CreateAnnouncementTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    //    self.navigationItem.title = @"编辑";
    
    self.title = self.annName;
    
    UIBarButtonItem *rightItem =
    [[UIBarButtonItem alloc] initWithTitle:@"发表"
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(rightItemEvent:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    if (TheCurUser.announcementTypes == nil ||
        TheCurUser.announcementTypes.count == 0) {
        [CommonFunc getAnnouncementType];
    }
    
    [self initValues];
    
    _dynamic = [Dynamic new];
}

- (void)initValues {
    self.photosArray = [NSMutableArray arrayWithCapacity:0];
    self.takephotosArrary = [NSMutableArray arrayWithCapacity:0];
    self.selectedAssetURLs = [NSMutableArray arrayWithCapacity:0];
    self.photoInfoAry = [NSMutableArray arrayWithCapacity:0];
    self.alassetAry = [NSMutableArray array];
}
#pragma mark - 发表按钮点击事件
- (void)rightItemEvent:(UIBarButtonItem *)sender {
    [TheCurUser.announcementTypes
     enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx,
                                  BOOL *stop) {
         if ([self.title isEqualToString:dic[@"classname"]]) {
             self.classID = [NSString stringWithFormat:@"%@", dic[@"classid"]];
             self.spaceuid = [NSString stringWithFormat:@"%@", dic[@"uid"]];
             self.classuname = [NSString stringWithFormat:@"%@", dic[@"classname"]];
             *stop = YES;
         }
     }];
    if (self.classID && self.spaceuid) {
        if (self.titleTextView.text.length == 0) {
            [SVProgressHUD showInfoWithStatus:@"请输入标题"];
        } else if (self.contentTextView.text.length == 0) {
            [SVProgressHUD showInfoWithStatus:@"请输入内容"];
        } else {
            if (self.photosArray && self.photosArray.count > 0) {
                
                [self postPhotoToQiniuWithPhotoAry:self.photosArray];
                
            } else {
                [self postAnnouncement];
            }
        }
    } else {
        [CommonFunc showAlertView:@"获取发表到栏目出错"];
    }
}

#pragma mark - 上传图片到七牛
- (void)postPhotoToQiniuWithPhotoAry:(NSArray *)ary {
    [SVProgressHUD showWithStatus:@"请稍候"];
    __block int i = 0;
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    
    for (Attachment *att in self.photosArray) {
        [upManager
         putFile:att.filepath
         key:nil
         token:TheCurUser.qntoken
         complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
             if (info.statusCode == 200) {
                 NSString *infoStr =
                 [NSString stringWithFormat:@"http://%@/%@", TheCurUser.qndns,
                  resp[@"key"]];
                 [self.photoInfoAry addObject:infoStr];
                 [att deleteLocalFile];
                 att.filepath = infoStr;
                 att.height = resp[@"height"];
                 att.width = resp[@"width"];
                 att.remote = @2;
                 i++;
                 if (i == self.photosArray.count) {
                     [self performSelector:@selector(postAnnouncement) withObject:nil];
                 }
             } else {
                 [SVProgressHUD dismiss];
                 [self.photoInfoAry removeAllObjects];
                 UIAlertView *alert = [UIAlertView
                                       bk_showAlertViewWithTitle:
                                       @"提示" message:@"图片上传失败，请重新上传"
                                       cancelButtonTitle:@"取消"
                                       otherButtonTitles:@[ @"重新上传" ]
                                       handler:^(UIAlertView *alertView,
                                                 NSInteger buttonIndex) {
                                           if (buttonIndex == 1) {
                                               [self rightItemEvent:nil];
                                           }
                                       }];
                 [alert show];
             }
             
         } option:nil];
    }
}
// 压缩图片
- (NSData *)compressIamge:(UIImage *)image {
    UIImage *imageSave;
    CGFloat maxsize = 320; //小边限制为640或1400
    
    if (image.size.height > maxsize &&
        image.size.height < image.size.width) { // height为小边
        CGFloat fScale = maxsize / image.size.height;
        CGFloat fWidth = image.size.width * fScale;
        imageSave = [image scaleToSize:CGSizeMake(fWidth, maxsize)];
    } else if (image.size.width > maxsize &&
               image.size.width < image.size.height) { // width为小边
        CGFloat fScale = maxsize / image.size.width;
        CGFloat fHeight = image.size.height * fScale;
        imageSave = [image scaleToSize:CGSizeMake(maxsize, fHeight)];
    } else {
        imageSave = image;
    }
    return UIImagePNGRepresentation(imageSave);
}

#pragma mark - 发布公告
- (void)postAnnouncement {
    [SVProgressHUD showWithStatus:@"请稍候"];
    // 替换换行符
    NSString *str = self.contentTextView.text;
    NSString *contentStr;
    contentStr =
    [str stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];
    NSString *postStr =
    [contentStr stringByReplacingOccurrencesOfString:@" "
                                          withString:@"&nbsp"];
    if (self.photoInfoAry && self.photoInfoAry.count > 0) {
        for (NSString *str in self.photoInfoAry) {
            NSString *imgStr =
            [NSString stringWithFormat:@"<div><img src=%@></div><br><br>", str];
            postStr = [postStr stringByAppendingString:imgStr];
        }
    }
    NSArray *attachinfo = [self.photosArray bk_map:^id(Attachment *obj) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"itype"] = obj.itype;
        dic[@"filepath"] = obj.filepath;
        dic[@"remote"] = obj.remote;
        dic[@"width"] = obj.width;
        dic[@"height"] = obj.height;
        dic[@"graphtime"] = obj.graphtime;
        if (obj.data) {
            dic[@"data"] = obj.data;
        }
        return dic;
    }];
    NSDictionary *para = @{
                           @"attachinfo" : attachinfo ?: @"",
                           @"subject" : self.titleTextView.text,
                           @"message" : postStr,
                           @"classid" : self.classID,
                           @"spaceuid" : self.spaceuid,
                           @"localid" : [NSString stringWithUUID]
                           };
    
    
    [BBQHTTPRequest queryWithType:BBQHTTPRequestTypeCreateAnnouncement
                            param:para
        constructingBodyWithBlock:nil
                   successHandler:^(AFHTTPRequestOperation *operation,
                                    NSDictionary *responseObject, bool apiSuccess) {
                       NSLog(@"%@", responseObject);
                       [SVProgressHUD dismiss];
                       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                           if ([self.classuname isEqualToString:@"布置作业"]) {
                               [MTA trackCustomKeyValueEvent:kMTAHomeworkTimes props:@{ @"homework_times" : @1 }];
                           } else if ([self.classuname isEqualToString:@"班级公告"]) {
                               [MTA trackCustomKeyValueEvent:KMTAPostAnnouncement props:@{ @"announcement" : @1 }];
                           } else if ([self.classuname isEqualToString:@"教职工公告"]) {
                               [MTA trackCustomKeyValueEvent:KMTAMasterPostStaffAnn props:@{ @"ann_staff" : @1 }];
                           } else if ([self.classuname isEqualToString:@"校园公告"]) {
                               [MTA trackCustomKeyValueEvent:kMTAMasterPostSchoolAnn props:@{ @"school" : @1 }];
                           }
                       });
                       if (self.block) {
                           self.block(YES);
                           [self.navigationController popViewControllerAnimated:YES];
                       }
                   }
                     errorHandler:^(NSDictionary *responseObject) {
                         [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
                     }
                   failureHandler:nil
                   successMessage:nil
                     errorMessage:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell =
        (TitleCell *)[tableView dequeueReusableCellWithIdentifier:@"TitleCell"
                                                     forIndexPath:indexPath];
        self.titleTextView = ((TitleCell *)cell).TitleTextView;
    } else if (indexPath.section == 1) {
        cell = (ContentCell *)
        [tableView dequeueReusableCellWithIdentifier:@"ContentCell"
                                        forIndexPath:indexPath];
        self.contentTextView = ((ContentCell *)cell).contentTextView;
    } else if (indexPath.section == 2) {
        cell =
        (PhotoCell *)[tableView dequeueReusableCellWithIdentifier:@"PhotoCell"
                                                     forIndexPath:indexPath];
        
        NSArray *views = [cell.contentView subviews];
        if (views) {
            for (UIView *subview in views)
                [subview removeFromSuperview];
        }
        
        CGFloat screen_width = [[UIScreen mainScreen] bounds].size.width;
        CGFloat left_margin = 10, rigth_margin = 10,
        top_margin = 10; //,bottom_margin = 10;
        CGFloat vertical_interval = 5, horizontal_interval = 5;
        
        CGFloat photo_width =
        (screen_width - left_margin - rigth_margin - 3 * horizontal_interval) /
        4; //四个图片
        CGFloat photo_height = photo_width;
        
        for (int jj = 0;
             jj < self.photosArray.count + self.takephotosArrary.count + 1; jj++) {
            CGFloat x = left_margin + (jj % 4) * (photo_width + horizontal_interval);
            CGFloat y = top_margin + (jj / 4) * (photo_height + vertical_interval);
            
            UIImageView *imgview = [[UIImageView alloc]
                                    initWithFrame:CGRectMake(x, y, photo_width, photo_height)];
            [cell.contentView addSubview:imgview];
                        //先放照片的
            if (jj < self.photosArray.count) {
                Attachment *att = self.photosArray[jj];
                [imgview setImageURL:att.filepathURL];
            } else {
                imgview.image = [UIImage imageNamed:@"upload_m"];
            }
            if (jj == self.photosArray.count + self.takephotosArrary.count) {
                //添加按钮
                UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                button.frame = CGRectMake(x, y, photo_width, photo_height);
                [button addTarget:self
                           action:@selector(addButton:)
                 forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:button];
            } else {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(x + photo_width - 35, y, 35, 35);
                button.tag = 1000 + jj;
                [button addTarget:self
                           action:@selector(delButton:)
                 forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:button];
                
                UIImageView *delview = [[UIImageView alloc]
                                        initWithFrame:CGRectMake(x + photo_width - 19, y, 19, 19)];
                delview.image = [UIImage imageNamed:@"photo_deselect"];
                [cell.contentView addSubview:delview];
            }
        }
        
    } else {
        cell = (CreateToCell *)
        [tableView dequeueReusableCellWithIdentifier:@"CreateToCell"
                                        forIndexPath:indexPath];
        
        ((CreateToCell *)cell).createToLabel.text = self.annName;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 60;
    } else if (indexPath.section == 1) {
        return 150;
    } else if (indexPath.section == 2) {
        CGFloat screen_width = [[UIScreen mainScreen] bounds].size.width;
        CGFloat left_margin = 10, rigth_margin = 10, top_margin = 10,
        bottom_margin = 10;
        CGFloat vertical_interval = 5, horizontal_interval = 5;
        
        CGFloat photo_width =
        (screen_width - left_margin - rigth_margin - 3 * horizontal_interval) /
        4; //四个图片
        CGFloat photo_height = photo_width;
        
        CGFloat cellrows =
        (self.photosArray.count + self.takephotosArrary.count + 1) / 4 +
        ((self.photosArray.count + self.takephotosArrary.count + 1) % 4 > 0
         ? 1
         : 0); //要加上添加按钮
        CGFloat cell_height = top_margin + bottom_margin + photo_height * cellrows +
        (cellrows - 1) * vertical_interval;
        
        return cell_height;
    } else {
        return 43;
    }
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    //    if (section == 0) {
    //        return 5;
    //    } else if (section == 1) {
    //        return 5;
    //    }
    return 2;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.titleTextView resignFirstResponder];
    [self.contentTextView resignFirstResponder];
}

- (void)addButton:(UIButton *)btn {
    if (self.photosArray.count == 9) {
        [SVProgressHUD showInfoWithStatus:@"最多只能选择9张照片哦"];
        return;
    }
    QBImagePickerController *imagePicker = [[QBImagePickerController alloc] initWithFilterType:QBImagePickerControllerFilterTypePhotos];
    imagePicker.delegate = self;
    imagePicker.allowsMultipleSelection = YES;
    imagePicker.maximumNumberOfSelection = 9 - self.photosArray.count;
    [self.navigationController
     pushViewController:imagePicker
     animated:YES];
}

#pragma mark - QBImagePickerControllerDelegate
- (void)qb_imagePickerController:
(QBImagePickerController *)imagePickerController
            didSelectAttachments:(NSArray *)attachments selectedAssetURLs:(NSMutableArray *)selectedAssetURLs {
    [imagePickerController.navigationController popViewControllerAnimated:YES];
    [self.photosArray addObjectsFromArray:attachments];
    [self.selectedAssetURLs addObjectsFromArray:selectedAssetURLs];
    [self.tableView reloadData];
}

- (NSArray *)preSelectedAssetURLs {
    return self.selectedAssetURLs;
}

- (void)delButton:(UIButton *)btn {
    int jj = (int)btn.tag - 1000;
    
    if (jj < self.photosArray.count) {
        Attachment *att = self.photosArray[jj];
        [att deleteLocalFile];
        [self.photosArray removeObjectAtIndex:jj];
        [self.selectedAssetURLs removeObjectAtIndex:jj];
    }
    
    
    [self.tableView reloadData];
}

//上传动态图片
- (void)uploadBBQDynaAttachFile:(NSString *)strFileName
                        localid:(NSString *)strLocalId {
    @weakify(self)
    [[QNUploadManager sharedInstanceWithConfiguration:nil] putFile:strFileName key:nil token:TheCurUser.qntoken complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        @strongify(self)
        if (info.isOK) {
            NSString *strFilePath =
            [NSString stringWithFormat:@"http://%@/%@", TheCurUser.qndns, resp[@"key"]];
            self.photoInfo = strFilePath;
        } else {
            [SVProgressHUD showErrorWithStatus:@"附件上传失败"];
        }
    } option:nil];
}

-(void)setupAlassetAry{
    for (id asset in self.photosArray) {
        if ([asset isKindOfClass:[PHAsset class]]) {
            PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
            options.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
            options.synchronous = YES;
            [[PHImageManager defaultManager]
             requestImageForAsset:asset
             targetSize:CGSizeMake([(PHAsset *)asset pixelWidth],
                                   [(PHAsset *)asset pixelHeight])
             contentMode:PHImageContentModeDefault
             options:options
             resultHandler:^(UIImage *result, NSDictionary *info) {
                 [self.alassetAry addObject: result];
             }];
            
        } else if ([asset isKindOfClass:[ALAsset class]]) {
            [self.alassetAry addObject:[UIImage imageWithCGImage:[(ALAsset *)asset defaultRepresentation]
                                        .fullScreenImage]];
        }
    }
}

@end
