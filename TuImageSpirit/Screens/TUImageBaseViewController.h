//
//  TUImageBaseViewController.h
//  TuImageSpirit
//
//  Created by DillonZhang on 14-7-23.
//  Copyright (c) 2014年 ToUnsual. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TUImageBaseViewController : UIViewController {
  UIStatusBarStyle originalStatusBarStyle;
}

- (IBAction)onTapCancelBtn:(id)sender;
- (IBAction)onTapFinishBtn:(id)sender;

- (void)initWithImage:(UIImage *)image;
- (void)saveImageChanges:(UIImage *)image;
- (void)rollbackImageChanges;

@property (nonatomic, strong) UIImage *sourceImage;
@property (nonatomic, strong) UIImage *selfImage;
@property (weak, nonatomic) IBOutlet UIImageView *editingImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@end
