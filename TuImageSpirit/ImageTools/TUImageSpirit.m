//
//  TUImageSpirit.m
//  TuImageSpirit
//
//  Created by Dillon.Zhang on 7/18/14.
//  Copyright (c) 2014 DillonZhang. All rights reserved.
//

#import "TUImageSpirit.h"

@implementation TUImageSpirit

/*
 月色滤镜
 */
+ (UIImage *)filterMoon:(UIImage *)image {
  return [TUImageFilters tint:image withMaxRGBA:(RGBA){235, 249, 215} minRGBA:(RGBA){23, 30, 16}];
}

/*
 香槟滤镜
 */
+ (UIImage *)filterChampagne:(UIImage *)image {
  return [TUImageFilters tint:image withMaxRGBA:(RGBA){190, 200, 255} minRGBA:(RGBA){10, 16, 25}];
}

/*
 LOMO效果滤镜
 */
+ (UIImage *)filterLomo:(UIImage *)image {
  UIImage *filteredImg = image;
  if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
    filteredImg = [self filteredImage:image withFilterName:@"CIVignetteEffect"];
  } else {
    UIImage *maskedImage;
    CGFloat radius = MIN(image.size.width, image.size.width);
    CGSize cornerSize = CGSizeMake(radius / 2, radius / 2);
    radius /= 2;
    CGFloat width = image.size.width + radius;
    CGFloat height = image.size.height + radius;
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    UIView *cornerView1 = [[UIView alloc] initWithFrame:(CGRect){0, 0, cornerSize}];
    UIView *cornerView2 = [[UIView alloc] initWithFrame:(CGRect){width - radius, 0, cornerSize}];
    UIView *cornerView3 = [[UIView alloc] initWithFrame:(CGRect){0, height - radius, cornerSize}];
    UIView *cornerView4 = [[UIView alloc] initWithFrame:(CGRect){width - radius, height - radius, cornerSize}];
    UIView *containerView = [[UIView alloc] initWithFrame:(CGRect){0, 0, CGSizeMake(width, height)}];
    [containerView addSubview:cornerView1];
    [containerView addSubview:cornerView2];
    [containerView addSubview:cornerView3];
    [containerView addSubview:cornerView4];
    cornerView1.layer.cornerRadius = radius / 2;
    cornerView2.layer.cornerRadius = radius / 2;
    cornerView3.layer.cornerRadius = radius / 2;
    cornerView4.layer.cornerRadius = radius / 2;
    cornerView1.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    cornerView2.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    cornerView3.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    cornerView4.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    containerView.backgroundColor = [UIColor clearColor];
    [containerView.layer renderInContext:UIGraphicsGetCurrentContext()];
    maskedImage = UIGraphicsGetImageFromCurrentImageContext();
    maskedImage = [self filteredImage:maskedImage withFilterName:@"CIGaussianBlur"];
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContext(image.size);
    [image drawAtPoint:CGPointZero];
    [maskedImage drawAtPoint:CGPointMake(-radius, -radius)];
    filteredImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
  }
  filteredImg = [TUImageFilters changeBrightness:filteredImg byFactor:1.2];
  return [TUImageFilters changeSaturation:[filteredImg deepCopy] byFactor:1.2];
}

/*
 日系风格滤镜
 */
+ (UIImage *)filterJapanStyle:(UIImage *)image {
  UIImage *filteredImg = [TUImageFilters changeBrightness:image byFactor:1.3];
  return [TUImageFilters changeSaturation:[filteredImg deepCopy] byFactor:1.2];
}

/*
 黑白滤镜
 */
+ (UIImage *)filterBlackWhite:(UIImage *)image {
  return [TUImageFilters desaturate:image];
}

/*
 紫罗兰滤镜
 */
+ (UIImage *)filterViolet:(UIImage *)image {
  return [TUImageFilters tint:image withMaxRGBA:(RGBA){175, 230, 195} minRGBA:(RGBA){10, 30, 15}];
}

/*
 糖水滤镜
 */
+ (UIImage *)filterSyrup:(UIImage *)image {
  return [TUImageFilters changeSaturation:image byFactor:1.6];
}

/*
 锐度滤镜
 */
