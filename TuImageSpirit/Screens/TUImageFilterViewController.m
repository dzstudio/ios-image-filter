//
//  TUImageFilterViewController.m
//  TuImageSpirit
//
//  Created by Dillon.Zhang on 7/21/14.
//  Copyright (c) 2014 DillonZhang. All rights reserved.
//

#import "TUImageFilterViewController.h"
#import "TUImageSpirit.h"

@interface TUImageFilterViewController ()

@end

@implementation TUImageFilterViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.titleLabel.text = @"滤镜";
  self.filterListView.filterDelegate = self;
}

- (void)saveImageChanges:(UIImage *)image {
  self.selfImage = self.editingImageView.image;
  [super saveImageChanges:self.selfImage];
}

- (void)setSourceImage:(UIImage *)sourceImage {
  [super setSourceImage:sourceImage];
}

- (void)applyImageFilterWithClass:(NSString *)name {
  if ([name isEqualToString:FILTER_NONE]) {
    self.editingImageView.image = self.sourceImage;
  } else if ([name isEqualToString:FILTER_CHAMPAGNE]) {
    self.editingImageView.image = [TUImageSpirit filterChampagne:[self.selfImage deepCopy]];
  } else if ([name isEqualToString:FILTER_BLACKWHITE]) {
    self.editingImageView.image = [TUImageSpirit filterBlackWhite:[self.selfImage deepCopy]];
  } else if ([name isEqualToString:FILTER_BLUE]) {
    self.editingImageView.image = [TUImageSpirit filterBlue:[self.selfImage deepCopy]];
  } else if ([name isEqualToString:FILTER_FILM]) {
    self.editingImageView.image = [TUImageSpirit filterFilm:[self.selfImage deepCopy]];
  } else if ([name isEqualToString:FILTER_JAPAN]) {
    self.editingImageView.image = [TUImageSpirit filterJapanStyle:[self.selfImage deepCopy]];
  } else if ([name isEqualToString:FILTER_LOMO]) {
    self.editingImageView.image = [TUImageSpirit filterLomo:[self.selfImage deepCopy]];
  } else if ([name isEqualToString:FILTER_MOON]) {
    self.editingImageView.image = [TUImageSpirit filterMoon:[self.selfImage deepCopy]];
  } else if ([name isEqualToString:FILTER_SHARPEN]) {
    self.editingImageView.image = [TUImageSpirit filterSharpen:[self.selfImage deepCopy]];
  } else if ([name isEqualToString:FILTER_SYRUP]) {
    self.editingImageView.image = [TUImageSpirit filterSyrup:[self.selfImage deepCopy]];
  } else if ([name isEqualToString:FILTER_VIOLET]) {
    self.editingImageView.image = [TUImageSpirit filterViolet:[self.selfImage deepCopy]];
  }
}

@end
