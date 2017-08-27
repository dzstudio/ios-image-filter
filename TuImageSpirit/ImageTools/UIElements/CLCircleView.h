//
//  CLCircleView.h
//  锚点视图。生成一个白色圆点，用于选取四周可以拖拽的锚点
//

#import <UIKit/UIKit.h>

@interface CLCircleView : UIView

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) CGFloat radius;

@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) CGFloat borderWidth;

@end
