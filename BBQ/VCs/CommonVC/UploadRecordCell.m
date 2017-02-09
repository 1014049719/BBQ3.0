//
//  UploadRecordCell.m
//  BBQ
//
//  Created by anymuse on 15/8/19.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "UploadRecordCell.h"
#import "AppMacro.h"


@interface UploadRecordCell ()
@property(weak, nonatomic) IBOutlet NSLayoutConstraint *leadingCons;
@property(weak, nonatomic) IBOutlet NSLayoutConstraint *widthCons;

@end

@implementation UploadRecordCell

- (void)setModel:(Dynamic *)model {
    _model = model;
    switch (model.uploadState) {
        case BBQDynamicUploadStateSuccess: {
            self.statusLabel.text = @"上传成功";
            self.statusLabel.textColor = [UIColor greenColor];
            break;
        }
            
        case BBQDynamicUploadStateUploading: {
            self.statusLabel.text = @"上传中";
            self.statusLabel.textColor = UIColorHex(333333);
            break;
        }
        case BBQDynamicUploadStateFail: {
            self.statusLabel.text = @"上传失败";
            self.statusLabel.textColor = [UIColor redColor];
            break;
        }
        case BBQDynamicUploadStateWaiting: {
            self.statusLabel.text = @"等待上传";
            self.statusLabel.textColor = UIColorHex(ff6440);
            break;
        }
    }
    
    self.contentLabel.text = model.content;
    if (model.attachinfo.count) {
        self.leadingCons.constant = 15;
        self.widthCons.constant = 60;
        Attachment *photoModel = model.attachinfo.firstObject;
        NSURL *url;
        if (photoModel.remote.integerValue == BBQAttachmentRemoteTypeLocal) {
            url = [[NSURL alloc] initFileURLWithPath:photoModel.filepath];
        } else {
            url = [NSURL URLWithString:photoModel.filepath];
        }
        @weakify(self)
        [self.photoView setImageWithURL:url placeholder:[UIImage imageNamed:@"placeholder_white_loading"] options:YYWebImageOptionSetImageWithFadeAnimation completion:^(UIImage *image, NSURL *url, YYWebImageFromType from, YYWebImageStage stage, NSError *error) {
            @strongify(self)
            if (error) {
                self.photoView.image = [UIImage imageNamed:@"placeholder_white_error"];
            }
        }];
    } else {
        self.leadingCons.constant = 0;
        self.widthCons.constant = 0;
    }
}

@end
