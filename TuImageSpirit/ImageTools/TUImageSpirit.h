//
//  TUImageSpirit.h
//  TuImageSpirit
//
//  Created by Dillon.Zhang on 7/18/14.
//  Copyright (c) 2014 DillonZhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLCircleView.h"
#import "TUImageClippingView.h"
#import "TUImageWaterMarkView.h"
#import "TUImageFilterListView.h"
#import "UIImage+Utility.h"
#import "UIDevice+SystemVersion.h"
#import "CLSplineInterpolator.h"
#import "UIView+Frame.h"
#import "UIImage+Utility.h"
#import "TUImageFilters.h"
#import "TUImageFilterTypes.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface TUImageSpirit : NSObject

+ (UIImage *)filterMoon:(UIImage *)image;
+ (UIImage *)filterChampagne:(UIImage *)image;
+ (UIImage *)filterLomo:(UIImage *)image;
+ (UIImage *)filterJapanStyle:(UIImage *)image;
+ (UIImage *)filterBlackWhite:(UIImage *)image;
+ (UIImage *)filterViolet:(UIImage *)image;
+ (UIImage *)filterSyrup:(UIImage *)image;
+ (UIImage *)filterSharpen:(UIImage *)image;
+ (UIImage *)filterFilm:(UIImage *)image;
+ (UIImage *)filterBlue:(UIImage *)image;

+ (UIImage *)rotate:(UIImage *)image with:(UIImageOrientation)orientation;
+ (UIImage *)clip:(UIImage *)image withFrame:(CGRect)frame andZoom:(CGFloat)scale;
+ (UIImage *)buildImage:(UIImage *)image with:(UIView *)workingView andZoom:(CGFloat)scale;

@end