+ (UIImage *)filterSharpen:(UIImage *)image {
  return [self filteredImage:image withFilterName:@"CISharpenLuminance"];}

/*
 菲林滤镜
 */
+ (UIImage *)filterFilm:(UIImage *)image {
  return [TUImageFilters tint:image withMaxRGBA:(RGBA){235, 235, 255} minRGBA:(RGBA){30, 30, 45}];
}

/*
 靓蓝滤镜
 */
+ (UIImage *)filterBlue:(UIImage *)image {
  return [TUImageFilters tint:image withMaxRGBA:(RGBA){255, 235, 190} minRGBA:(RGBA){40, 35, 0}];
}

/*
 根据传入的系统滤镜名称，进行相应的滤镜处理。
 */
+ (UIImage *)filteredImage:(UIImage *)image withFilterName:(NSString *)filterName {
  CIImage *ciImage = [[CIImage alloc] initWithImage:image];
  CIFilter *filter = [CIFilter filterWithName:filterName keysAndValues:kCIInputImageKey, ciImage, nil];
  [filter setDefaults];
  
  if ([filterName isEqualToString:@"CIVignetteEffect"]) {
    // parameters for CIVignetteEffect
    CGFloat R = MIN(image.size.width, image.size.height) / 1.2;
    CIVector *vct = [[CIVector alloc] initWithX:image.size.width / 2 Y:image.size.height / 2];
    [filter setValue:vct forKey:@"inputCenter"];
    [filter setValue:[NSNumber numberWithFloat:0.8] forKey:@"inputIntensity"];
    [filter setValue:[NSNumber numberWithFloat:R] forKey:@"inputRadius"];
  } else if ([filterName isEqualToString:@"CIGaussianBlur"]) {
    [filter setValue:@(25.0) forKey:@"inputRadius"];
  }
  
  CIContext *context = [CIContext contextWithOptions:nil];
  CIImage *outputImage = [filter outputImage];
  CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
  UIImage *result = [UIImage imageWithCGImage:cgImage];
  CGImageRelease(cgImage);
  
  return result;
}

/*
 根据方位进行图片的旋转操作。
 */
+ (UIImage *)rotate:(UIImage *)image with:(UIImageOrientation)orientation {
  float rotate = 0.0;
  
  switch (orientation) {
    case UIImageOrientationLeft:
      rotate = M_PI_2;
      break;
    case UIImageOrientationRight:
      rotate = 3 * M_PI_2;
      break;
    case UIImageOrientationDown:
      rotate = M_PI;
      break;
    default:
      rotate = 0.0;
      break;
  }
  
  CIImage *ciImage = [[CIImage alloc] initWithImage:image];
  CIFilter *filter = [CIFilter filterWithName:@"CIAffineTransform" keysAndValues:kCIInputImageKey, ciImage, nil];
  [filter setDefaults];
  CGAffineTransform transform = CATransform3DGetAffineTransform(CATransform3DMakeRotation(rotate, 0, 0, 1));
  [filter setValue:[NSValue valueWithBytes:&transform objCType:@encode(CGAffineTransform)] forKey:@"inputTransform"];
  
  CIContext *context = [CIContext contextWithOptions:nil];
  CIImage *outputImage = [filter outputImage];
  CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
  UIImage *result = [UIImage imageWithCGImage:cgImage];
  CGImageRelease(cgImage);
  
  return result;
}

/*
 根据传入的尺寸和缩放比例进行图片的剪切。
 */
+ (UIImage *)clip:(UIImage *)image withFrame:(CGRect)frame andZoom:(CGFloat)scale {
  frame.size.width /= scale;
  frame.size.height /= scale;
  frame.origin.x /= scale;
  frame.origin.y /= scale;
  
  return [image crop:frame];
}

+ (UIImage *)buildImage:(UIImage *)image with:(UIView *)workingView andZoom:(CGFloat)scale {
  UIGraphicsBeginImageContext(image.size);
  [image drawAtPoint:CGPointZero];
  
  CGContextScaleCTM(UIGraphicsGetCurrentContext(), scale, scale);
  [workingView.layer renderInContext:UIGraphicsGetCurrentContext()];
  UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return result;
}

@end
