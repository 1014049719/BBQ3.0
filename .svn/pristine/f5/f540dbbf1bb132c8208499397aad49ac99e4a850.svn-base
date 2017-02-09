//
//  BBQPublishStatusBar.m
//  BBQ
//
//  Created by 朱琨 on 15/12/21.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQPublishStatusBar.h"
#import "UploadRecordViewController.h"
#import "BBQPublishManager.h"
#import <Masonry.h>

@interface BBQPublishStatusBar ()

@property (strong, nonatomic) UIImageView *arrowImageView;
@property (assign, nonatomic, getter = isShow) BOOL show;

@end

@implementation BBQPublishStatusBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorHex(ffba00);
        self.alpha = 0.8;
        _statusLabel = [UILabel new];
        [self addSubview:_statusLabel];
        _statusLabel.textColor = [UIColor whiteColor];
        _statusLabel.font = [UIFont systemFontOfSize:14];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        @weakify(self)
        [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.center.equalTo(self);
        }];
        
        [[BBQPublishManager sharedManager] bk_addObserverForKeyPath:@"working" options:NSKeyValueObservingOptionNew task:^(id obj, NSDictionary *change) {
            if ([change[@"new"] boolValue]) {
                @strongify(self)
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePublishDynamicNotification:) name:kPublishDynamicNotification object:nil];
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePublishDynamicNotification:) name:kCancelPublishDynamicNotification object:nil];
            }
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
            @strongify(self)
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Common" bundle:nil];
            UploadRecordViewController *urvc =
            [sb instantiateViewControllerWithIdentifier:@"UploadRecordVC"];
            [self.vc.navigationController pushViewController:urvc animated:YES];
        }];
        [self addGestureRecognizer:tap];
        self.hidden = YES;
    }
    return self;
}

- (void)handlePublishDynamicNotification:(NSNotification *)notification {
    Dynamic *dynamic = notification.object;
    if (!dynamic.fb_flag) {
        @weakify(self)
        [Dynamic dynamicsNeedUploadWithCompletion:^(NSArray *dynamics) {
            @strongify(self)
            if (dynamics.count) {
                self.hidden = NO;
                NSInteger uploadingCount = 0;
                NSInteger failedCount = 0;
                for (Dynamic *dynamic in dynamics) {
                    if (dynamic.uploadState == BBQDynamicUploadStateFail) {
                        failedCount++;
                    } else {
                        uploadingCount++;
                    }
                }
                if (uploadingCount) {
                    self.statusLabel.text = [NSString stringWithFormat:@"%@条动态正在上传中", @(uploadingCount)];
                } else {
                    self.statusLabel.text = [NSString stringWithFormat:@"%@条动态上传失败", @(failedCount)];
                }
            } else {
                self.hidden = YES;
            }
        }];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
