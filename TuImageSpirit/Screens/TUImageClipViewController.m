//
//  TUImageClipViewController.m
//  TuImageSpirit
//
//  Created by Dillon.Zhang on 7/21/14.
//  Copyright (c) 2014 DillonZhang. All rights reserved.
//

#import "TUImageClipViewController.h"
#import "UIDevice+SystemVersion.h"
#import "TUImageClippingView.h"
#import "TUImageSpirit.h"

@interface TUImageClipViewController ()

@property (nonatomic, strong) TUImageClippingView *clippingView;

@end

@implementation TUImageClipViewController

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  // 初始化图像选取工具
  [self resetImageViewFrame];
  CGRect clipViewFrame = self.editingImageView.frame;
  clipViewFrame.origin.x = (clipViewFrame.size.width > 150) ? ((clipViewFrame.size.width - 150) / 2) : 0;
  clipViewFrame.origin.y = (clipViewFrame.size.height > 200) ? ((clipViewFrame.size.height - 200) / 2) : 0;
  clipViewFrame.size.width = (clipViewFrame.size.width > 150) ? 150 : clipViewFrame.size.width;
  clipViewFrame.size.height = (clipViewFrame.size.height > 200) ? 200 : clipViewFrame.size.height;
  _clippingView = [[TUImageClippingView alloc] initWithFrame:clipViewFrame andImageView:self.editingImageView];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.confirmClipBtnView.layer.cornerRadius = 5.0;
  self.titleLabel.text = @"剪切";
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)onTapConfirmClipping:(id)sender {
  [self onTapFinishBtn:nil];
}

- (void)saveImageChanges:(UIImage *)image {
  CGFloat scale = self.editingImageView.frame.size.width / self.selfImage.size.width;
  self.selfImage = [TUImageSpirit clip:self.selfImage withFrame:self.clippingView.frame andZoom:scale];
  [super saveImageChanges:self.selfImage];
}

/*
 重新调整UIImageView的大小以适应图片的长宽比例。
 */
- (void)resetImageViewFrame {
  CGSize size = (self.editingImageView.image) ? self.editingImageView.image.size : self.editingImageView.frame.size;
  if (size.width > 0 && size.height > 0) {
    CGRect originalRect = self.editingImageView.frame;
    CGFloat ratio = MIN(originalRect.size.width / size.width, originalRect.size.height / size.height);
    CGFloat width = ratio * size.width;
    CGFloat height = ratio * size.height;
    
    self.editingImageView.frame = CGRectMake((originalRect.size.width - width) / 2, originalRect.origin.y + (originalRect.size.height - height) / 2, width, height);
  }
}

@end
