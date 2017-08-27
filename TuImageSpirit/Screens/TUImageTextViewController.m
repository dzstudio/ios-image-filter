//
//  TUImageTextViewController.m
//  TuImageSpirit
//
//  Created by Dillon.Zhang on 7/21/14.
//  Copyright (c) 2014 DillonZhang. All rights reserved.
//

#import "TUImageTextViewController.h"
#import "UIDevice+SystemVersion.h"
#import "TUImageWaterMarkView.h"
#import "TUImageSpirit.h"

@interface TUImageTextViewController ()

@property (nonatomic, strong) TUImageWaterMarkView *textView;

@end

@implementation TUImageTextViewController

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  [self resetImageViewFrame];
  CGRect textViewFrame = self.editingImageView.frame;
  textViewFrame.origin.x = (textViewFrame.size.width > 150) ? ((textViewFrame.size.width - 150) / 2) : 0;
  textViewFrame.origin.y = (textViewFrame.size.height > 50) ? ((textViewFrame.size.height - 50) / 2) : 0;
  textViewFrame.size.width = (textViewFrame.size.width > 150) ? 150 : textViewFrame.size.width;
  textViewFrame.size.height = (textViewFrame.size.height > 50) ? 50 : textViewFrame.size.height;
  
  _textView = [[TUImageWaterMarkView alloc] initWithFrame:textViewFrame andImageView:self.editingImageView];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.titleLabel.text = @"水印";
}

- (void)saveImageChanges:(UIImage *)image {
  [_textView resignFirstResponder];
  [self performSelector:@selector(saveImageText) withObject:nil afterDelay:0.4];
}

- (void)saveImageText {
  CGFloat scale = self.selfImage.size.width / self.editingImageView.frame.size.width;
  self.selfImage = [self.textView buildImageWith:self.selfImage andZoom:scale];
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
