//
//  UIImage-icon.m
//  CallShow
//
//  Created by Qiliang Shen on 09-4-14.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UIImage-icon.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIImage (icon)
- (UIImage *)iconImageWithWidth:(double)width
                   cornerRadius:(double)radius
                         border:(double)border
                    borderColor:(UIColor *)color {
  //	UIGraphicsBeginImageContext(CGSizeMake(width,width));
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  CGContextRef context = CGBitmapContextCreate(
      nil, width, width, 8, 0, colorSpace, kCGImageAlphaPremultipliedFirst);
  CGColorSpaceRelease(colorSpace);
  CGSize imgSize = self.size;
  CGFloat mid = width / 2;
  // CGContextRef context = UIGraphicsGetCurrentContext();

  CGContextMoveToPoint(context, 0, mid);
  CGContextAddArcToPoint(context, 0, 0, mid, 0, radius);
  CGContextAddArcToPoint(context, width, 0, width, mid, radius);
  CGContextAddArcToPoint(context, width, width, mid, width, radius);
  CGContextAddArcToPoint(context, 0, width, 0, mid, radius);
  CGContextClosePath(context);
  CGContextClip(context);
  CGContextSetStrokeColorWithColor(context, color.CGColor);

  CGContextMoveToPoint(context, 0, mid);
  CGContextAddArcToPoint(context, 0, 0, mid, 0, radius);
  CGContextAddArcToPoint(context, width, 0, width, mid, radius);
  CGContextAddArcToPoint(context, width, width, mid, width, radius);
  CGContextAddArcToPoint(context, 0, width, 0, mid, radius);
  CGContextClosePath(context);
  CGContextSetLineWidth(context, border);

  if (imgSize.width > imgSize.height) {
    double rate = imgSize.width / imgSize.height;
    CGContextDrawImage(context, CGRectMake(floor(-(rate - 1) / 2 * width), 0,
                                           floor(rate * width), floor(width)),
                       self.CGImage);
    //[self drawInRect:CGRectMake(floor(-(rate-1)/2*width), 0,
    //floor(rate*width), floor(width))];
  } else {
    double rate = imgSize.height / imgSize.width;
    CGContextDrawImage(context, CGRectMake(0, floor(-(rate - 1) / 2 * width),
                                           floor(width), floor(rate * width)),
                       self.CGImage);

    //[self drawInRect:CGRectMake(0, floor(-(rate-1)/2*width), floor(width),
    //floor(rate*width))];
  }
  CGContextStrokePath(context);
  CGImageRef cgimg = CGBitmapContextCreateImage(
      context); // UIGraphicsGetImageFromCurrentImageContext();
  UIImage *img = [UIImage imageWithCGImage:cgimg];
  if (cgimg)
    CGImageRelease(cgimg);
  CGContextRelease(context);
  //	UIGraphicsEndImageContext();
  return img;
}
- (UIImage *)iconImageWithWidth:(double)width cornerRadius:(double)radius {
  return [self iconImageWithWidth:width
                     cornerRadius:radius
                           border:0.0
                      borderColor:[UIColor clearColor]];
}
@end
