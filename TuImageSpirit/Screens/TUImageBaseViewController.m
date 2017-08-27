//
//  TUImageBaseViewController.m
//  TuImageSpirit
//
//  Created by DillonZhang on 14-7-23.
//  Copyright (c) 2014年 ToUnsual. All rights reserved.
//

#import "TUImageBaseViewController.h"
#import "UIDevice+SystemVersion.h"

@interface TUImageBaseViewController ()

@end

@implementation TUImageBaseViewController

/*
 Description: The designated initializer. Support both 3.5 inch & 4 inch devices.
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  if (nibNameOrNil && [UIDevice isiPhone5]) {
    nibNameOrNil = [nibNameOrNil stringByAppendingFormat:@"-568h"];
  }
  
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  
  return self;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  originalStatusBarStyle = [UIApplication sharedApplication].statusBarStyle;
  [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [UIApplication sharedApplication].statusBarStyle = originalStatusBarStyle;
}

- (void)viewDidLoad {
  self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
  self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:17.0];
  self.titleLabel.textColor = [UIColor whiteColor];
  self.titleLabel.backgroundColor = [UIColor clearColor];
  self.titleLabel.textAlignment = NSTextAlignmentCenter;
  [self.editingImageView.superview addSubview:self.titleLabel];
}

#pragma mark - TUImageDelegate
- (void)initWithImage:(UIImage *)image {
  self.selfImage = image;
  self.sourceImage = image;
  [self.editingImageView setImage:image];
}

- (void)saveImageChanges:(UIImage *)image {
  self.editingImageView.image = image;
  if (self.presentingViewController && [self.presentingViewController respondsToSelector:@selector(saveImageChanges:)]) {
    [self.presentingViewController performSelector:@selector(saveImageChanges:) withObject:image];
  }
}

- (void)rollbackImageChanges {
  self.selfImage = self.sourceImage;
  [self.editingImageView setImage:self.sourceImage];
}

- (IBAction)onTapCancelBtn:(id)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onTapFinishBtn:(id)sender {
  [self saveImageChanges:self.selfImage];
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Properties
- (UIStatusBarStyle)preferredStatusBarStyle {
  return UIStatusBarStyleLightContent;
}

#pragma mark - Orientation
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation == UIInterfaceOrientationPortrait) || (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}
#ifdef __IPHONE_6_0
-(NSUInteger)supportedInterfaceOrientations{
  return (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown);
}
#endif

@end
