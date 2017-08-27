//
//  UIDevice+SystemVersion.m
//
//

#import "UIDevice+SystemVersion.h"

#define IPHONE_5_HEIGHT 1136

@implementation UIDevice (SystemVersion)

+ (CGFloat)iosVersion {
  return [[[UIDevice currentDevice] systemVersion] floatValue];
}

/**
 Description: Judge whether the screen size fits iPhone 5.
 */
+ (BOOL)isiPhone5 {
  return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height * [UIScreen mainScreen].scale >= IPHONE_5_HEIGHT;
}

@end
