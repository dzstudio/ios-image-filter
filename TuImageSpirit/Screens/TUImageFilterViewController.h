//
//  TUImageFilterViewController.h
//  TuImageSpirit
//
//  Created by Dillon.Zhang on 7/21/14.
//  Copyright (c) 2014 DillonZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TUImageBaseViewController.h"
#import "TUImageSpirit.h"

@class TUImageFilterListView;

@interface TUImageFilterViewController : TUImageBaseViewController<TUImageFilterDelegate>

@property (weak, nonatomic) IBOutlet TUImageFilterListView *filterListView;

@end
