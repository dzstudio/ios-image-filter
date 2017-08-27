//
//  UIImage+ImageFilter.m
//  TuImageSpirit
//
//  Created by DillonZhang on 14-7-20.
//  Copyright (c) 2014 ToUnsual. All rights reserved.
//

#define SAFECOLOR(color) MIN(255, MAX(0, color))

#import "TUImageFilters.h"

@implementation TUImageFilters

/*
 通过给定的方法和参数，进行图像的处理。
 */
+ (UIImage *)applyFilter:(UIImage *)image with:(FilterFunction)filter context:(void *)context {
  CGImageRef inImage = CGImageCreateCopy([UIImage imageWithData:UIImagePNGRepresentation(image)].CGImage);
  CFDataRef m_DataRef = CGDataProviderCopyData(CGImageGetDataProvider(inImage));
  UInt8 *m_PixelBuf = (UInt8 *)CFDataGetBytePtr(m_DataRef);
  
  int length = CFDataGetLength(m_DataRef);
  
  for (int i = 0; i < length; i += 4) {
    filter(m_PixelBuf, i, context);
  }
  
  CGContextRef ctx = CGBitmapContextCreate(m_PixelBuf,
                                           CGImageGetWidth(inImage),
                                           CGImageGetHeight(inImage),
                                           CGImageGetBitsPerComponent(inImage),
                                           CGImageGetBytesPerRow(inImage),
                                           CGImageGetColorSpace(inImage),
                                           CGImageGetBitmapInfo(inImage)
                                           );
  
  CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
  CGContextRelease(ctx);
  UIImage *finalImage = [UIImage imageWithCGImage:imageRef];
  CGImageRelease(imageRef);
  CFRelease(m_DataRef);
  
  return finalImage;
}

/*
 调用透明度的方法进行透明度的调节。0到1之间调节。
 */
+ (UIImage *)changeOpacity:(UIImage *)image byFactor:(double)factor {
  return [self applyFilter:image with:filterOpacity context:&factor];
}

/*
 调节图片亮度，1为正常亮度。低于1变暗，大于1变亮。
 */
+ (UIImage *)changeBrightness:(UIImage *)image byFactor:(double)factor {
  return [self applyFilter:image with:filterBrightness context:&factor];
}

/*
 调节图片色彩饱和度。1为正常值。
 */
+ (UIImage *)changeSaturation:(UIImage *)image byFactor:(double)factor {
  return [self applyFilter:image with:filterSaturation context:&factor];
}

/*
 调节图片色彩通道。每种颜色在0-255之间调节参数。255，255，255 和0, 0, 0为初始值。
 */
+ (UIImage *)tint:(UIImage *)image withMaxRGBA:(RGBA)color minRGBA:(RGBA)minColor {
  RGBA colorArr[2];
  colorArr[0] = color;
  colorArr[1] = minColor;
  return [self applyFilter:image with:filterTint context:&colorArr];
}

/*
 去色滤镜，即产生黑白图片。
 */
+ (UIImage *)desaturate:(UIImage *)image {
  return [self applyFilter:image with:filterDesaturate context:nil];
}

void filterOpacity(UInt8 *pixelBuf, UInt32 offset, void *context) {
  double val = *((double *)context);
  
  int a = offset + 3;
  
  int alpha = pixelBuf[a];
  
  pixelBuf[a] = SAFECOLOR(alpha * val);
}

void filterBrightness(UInt8 *pixelBuf, UInt32 offset, void *context) {
  double t = *((double *)context);
  
  int r = offset;
  int g = offset + 1;
  int b = offset + 2;
  
  int red = pixelBuf[r];
  int green = pixelBuf[g];
  int blue = pixelBuf[b];
  
  pixelBuf[r] = SAFECOLOR(red * t);
  pixelBuf[g] = SAFECOLOR(green * t);
  pixelBuf[b] = SAFECOLOR(blue * t);
}

