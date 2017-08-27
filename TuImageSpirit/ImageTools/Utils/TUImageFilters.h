//
//  UIImage+ImageFilter.h
//  TuImageSpirit
//
//  Created by DillonZhang on 14-7-20.
//  Copyright (c) 2014 ToUnsual. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef struct _singleRGBA {
  unsigned char red;
  unsigned char green;
  unsigned char blue;
  unsigned char alpha;
} RGBA;

typedef void (*FilterFunction)(UInt8 *pixelBuf, UInt32 offset, void *context);

@interface TUImageFilters : NSObject 

+ (UIImage *)changeOpacity:(UIImage *)image byFactor:(double)factor;
+ (UIImage *)changeBrightness:(UIImage *)image byFactor:(double)factor;
+ (UIImage *)changeSaturation:(UIImage *)image byFactor:(double)factor;
+ (UIImage *)tint:(UIImage *)image withMaxRGBA:(RGBA)color minRGBA:(RGBA)minColor;
+ (UIImage *)desaturate:(UIImage *)image;

@end
