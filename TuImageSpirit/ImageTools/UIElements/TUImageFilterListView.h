//
//  TUImageFilterListView.h
//  TuImageSpirit
//
//  Created by Dillon.Zhang on 7/21/14.
//  Copyright (c) 2014 DillonZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define FILTER_NONE @"none"
#define FILTER_CHAMPAGNE @"champagne"
#define FILTER_MOON @"moon"
#define FILTER_LOMO @"lomo"
#define FILTER_JAPAN @"japan"
#define FILTER_BLACKWHITE @"blackwhite"
#define FILTER_VIOLET @"violet"
#define FILTER_SYRUP @"syrup"
#define FILTER_SHARPEN @"sharpen"
#define FILTER_FILM @"film"
#define FILTER_BLUE @"blue"

@protocol TUImageFilterDelegate <NSObject>

- (void)applyImageFilterWithClass:(NSString *)name;

@end

@interface TUImageFilterListView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSDictionary *filterList;
@property (nonatomic, strong) id<TUImageFilterDelegate> filterDelegate;

@end
