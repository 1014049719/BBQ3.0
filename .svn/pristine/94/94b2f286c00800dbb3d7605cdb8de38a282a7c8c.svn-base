//
//  MJZoomingScrollView.m
//
//  Created by mj on 13-3-4.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MJPhotoView.h"
#import "MJPhoto.h"
#import "MJPhotoLoadingView.h"
#import <QuartzCore/QuartzCore.h>
#import "YLGIFImage.h"
#import "YLImageView.h"
#import "UIImage+Common.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface MJPhotoView ()

@property (assign, nonatomic) BOOL zoomByDoubleTap;
@property (strong, nonatomic) YLImageView *imageView;
@property (strong, nonatomic) MJPhotoLoadingView *photoLoadingView;

@end

@implementation MJPhotoView

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.clipsToBounds = YES;
        // 图片
        _imageView = [[YLImageView alloc] init];
        _imageView.backgroundColor = kColorTableBG;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageView];
        
        // 进度条
        _photoLoadingView = [[MJPhotoLoadingView alloc] init];
        
        // 属性
        self.delegate = self;
        //		self.showsHorizontalScrollIndicator = NO;
        //		self.showsVerticalScrollIndicator = NO;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.autoresizingMask =
        UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        // 监听点击
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self
                                             action:@selector(handleSingleTap:)];
        singleTap.delaysTouchesBegan = YES;
        singleTap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:singleTap];
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self
                                             action:@selector(handleDoubleTap:)];
        doubleTap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubleTap];
        
        [singleTap requireGestureRecognizerToFail:doubleTap];
    }
    return self;
}

//设置imageView的图片
- (void)configImageViewWithImage:(UIImage *)image {
    _imageView.image = image;
}

#pragma mark - photoSetter
- (void)setPhoto:(MJPhoto *)photo {
    _photo = photo;
    
    [self showImage];
}

#pragma mark 显示图片
- (void)showImage {
    [self photoStartLoad];
    [self adjustFrame];
}

#pragma mark 开始加载图片
- (void)photoStartLoad {
    if (_photo.image) {
        [_photoLoadingView removeFromSuperview];
        _imageView.image = _photo.image;
        self.scrollEnabled = YES;
    } else {
        _imageView.image = [UIImage imageNamed:@"placeholder_black_loading"];
        self.scrollEnabled = NO;
        // 直接显示进度条
        [_photoLoadingView showLoading];
        [self addSubview:_photoLoadingView];
        if ([_photo.url.absoluteString hasPrefix:@"http"]) {
            @weakify(self)
            [[YYWebImageManager sharedManager] requestImageWithURL:_photo.url
                                                           options:YYWebImageOptionShowNetworkActivity
                                                          progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                              @strongify(self)
                                                              if (receivedSize > kMinProgress) {
                                                                  self.photoLoadingView.progress = (float)receivedSize / expectedSize;
                                                              }
                                                          }
                                                         transform:nil
                                                        completion:^(UIImage *image, NSURL *url, YYWebImageFromType from,
                                                                     YYWebImageStage stage, NSError *error) {
                                                            @strongify(self)
                                                            dispatch_async_on_main_queue(^{
                                                                self.imageView.image = image;
                                                                [self photoDidFinishLoadWithImage:image];
                                                            });
                                                        }];
        } else {
            ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
            [assetsLibrary assetForURL:_photo.url resultBlock:^(ALAsset *asset) {
                UIImage *image = [UIImage fullScreenImageALAsset:asset];
                self.imageView.image = image;
                [self photoDidFinishLoadWithImage:image];
            } failureBlock:^(NSError *error) {
                [self photoDidFinishLoadWithImage:nil];
            }];
        }
        
    }
}

#pragma mark 加载完毕
- (void)photoDidFinishLoadWithImage:(UIImage *)image {
    [_photoLoadingView removeFromSuperview];
    if (image) {
        self.scrollEnabled = YES;
        _photo.image = image;
        if ([self.photoViewDelegate
             respondsToSelector:@selector(photoViewImageFinishLoad:)]) {
            [self.photoViewDelegate photoViewImageFinishLoad:self];
        }
    } else {
        _imageView.image = [UIImage imageNamed:@"placeholder_black_error"];
    }
    // 设置缩放比例
    [self adjustFrame];
}
#pragma mark 调整frame
- (void)adjustFrame {
    if (_imageView.image == nil)
        return;
    
    // 基本尺寸参数
    CGFloat boundsWidth = self.bounds.size.width;
    CGFloat boundsHeight = self.bounds.size.height;
    CGFloat imageWidth = _imageView.image.size.width;
    CGFloat imageHeight = _imageView.image.size.height;
    
    // 设置伸缩比例
    CGFloat imageScale = boundsWidth / imageWidth;
    CGFloat minScale = MIN(1.0, imageScale);
    
    CGFloat maxScale = 4.0;
    if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
        maxScale = maxScale / [[UIScreen mainScreen] scale];
        if (maxScale < minScale) {
            maxScale = minScale * 2;
        }
    }
    self.maximumZoomScale = maxScale;
    self.minimumZoomScale = minScale;
    self.zoomScale = minScale;
    
    CGRect imageFrame =
    CGRectMake(0, MAX(0, (boundsHeight - imageHeight * imageScale) / 2),
               boundsWidth, imageHeight * imageScale);
    
    self.contentSize =
    CGSizeMake(CGRectGetWidth(imageFrame), CGRectGetHeight(imageFrame));
    _imageView.frame = imageFrame;
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    if (_zoomByDoubleTap) {
        CGFloat insetY =
        (CGRectGetHeight(self.bounds) - CGRectGetHeight(_imageView.frame)) / 2;
        insetY = MAX(insetY, 0.0);
        if (ABS(_imageView.frame.origin.y - insetY) > 0.5) {
            [_imageView setY:insetY];
        }
    }
    return _imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView
                       withView:(UIView *)view
                        atScale:(CGFloat)scale {
    _zoomByDoubleTap = NO;
    CGFloat insetY =
    (CGRectGetHeight(self.bounds) - CGRectGetHeight(_imageView.frame)) / 2;
    insetY = MAX(insetY, 0.0);
    if (ABS(_imageView.frame.origin.y - insetY) > 0.5) {
        [UIView animateWithDuration:0.2
                         animations:^{
                             [_imageView setY:insetY];
                         }];
    }
}

#pragma mark - 手势处理
//单击隐藏
- (void)handleSingleTap:(UITapGestureRecognizer *)tap {
    // 移除进度条
    [_photoLoadingView removeFromSuperview];
    
    // 通知代理
    if ([self.photoViewDelegate
         respondsToSelector:@selector(photoViewSingleTap:)]) {
        [self.photoViewDelegate photoViewSingleTap:self];
    }
}
//双击放大
- (void)handleDoubleTap:(UITapGestureRecognizer *)tap {
    _zoomByDoubleTap = YES;
    
    if (self.zoomScale == self.maximumZoomScale) {
        [self setZoomScale:self.minimumZoomScale animated:YES];
    } else {
        CGPoint touchPoint = [tap locationInView:self];
        CGFloat scale = self.maximumZoomScale / self.zoomScale;
        CGRect rectTozoom =
        CGRectMake(touchPoint.x * scale, touchPoint.y * scale, 1, 1);
        [self zoomToRect:rectTozoom animated:YES];
    }
}

- (void)dealloc {
    // 取消请求
    [_imageView cancelCurrentImageRequest];
}
@end