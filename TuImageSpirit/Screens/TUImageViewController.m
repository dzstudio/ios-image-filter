//
//  TUImageViewController.m
//  TuImageSpirit
//
//  Created by Dillon.Zhang on 7/21/14.
//  Copyright (c) 2014 DillonZhang. All rights reserved.
//

#import "TUImageViewController.h"
#import "TUImageRotateViewController.h"
#import "TUImageClipViewController.h"
#import "TUImageTextViewController.h"
#import "TUImageFilterViewController.h"

@interface TUImageViewController ()

@end

@implementation TUImageViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.titleLabel.text = @"首页";
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)saveImageChanges:(UIImage *)image {
  self.selfImage = image;
  self.editingImageView.image = image;
}

#pragma mark - Tab bar button click events
- (IBAction)onTapRotateBtn:(id)sender {
  TUImageRotateViewController *controller = [[TUImageRotateViewController alloc] initWithNibName:@"TUImageRotateViewController" bundle:nil];
  [self presentViewController:controller animated:YES completion:nil];
  [controller initWithImage:self.selfImage];
}

- (IBAction)onTapClipBtn:(id)sender {
  TUImageClipViewController *controller = [[TUImageClipViewController alloc] initWithNibName:@"TUImageClipViewController" bundle:nil];
  [self presentViewController:controller animated:YES completion:nil];
  [controller initWithImage:self.selfImage];
}

- (IBAction)onTapWaterMarkBtn:(id)sender {
  TUImageTextViewController *controller = [[TUImageTextViewController alloc] initWithNibName:@"TUImageTextViewController" bundle:nil];
  [self presentViewController:controller animated:YES completion:nil];
  [controller initWithImage:self.selfImage];
}

- (IBAction)onTapFilterBtn:(id)sender {
  TUImageFilterViewController *controller = [[TUImageFilterViewController alloc] initWithNibName:@"TUImageFilterViewController" bundle:nil];
  [self presentViewController:controller animated:YES completion:nil];
  [controller initWithImage:self.selfImage];
}

@end
