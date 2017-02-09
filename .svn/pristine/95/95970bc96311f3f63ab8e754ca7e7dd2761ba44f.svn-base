//
//  UIImage+Scale.h
//  ZiWi
//
//  Created by mengwutian on 11-9-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIImage+Scale.h"
@implementation UIImage (scale)
- (UIImage *)scaleToSize:(CGSize)size {
  // 创建一个bitmap的context
  // 并把它设置成为当前正在使用的context
  UIGraphicsBeginImageContext(size);
  // 绘制改变大小的图片
  [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
  // 从当前context中创建一个改变大小后的图片
  UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
  // 使当前的context出堆栈
  UIGraphicsEndImageContext();
  // 返回新的改变大小后的图片
  return scaledImage;
}

- (UIImage *)scaleToScale:(CGFloat)scale {
  CGSize size;
  size.width = self.size.width * scale;
  size.height = self.size.height * scale;

  // 创建一个bitmap的context
  // 并把它设置成为当前正在使用的context
  UIGraphicsBeginImageContext(size);

  // 绘制改变大小的图片
  [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
  // 从当前context中创建一个改变大小后的图片
  UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
  // 使当前的context出堆栈
  UIGraphicsEndImageContext();
  // 返回新的改变大小后的图片
  return scaledImage;
}

//判断屏幕分辨率大小，从高分辨率返回低分辨率需要的一半图符
- (UIImage *)scaleToScreen {
  // UIWindow *window = [[UIApplication sharedApplication].delegate window];
  // CGRect screenRect = [[UIScreen mainScreen] bounds];
  if ([[UIScreen mainScreen] scale] > 1 || self.scale > 1) {
    return self;
  }

  CGSize size;
  size.width = self.size.width * 0.5;
  size.height = self.size.height * 0.5;

  // 创建一个bitmap的context
  // 并把它设置成为当前正在使用的context
  UIGraphicsBeginImageContext(size);

  // 绘制改变大小的图片
  [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
  // 从当前context中创建一个改变大小后的图片
  UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
  // 使当前的context出堆栈
  UIGraphicsEndImageContext();
  // 返回新的改变大小后的图片
  return scaledImage;
}

//图片平铺
- (UIImage *)scaleToRect:(CGSize)size {
  // 创建一个bitmap的context
  // 并把它设置成为当前正在使用的context
  UIGraphicsBeginImageContext(size);

  for (CGFloat i = 0;; i++) {
    CGFloat mywidth = self.size.width * i;
    if (mywidth >= size.width)
      break;
    for (CGFloat j = 0;; j++) {
      CGFloat myheight = self.size.height * j;
      if (myheight >= size.height)
        break;
      // 绘制改变大小的图片
      [self drawInRect:CGRectMake(mywidth, myheight, self.size.width,
                                  self.size.height)];
    }
  }

  // 从当前context中创建一个改变大小后的图片
  UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
  // 使当前的context出堆栈
  UIGraphicsEndImageContext();
  // 返回新的改变大小后的图片
  return scaledImage;
}

//图片裁减，裁剪某个区域的图片
- (UIImage *)cutImage:(CGRect)rect {
  // CGSize size = self.size;
  CGFloat scale = self.scale;
  if (scale >= 2.0) {
    rect.origin.x *= 2;
    rect.origin.y *= 2;
    rect.size.width *= 2;
    rect.size.height *= 2;
  }

  CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);

  UIImage *elementImage;
  if (scale < 2 ||
      [[[UIDevice currentDevice] systemVersion] floatValue] <= 4.0) {
    elementImage = [UIImage imageWithCGImage:imageRef];
  } else {
    elementImage = [UIImage imageWithCGImage:imageRef
                                       scale:scale
                                 orientation:UIImageOrientationUp];
  }
  // size = elementImage.size;

  return elementImage;
}

//图片增加透明度
- (UIImage *)UpdateImageAlpha:(CGFloat)alpha {

  CGSize size = CGSizeMake(self.size.width, self.size.height);

  UIGraphicsBeginImageContext(size);
  // Draw image1
  [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)
         blendMode:kCGBlendModeNormal
             alpha:alpha];

  UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();

  UIGraphicsEndImageContext();

  return resultingImage;
}

//合成图片的两种方法，思路都是一样的
// Image＋Image ICON
- (UIImage *)addImageview:(UIImageView *)image1 toImage:(UIImageView *)image2 {

  CGSize size = CGSizeMake(image1.frame.size.width, image1.frame.size.height);

  UIGraphicsBeginImageContext(size);

  // Draw image1
  [image2.image drawInRect:CGRectMake(6, 6, image2.frame.size.width,
                                      image2.frame.size.height)];

  // Draw image2
  [image1.image drawInRect:CGRectMake(0, 0, image1.frame.size.width,
                                      image1.frame.size.height)];

  UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();

  UIGraphicsEndImageContext();

  return resultingImage;
}

- (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 {

  CGSize size = CGSizeMake(image1.size.width, image1.size.height);

  UIGraphicsBeginImageContext(size);

  // Draw image1
  [image2 drawInRect:CGRectMake(4.5, 6, 77, 77)];

  // Draw image2
  [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];

  UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();

  UIGraphicsEndImageContext();

  return resultingImage;
}

+ (BOOL)createScreenWidthImageFile:(UIImage *)image
                          filename:(NSString *)strFilename
                             width:(CGFloat *)width
                            heigth:(CGFloat *)height {
  CGFloat fThunmWidth = 260.0;

  //生成展现看的
  CGFloat fScale = 1.0;
  CGFloat fWidth = image.size.width;
  if (image.size.width > fThunmWidth) {
    fWidth = fThunmWidth;
    fScale = fThunmWidth / image.size.width;
  }
  CGFloat fHeigth = image.size.height * fScale;
  UIImage *imageSave = [image scaleToSize:CGSizeMake(fWidth, fHeigth)];
  NSData *data1 = UIImageJPEGRepresentation(imageSave, 0.0);
  BOOL ret = [data1 writeToFile:strFilename atomically:YES];

  *width = fWidth;
  *height = fHeigth;

  return ret;
}

@end