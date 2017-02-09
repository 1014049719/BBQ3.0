//
//  BBQDynamicEditMediaCell.m
//  BBQ
//
//  Created by 朱琨 on 15/12/4.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "Attachment.h"
#import "BBQDynamicEditMediaCell.h"
#import <AssetsLibrary/AssetsLibrary.h>

NSString *const kDynamicEditMediaIdentifier = @"DynamicEditMediaCell";

@interface BBQDynamicEditMediaCell ()
@property(weak, nonatomic) IBOutlet UIImageView *videoPlayImageView;

@end

@implementation BBQDynamicEditMediaCell

- (void)awakeFromNib {
    self.layer.contentMode = UIViewContentModeScaleAspectFill;
}

- (IBAction)didClickDeselectButton:(id)sender {
    if (self.deselectMedia) {
        self.videoPlayImageView.hidden = YES;
        self.deselectMedia(_attach);
    }
}

- (void)setAttach:(Attachment *)attach {
    _attach = attach;
    [self.layer cancelCurrentImageRequest];
    if (attach.itype.integerValue == BBQAttachmentTypePhoto) {
        self.videoPlayImageView.hidden = YES;
        if (attach.assetURL) {
            [self setImageWithURL:attach.assetURL];
        } else {
            @weakify(self)[self.layer
                           setImageWithURL:[NSURL URLWithString:attach.filepath]
                           placeholder:[UIImage imageNamed:@"placeholder_white_loading"]
                           options:YYWebImageOptionSetImageWithFadeAnimation
                           completion:^(UIImage *image, NSURL *url, YYWebImageFromType from,
                                        YYWebImageStage stage, NSError *error) {
                               @strongify(self) if (error) {
                                   self.layer.contents =
                                   (__bridge id)
                                   [UIImage imageNamed:@"placeholder_white_error"]
                                   .CGImage;
                               }
                           }];
        }
    } else {
        self.videoPlayImageView.hidden = NO;
        if (attach.assetURL) {
            [self setImageWithURL:attach.assetURL];
        } else {
            @weakify(self)[self.layer
                           setImageWithURL:[NSURL URLWithString:attach.data[@"yt"][@"filepath"]]
                           placeholder:[UIImage imageNamed:@"placeholder_white_loading"]
                           options:YYWebImageOptionSetImageWithFadeAnimation
                           completion:^(UIImage *image, NSURL *url, YYWebImageFromType from,
                                        YYWebImageStage stage, NSError *error) {
                               @strongify(self) if (error) {
                                   self.layer.contents =
                                   (__bridge id)
                                   [UIImage imageNamed:@"placeholder_white_error"]
                                   .CGImage;
                               }
                           }];
        }
    }
}

- (void)setImageWithURL:(NSURL *)assetURL {
    ALAssetsLibrary *assetsLibrary = [ALAssetsLibrary new];
    [assetsLibrary assetForURL:assetURL
                   resultBlock:^(ALAsset *asset) {
                       if (asset) {
                           self.layer.contents = (__bridge id)asset.thumbnail;
                       } else {
                           [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupPhotoStream
                                                        usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                                                            [group
                                                             enumerateAssetsWithOptions:NSEnumerationReverse
                                                             usingBlock:^(ALAsset *result,
                                                                          NSUInteger index, BOOL *stop) {
                                                                 if ([result.defaultRepresentation.url
                                                                      isEqual:assetURL]) {
                                                                     self.layer.contents =
                                                                     (__bridge id)asset.thumbnail;
                                                                     *stop = YES;
                                                                 }
                                                             }];
                                                        }
                                                      failureBlock:^(NSError *error) {
                                                          NSLog(@"Error: %@", [error localizedDescription]);
                                                      }];
                       }
                   }
                  failureBlock:^(NSError *error) {
                      NSLog(@"Error: %@", [error localizedDescription]);
                  }];
}

+ (CGFloat)cellWidth {
    return (kScreenWidth - 5 * 15) / 4.0;
}

@end
