//
//  TUImageRotateViewController.m
//  TuImageSpirit
//
//  Created by Dillon.Zhang on 7/21/14.
//  Copyright (c) 2014 DillonZhang. All rights reserved.
//

#import "TUImageRotateViewController.h"
#import "UIDevice+SystemVersion.h"
#import "TUImageSpirit.h"

@interface TUImageRotateViewController ()

@end

@implementation TUImageRotateViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.rotate90BtnView.layer.cornerRadius = 5.0;
  self.rotate270BtnView.layer.cornerRadius = 5.0;
  self.titleLabel.text = @"旋转";
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)onTapRotate90:(id)sender {
  self.selfImage = [TUImageSpirit rotate:self.selfImage with:UIImageOrientationRight];
  
  [UIView animateWithDuration:0.3 animations:^{
    self.editingImageView.layer.transform = CATransform3DRotate(self.editingImageView.layer.transform, M_PI / 2, 0, 0, 1);
  }];
}

- (IBAction)onTapRotate270:(id)sender {
  self.selfImage = [TUImageSpirit rotate:self.selfImage with:UIImageOrientationLeft];
  
  [UIView animateWithDuration:0.3 animations:^{
    self.editingImageView.layer.transform = CATransform3DRotate(self.editingImageView.layer.transform, 0 - M_PI / 2, 0, 0, 1);
  }];
}

@end
