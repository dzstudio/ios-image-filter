//
//  TUWaterMarkView.h
//  TuImageSpirit
//
//  Created by Dillon.Zhang on 7/21/14.
//  Copyright (c) 2014 DillonZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLCircleView;

@interface TUImageWaterMarkView : UIView <UITextFieldDelegate>

@property (nonatomic, strong) CLCircleView *rbView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UITextField *textLabel;
@property (nonatomic, strong) UIView *containerView;

- (id)initWithFrame:(CGRect)frame andImageView:(UIImageView *)imageView;
- (UIImage *)buildImageWith:(UIImage *)image andZoom:(CGFloat)scale;

@end
