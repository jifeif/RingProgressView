//
//  CCGradientView.m
//  RingProgressView
//
//  Created by 9188iMac on 16/4/18.
//  Copyright © 2016年 9188iMac. All rights reserved.
//

#import "CCGradientView.h"

@interface CCGradientView ()
@property (nonatomic, strong) CAGradientLayer * gradientLayer;
@property (nonatomic, strong) CAShapeLayer * shapeLayer;
@property (nonatomic, assign) CGPoint centerPoint;
@property (nonatomic, strong) CAShapeLayer * progressLayer;

@end

@implementation CCGradientView

- (void)awakeFromNib{
    _centerPoint = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _centerPoint = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        self.gradientLayer.mask = self.shapeLayer;
        [self.layer addSublayer:self.gradientLayer];
    }
    return self;
}

- (CAGradientLayer *)gradientLayer{
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.bounds = self.bounds;
        _gradientLayer.position = _centerPoint;
        NSMutableArray * mutableColorArr = [NSMutableArray array];
        for (UIColor *color in _colorArr) {
            [mutableColorArr addObject:(id)color.CGColor];
        }
        _gradientLayer.colors = mutableColorArr;
    }
    return _gradientLayer;
}

- (CAShapeLayer *)shapeLayer{
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.bounds = self.bounds;
        _shapeLayer.position = _centerPoint;
        _shapeLayer.lineWidth = _lineWidth;
        _shapeLayer.lineCap = kCALineCapRound;
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
        _shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        _shapeLayer.path = [UIBezierPath bezierPathWithArcCenter:_centerPoint radius:40 startAngle:_startAngle endAngle:_endAngle clockwise:YES].CGPath;
        _shapeLayer.strokeEnd = 0.0;
    }
    return _shapeLayer;
}

#pragma mark - 
- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [CATransaction setAnimationDuration:2];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    _shapeLayer.strokeEnd = progress;
    [CATransaction commit];
}

- (void)setStartAngle:(CGFloat)startAngle{
    _startAngle = startAngle;
}

#pragma mark - 开始动画
- (void)start{
    [self.gradientLayer setMask:self.shapeLayer];
    [self.layer addSublayer:self.gradientLayer];
}

@end
