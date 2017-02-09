//
//  UIImage+Scale.h
//  ZiWi
//
//  Created by mengwutian on 11-9-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (scale) 
-(UIImage*)scaleToSize:(CGSize)size; 

-(UIImage*)scaleToScale:(CGFloat)scale;

//判断屏幕分辨率大小，从高分辨率返回低分辨率需要的一半图符
-(UIImage*)scaleToScreen;

//图片平铺
-(UIImage*)scaleToRect:(CGSize)size;


//图片裁减，裁剪某个区域的图片
-(UIImage*)cutImage:(CGRect)rect;


//图片增加透明度
- (UIImage *)UpdateImageAlpha:(CGFloat)alpha;

//合成图片的两种方法，思路都是一样的
// Image＋Image ICON
- (UIImage *)addImageview:(UIImageView *)image1 toImage:(UIImageView *)image2;

- (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2;

+ (BOOL)createScreenWidthImageFile:(UIImage *)image filename:(NSString *)strFilename width:(CGFloat *)width heigth:(CGFloat *)height;

@end

