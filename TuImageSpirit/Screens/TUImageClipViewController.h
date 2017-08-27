//
//  TUImageClipViewController.h
//  TuImageSpirit
//
//  Created by Dillon.Zhang on 7/21/14.
//  Copyright (c) 2014 DillonZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TUImageBaseViewController.h"

@interface TUImageClipViewController : TUImageBaseViewController

@property (weak, nonatomic) IBOutlet UIView *confirmClipBtnView;

- (IBAction)onTapConfirmClipping:(id)sender;

@end
