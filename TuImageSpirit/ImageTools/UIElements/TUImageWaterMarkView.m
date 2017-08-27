//
//  TUWaterMarkView.m
//  TuImageSpirit
//
//  Created by Dillon.Zhang on 7/21/14.
//  Copyright (c) 2014 DillonZhang. All rights reserved.
//

#import "TUImageWaterMarkView.h"
#import "CLCircleView.h"
#import "TUImageSpirit.h"

@implementation TUImageWaterMarkView

- (id)initWithFrame:(CGRect)frame andImageView:(UIImageView *)imageView {
  self = [super initWithFrame:frame];
  if (self) {
    self.imageView = imageView;
    _containerView = [[UIView alloc] initWithFrame:self.imageView.frame];
    [self.imageView.superview addSubview:_containerView];
    [_containerView addSubview:self];
  }
  
  return self;
}

- (void)didMoveToSuperview {
  self.layer.borderColor = [[UIColor whiteColor] CGColor];
  self.layer.borderWidth = 1;
  
  _rbView = [self clippingCircleWithTag:3 andSuperView:self.superview];
  UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(clippingViewPan:)];
  [self addGestureRecognizer:panGesture];
  
  [self updateClippingFrame];
  
  _textLabel = [[UITextField alloc] init];
  _textLabel.textColor = [UIColor whiteColor];
  _textLabel.autocorrectionType = UITextAutocorrectionTypeNo;
  _textLabel.delegate = self;
  [self updateTextFieldFrame];
  [self addSubview:_textLabel];
  [_textLabel becomeFirstResponder];
}

- (void)updateClippingFrame {
  _rbView.center = CGPointMake(self.frame.origin.x + self.frame.size.width, self.frame.origin.y + self.frame.size.height);
}

- (void)updateTextFieldFrame {
  _textLabel.frame = CGRectMake(6, 2, self.frame.size.width - 12, self.frame.size.height - 4);
  _textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:self.frame.size.height - 26];
}

#pragma mark - TextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return YES;
}

- (BOOL)endEditing:(BOOL)force {
  [self.textLabel resignFirstResponder];
  return YES;
}

#pragma mark - Properties
- (CLCircleView *)clippingCircleWithTag:(NSInteger)tag andSuperView:(UIView *)superView {
  CLCircleView *view = [[CLCircleView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
  view.tag = tag;
  
  UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(circleViewDidPan:)];
  [view addGestureRecognizer:panGesture];
  [superView addSubview:view];
  
  return view;
}

#pragma mark - Gesture Events
- (void)clippingViewPan:(UIPanGestureRecognizer *)sender {
  static CGPoint initialPoint;
  
  if(sender.state==UIGestureRecognizerStateBegan){
    initialPoint = [sender locationInView:self.superview];
  } else {
    CGPoint point = [sender locationInView:self.superview];
    CGPoint newPoint = self.center;
    newPoint.x += (point.x - initialPoint.x);
    newPoint.y += (point.y - initialPoint.y);
    initialPoint = [sender locationInView:self.superview];
    
    CGPoint oldPoint = self.center;
    self.center = newPoint;
    if (!CGRectContainsRect(self.superview.frame, [self.superview convertRect:self.frame toView:self.superview.superview])) {
      self.center = oldPoint;
    }
    
    [self updateClippingFrame];
  }
}

- (void)circleViewDidPan:(UIPanGestureRecognizer *)sender {
  CGPoint point = [sender locationInView:self.superview];
  if (!CGRectContainsPoint((CGRect){0, 0, self.superview.frame.size}, point)) {
    return;
  }
  
  CGRect rect = self.frame;
  CGFloat x = rect.origin.x;
  CGFloat y = rect.origin.y;
  CGFloat w = point.x - x;
  CGFloat h = point.y - y;
  
  // 验证是否超出范围
  if (x < 0) x = 0;
  if (y < 0) y = 0;
  if (w < 25) w = 25;
  if (h < 25) h = 25;
  
  dispatch_async(dispatch_get_main_queue(), ^{
    self.frame = CGRectMake(x, y, w, h);
    [self updateClippingFrame];
    [self updateTextFieldFrame];
  });
}

- (UIImage *)buildImageWith:(UIImage *)image andZoom:(CGFloat)scale {
  self.layer.borderColor = [UIColor clearColor].CGColor;
  [self.rbView removeFromSuperview];
  return [TUImageSpirit buildImage:image with:self.containerView andZoom:scale];
}

@end
