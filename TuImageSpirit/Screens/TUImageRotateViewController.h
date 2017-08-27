//
//  TUImageRotateViewController.h
//  TuImageSpirit
//
//  Created by Dillon.Zhang on 7/21/14.
//  Copyright (c) 2014 DillonZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TUImageBaseViewController.h"

@interface TUImageRotateViewController : TUImageBaseViewController

@property (weak, nonatomic) IBOutlet UIView *rotate90BtnView;
@property (weak, nonatomic) IBOutlet UIView *rotate270BtnView;

- (IBAction)onTapRotate90:(id)sender;
- (IBAction)onTapRotate270:(id)sender;

@end
