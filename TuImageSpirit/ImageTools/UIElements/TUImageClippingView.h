//
//  TUImageClippingView.h
//  TuImageSpirit
//
//  Created by Dillon.Zhang on 7/21/14.
//  Copyright (c) 2014 DillonZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLCircleView;

@interface TUImageClippingView : UIView

@property (nonatomic, strong) CLCircleView *ltView;
@property (nonatomic, strong) CLCircleView *lbView;
@property (nonatomic, strong) CLCircleView *rtView;
@property (nonatomic, strong) CLCircleView *rbView;
@property (nonatomic, strong) UIImageView *imageView;

- (id)initWithFrame:(CGRect)frame andImageView:(UIImageView *)imageView;

@end
