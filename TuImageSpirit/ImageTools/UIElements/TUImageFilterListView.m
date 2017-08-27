//
//  TUImageFilterListView.m
//  TuImageSpirit
//
//  Created by Dillon.Zhang on 7/21/14.
//  Copyright (c) 2014 DillonZhang. All rights reserved.
//

#import "TUImageFilterListView.h"
#import "TUImageSpirit.h"

#define FILTER_ICON_Tag 85
#define FILTER_TITLE_TAG 86
#define FILTER_BG_TAG 87

@interface TUImageFilterListView()

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation TUImageFilterListView

- (void)awakeFromNib {
  self.dataSource = self;
  self.delegate = self;
  self.backgroundColor = [UIColor clearColor];
  self.transform=CGAffineTransformMakeRotation(-M_PI / 2);
  [self registerNib:[UINib nibWithNibName:@"TUImageFilterCell" bundle:nil] forCellReuseIdentifier:@"Filter-Cell"];
  _selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSString *filterName =  (NSString *)[[self filterNames] objectAtIndex:indexPath.row];
  NSDictionary *filterDict = (NSDictionary *)[self.filterList objectForKey:filterName];
  [self.filterDelegate applyImageFilterWithClass:[filterDict objectForKey:@"filterType"]];
  
  _selectedIndexPath = indexPath;
  [self reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.filterList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 68;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Filter-Cell"];
  cell.transform = CGAffineTransformMakeRotation(-M_PI * 1.5);
  cell.backgroundColor = [UIColor clearColor];
  cell.selectionStyle = UITableViewCellEditingStyleNone;
  UIView *selectedBgView = [cell viewWithTag:FILTER_BG_TAG];
  if ([indexPath isEqual:_selectedIndexPath]) {
    selectedBgView.layer.cornerRadius = 11;
    selectedBgView.hidden = NO;
  } else {
    selectedBgView.hidden = YES;
  }
  
  NSString *filterName =  (NSString *)[[self filterNames] objectAtIndex:indexPath.row];
  NSDictionary *filterDict = (NSDictionary *)[self.filterList objectForKey:filterName];
  
  UILabel *titleLabel = (UILabel *)[cell viewWithTag:FILTER_TITLE_TAG];
  titleLabel.text = [filterDict objectForKey:@"name"];
  
  UIImageView *filterIcon = (UIImageView *)[cell viewWithTag:FILTER_ICON_Tag];
  NSString *filterType = [filterDict objectForKey:@"filterType"];
  if ([filterType isEqualToString:FILTER_CHAMPAGNE]) {
    filterIcon.image = [TUImageSpirit filterChampagne:[UIImage imageNamed:@"Tu_filter_icon"]];
  } else if ([filterType isEqualToString:FILTER_BLACKWHITE]) {
    filterIcon.image = [TUImageSpirit filterBlackWhite:[UIImage imageNamed:@"Tu_filter_icon"]];
  } else if ([filterType isEqualToString:FILTER_BLUE]) {
    filterIcon.image = [TUImageSpirit filterBlue:[UIImage imageNamed:@"Tu_filter_icon"]];
  } else if ([filterType isEqualToString:FILTER_FILM]) {
    filterIcon.image = [TUImageSpirit filterFilm:[UIImage imageNamed:@"Tu_filter_icon"]];
  } else if ([filterType isEqualToString:FILTER_JAPAN]) {
    filterIcon.image = [TUImageSpirit filterJapanStyle:[UIImage imageNamed:@"Tu_filter_icon"]];
  } else if ([filterType isEqualToString:FILTER_LOMO]) {
    filterIcon.image = [TUImageSpirit filterLomo:[UIImage imageNamed:@"Tu_filter_icon"]];
  } else if ([filterType isEqualToString:FILTER_MOON]) {
    filterIcon.image = [TUImageSpirit filterMoon:[UIImage imageNamed:@"Tu_filter_icon"]];
  } else if ([filterType isEqualToString:FILTER_SHARPEN]) {
    filterIcon.image = [TUImageSpirit filterSharpen:[UIImage imageNamed:@"Tu_filter_icon"]];
  } else if ([filterType isEqualToString:FILTER_SYRUP]) {
    filterIcon.image = [TUImageSpirit filterSyrup:[UIImage imageNamed:@"Tu_filter_icon"]];
  } else if ([filterType isEqualToString:FILTER_VIOLET]) {
    filterIcon.image = [TUImageSpirit filterViolet:[UIImage imageNamed:@"Tu_filter_icon"]];
  } else {
    filterIcon.image = [UIImage imageNamed:@"Tu_filter_icon"];
  }
  
  return cell;
}

- (NSArray *)filterNames {
  return [NSArray arrayWithObjects:@"filterNone", @"filterChampagne", @"filterMoon", @"filterLomo", @"filterJapan", @"filterBlackWhite", @"filterViolet", @"filterSyrup", @"filterSharpen", @"filterFilm", @"filterBlue", nil];
}

- (NSDictionary *)filterList {
  if (_filterList == nil) {
  _filterList = @{
      @"filterNone": @{
        @"name": @"无",
        @"preview": @"Tu_filter_icon",
        @"filterType": FILTER_NONE
      },
      @"filterChampagne": @{
        @"name": @"香槟",
        @"preview": @"Tu_filter_icon",
        @"filterType": FILTER_CHAMPAGNE
      },
      @"filterMoon": @{
        @"name": @"月色",
        @"preview": @"Tu_filter_icon",
        @"filterType": FILTER_MOON
      },
      @"filterLomo": @{
        @"name": @"LOMO",
        @"preview": @"Tu_filter_icon",
        @"filterType": FILTER_LOMO
      },
      @"filterJapan": @{
        @"name": @"日系",
        @"preview": @"Tu_filter_icon",
        @"filterType": FILTER_JAPAN
      },
      @"filterBlackWhite": @{
        @"name": @"黑白",
        @"preview": @"Tu_filter_icon",
        @"filterType": FILTER_BLACKWHITE
      },
      @"filterViolet": @{
        @"name": @"紫罗兰",
        @"preview": @"Tu_filter_icon",
        @"filterType": FILTER_VIOLET
      },
      @"filterSyrup": @{
        @"name": @"糖水",
        @"preview": @"Tu_filter_icon",
        @"filterType": FILTER_SYRUP
      },
      @"filterSharpen": @{
        @"name": @"锐化",
        @"preview": @"Tu_filter_icon",
        @"filterType": FILTER_SHARPEN
      },
      @"filterFilm": @{
        @"name": @"菲林",
        @"preview": @"Tu_filter_icon",
        @"filterType": FILTER_FILM
      },
      @"filterBlue": @{
        @"name": @"靓蓝",
        @"preview": @"Tu_filter_icon",
        @"filterType": FILTER_BLUE
      }
    };
  }
  
  return _filterList;
}

@end