void filterSaturation(UInt8 *pixelBuf, UInt32 offset, void *context) {
  double t = *((double *)context); // t (- [0, 2]
  
  int r = offset;
  int g = offset + 1;
  int b = offset + 2;
  
  int red = pixelBuf[r];
  int green = pixelBuf[g];
  int blue = pixelBuf[b];
  
  red = red * (0.3086 * (1 - t) + t) + green * (0.6094 * (1 - t)) + blue * (0.0820 * (1 - t));
  green = red * (0.3086 * (1 - t)) + green * ((0.6094 * (1 - t)) + t) + blue * (0.0820 * (1 - t));
  blue = red * (0.3086 * (1 - t)) + green * (0.6094 * (1 - t)) + blue * ((0.0820 * (1 - t)) + t);
  
  pixelBuf[r] = SAFECOLOR(red);
  pixelBuf[g] = SAFECOLOR(green);
  pixelBuf[b] = SAFECOLOR(blue);
}

void filterContrast(UInt8 *pixelBuf, UInt32 offset, void *context) {
  double t = *((double *)context); // t (- [0, 10]
  
  int r = offset;
  int g = offset + 1;
  int b = offset + 2;
  
  int red = pixelBuf[r];
  int green = pixelBuf[g];
  int blue = pixelBuf[b];
  
  red = red * t + 128 * (1 - t);
  green = green * t + 128 * (1 - t);
  blue = blue * t + 128 * (1 - t);
  
  pixelBuf[r] = SAFECOLOR(red);
  pixelBuf[g] = SAFECOLOR(green);
  pixelBuf[b] = SAFECOLOR(blue);
}

void filterPosterize(UInt8 *pixelBuf, UInt32 offset, void *context) {
  double levels = *((double *)context);
  if (levels == 0) levels = 1; // avoid divide by zero
  int step = 255 / levels;
  
  int r = offset;
  int g = offset + 1;
  int b = offset + 2;
  
  int red = pixelBuf[r];
  int green = pixelBuf[g];
  int blue = pixelBuf[b];
  
  pixelBuf[r] = SAFECOLOR((red / step) * step);
  pixelBuf[g] = SAFECOLOR((green / step) * step);
  pixelBuf[b] = SAFECOLOR((blue / step) * step);
}

void filterDesaturate(UInt8 *pixelBuf, UInt32 offset, void *context) {
  int r = offset;
  int g = offset + 1;
  int b = offset + 2;
  
  int red = pixelBuf[r];
  int green = pixelBuf[g];
  int blue = pixelBuf[b];
  
  red = red * 0.3086 + green * 0.6094 + blue * 0.0820;
  green = red * 0.3086 + green * 0.6094 + blue * 0.0820;
  blue = red * 0.3086 + green * 0.6094 + blue * 0.0820;
  
  pixelBuf[r] = SAFECOLOR(red);
  pixelBuf[g] = SAFECOLOR(green);
  pixelBuf[b] = SAFECOLOR(blue);
}

void filterInvert(UInt8 *pixelBuf, UInt32 offset, void *context) {
  int r = offset;
  int g = offset + 1;
  int b = offset + 2;
  
  int red = pixelBuf[r];
  int green = pixelBuf[g];
  int blue = pixelBuf[b];
  
  pixelBuf[r] = SAFECOLOR(255 - red);
  pixelBuf[g] = SAFECOLOR(255 - green);
  pixelBuf[b] = SAFECOLOR(255 - blue);
}

void filterTint(UInt8 *pixelBuf, UInt32 offset, void *context) {
  RGBA *rgbaArray = (RGBA *)context;
  RGBA maxRGBA = rgbaArray[0];
  RGBA minRGBA = rgbaArray[1];
  
  int r = offset;
  int g = offset + 1;
  int b = offset + 2;
  
  int red = pixelBuf[r];
  int green = pixelBuf[g];
  int blue = pixelBuf[b];
  
  pixelBuf[r] = SAFECOLOR((red - minRGBA.red) * (255.0 / (maxRGBA.red - minRGBA.red)));
  pixelBuf[g] = SAFECOLOR((green - minRGBA.green) * (255.0 / (maxRGBA.green - minRGBA.green)));
  pixelBuf[b] = SAFECOLOR((blue - minRGBA.blue) * (255.0 / (maxRGBA.blue - minRGBA.blue)));
}

@end
