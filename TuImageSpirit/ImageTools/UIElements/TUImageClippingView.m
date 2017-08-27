//
//  TUImageClippingView.m
//  TuImageSpirit
//
//  Created by Dillon.Zhang on 7/21/14.
//  Copyright (c) 2014 DillonZhang. All rights reserved.
//

#import "TUImageClippingView.h"
#import "CLCircleView.h"

@interface TUGridLayer: CALayer

@property (nonatomic, assign) CGRect clippingRect;
@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) UIColor *gridColor;

@end

@implementation TUImageClippingView {
  TUGridLayer *_tuGridLayer;
}

/*
 初始化一个图片选区视图，需要一个UIImageView.
 会在给定得UIImageView同级创建一个UIView然后放入当前的选区视图。
 */
- (id)initWithFrame:(CGRect)frame andImageView:(UIImageView *)imageView {
  self = [super initWithFrame:frame];
  if (self) {
    self.imageView = imageView;
    UIView *containerView = [[UIView alloc] initWithFrame:self.imageView.frame];
    [self.imageView.superview addSubview:containerView];
    [containerView addSubview:self];
  }
  
  return self;
}

/*
 生成选区视图四角的锚点并绑定拖拽时间。
 同时生成一个灰色半透明的遮罩层。
 */
- (void)didMoveToSuperview {
  self.layer.borderColor = [[UIColor whiteColor] CGColor];
  self.layer.borderWidth = 1;
  
  _ltView = [self clippingCircleWithTag:0 andSuperView:self.superview];
  _lbView = [self clippingCircleWithTag:1 andSuperView:self.superview];
  _rtView = [self clippingCircleWithTag:2 andSuperView:self.superview];
  _rbView = [self clippingCircleWithTag:3 andSuperView:self.superview];
  UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(clippingViewPan:)];
  [self addGestureRecognizer:panGesture];
  _tuGridLayer = [[TUGridLayer alloc] init];
  _tuGridLayer.frame = self.superview.bounds;
  _tuGridLayer.bgColor   = [UIColor colorWithWhite:0 alpha:0.6];
  _tuGridLayer.gridColor = [UIColor colorWithWhite:0 alpha:1.0];
  [self.imageView.layer addSublayer:_tuGridLayer];
  
  [self updateClippingFrame];
}

/*
 根据当前选区的大小，重新计算四个锚点的位置。
 */
- (void)updateClippingFrame {
  _ltView.center = CGPointMake(self.frame.origin.x, self.frame.origin.y);
  _lbView.center = CGPointMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height);
  _rtView.center = CGPointMake(self.frame.origin.x + self.frame.size.width, self.frame.origin.y);
  _rbView.center = CGPointMake(self.frame.origin.x + self.frame.size.width, self.frame.origin.y + self.frame.size.height);
  [_tuGridLayer setClippingRect:self.frame];
  [_tuGridLayer setNeedsDisplay];
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
/*
 选区自身被拖动时的处理事件。
 */
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

/*
 选区四角被拖动时的处理事件。
 */
- (void)circleViewDidPan:(UIPanGestureRecognizer *)sender {
  CGPoint point = [sender locationInView:self.superview];
  if (!CGRectContainsPoint((CGRect){0, 0, self.superview.frame.size}, point)) {
    return;
  }
  
  CGRect rect = self.frame;
  CGFloat x = rect.origin.x;
  CGFloat y = rect.origin.y;
  CGFloat w = rect.size.width;
  CGFloat h = rect.size.height;
  
  switch (sender.view.tag) {
    case 0: // 更新最上角顶点
    {
      w -= (point.x - x);
      h -= (point.y - y);
      x = point.x;
      y = point.y;
      break;
    }
    case 1: // 更新左下角顶点
    {
      w -= (point.x - x);
      h = (point.y - y);
      x = point.x;
      break;
    }
    case 2: // 更新右上角顶点
    {
      w = (point.x - x);
      h -= (point.y - y);
      y = point.y;
      break;
    }
    case 3: // 更新右下角顶点
    {
      w = (point.x - x);
      h = (point.y - y);
      break;
    }
    default:
      break;
  }
  
  // 验证是否超出范围
  if (x < 0) x = 0;
  if (y < 0) y = 0;
  if (w < 25) w = 25;
  if (h < 25) h = 25;
  
  dispatch_async(dispatch_get_main_queue(), ^{
    self.frame = CGRectMake(x, y, w, h);
    [self updateClippingFrame];
  });
}

@end

@implementation TUGridLayer

/*
 实现了一个灰色遮罩层，同时露出已被选区选中的区域。
 */
- (id)initWithLayer:(id)layer {
  self = [super initWithLayer:layer];
  if (self && [layer isKindOfClass:[TUGridLayer class]]) {
    self.bgColor   = ((TUGridLayer *)layer).bgColor;
    self.gridColor = ((TUGridLayer *)layer).gridColor;
    self.clippingRect = ((TUGridLayer *)layer).clippingRect;
  }
  return self;
}

- (void)drawInContext:(CGContextRef)context {
  CGRect rct = self.bounds;
  CGContextSetFillColorWithColor(context, self.bgColor.CGColor);
  CGContextFillRect(context, rct);
  CGContextClearRect(context, _clippingRect);
}

@end
