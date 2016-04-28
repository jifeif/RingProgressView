//
//  CCSectorView.m
//  RingProgressView
//
//  Created by 9188iMac on 16/4/27.
//  Copyright © 2016年 9188iMac. All rights reserved.
//

#import "CCSectorView.h"
CGFloat const CCSectorViewLine = 20;
@interface CCSectorView () 
@property (strong, nonatomic) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) CALayer *backgroundLayer;
@property (nonatomic, strong) CALayer *otherLayer;

@property (nonatomic, assign) CGPoint centerPoint;
@property (nonatomic, strong) NSMutableArray<UIBezierPath *> *pathArr;

@property (nonatomic, strong) NSMutableArray<NSValue *> *middlePointArr;//每个扇形弧度中点的坐标。
@property (nonatomic, strong) NSMutableArray<NSValue *> *linePointArr;//线转折点的坐标。 线段长20；


@end

@implementation CCSectorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.middlePointArr = [NSMutableArray array];
        self.linePointArr = [NSMutableArray array];
        self.pathArr = [NSMutableArray array];
        self.backgroundColor = [UIColor lightGrayColor];
        _centerPoint = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        [self backGroundLayer];
    }
    return self;
}
/**
 *  背景layer，为了做mask
 */
- (void)backGroundLayer{
    self.otherLayer = [CALayer layer];
    _otherLayer.bounds = self.bounds;
    _otherLayer.backgroundColor = [UIColor cyanColor].CGColor;
    _otherLayer.position = _centerPoint;
//    _otherLayer.delegate = self;
//    [self.layer addSublayer:_otherLayer];
    
    self.backgroundLayer = [CALayer layer];
    _backgroundLayer.bounds = self.bounds;
    _backgroundLayer.position = _centerPoint;
    [self.layer addSublayer:_backgroundLayer];
}
/**
 *  每一部分的扇形
 */
- (void)sector{
    CGFloat start = 0;
    CGFloat end = 0;
    
    for (int i = 0; i < _rationArr.count; i++) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.bounds = _pictrueBounds;
        shapeLayer.position = _centerPoint;
        UIBezierPath *path = [UIBezierPath bezierPath];
        CGPoint pictureCenter = CGPointMake(_pictrueBounds.size.width / 2, _pictrueBounds.size.height / 2);
        
        end += [_rationArr[i] floatValue];
        
        CGFloat centerAngle = ((start * M_PI * 2 - M_PI_2) + (end * M_PI * 2 - M_PI_2)) / 2;
        CGPoint centerPoint = CGPointMake(_centerPoint.x + _radius * cos(centerAngle), _centerPoint.y + _radius * sin(centerAngle));
        CGPoint lineMiddlePoint =  CGPointMake(_centerPoint.x + (_radius + CCSectorViewLine) * cos(centerAngle), _centerPoint.y + (_radius + CCSectorViewLine) * sin(centerAngle));
        [self.middlePointArr addObject:[NSValue valueWithCGPoint:centerPoint]];
        [self.linePointArr addObject:[NSValue valueWithCGPoint:lineMiddlePoint]];
        
        [path moveToPoint:pictureCenter];
        [path addArcWithCenter:pictureCenter radius:_radius startAngle:(-M_PI_2 + start * M_PI * 2) endAngle:(end * M_PI * 2 - M_PI_2)  clockwise:YES];
        [path addLineToPoint:pictureCenter];
        
        start += [_rationArr[i] floatValue];
        
        
        shapeLayer.fillColor = _colorArr[i].CGColor;
        shapeLayer.path = path.CGPath;
        
        [self.pathArr addObject:path];
        [_backgroundLayer addSublayer:shapeLayer];
    }
    
}

/**
 *  动画。
 */
- (void)animation{
    self.shapeLayer = [CAShapeLayer layer];
    _shapeLayer.bounds = _pictrueBounds;
    _shapeLayer.position = _centerPoint;
    CGPoint pictureCenter = CGPointMake(_pictrueBounds.size.width / 2, _pictrueBounds.size.height / 2);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:pictureCenter radius:_radius / 2 startAngle:-M_PI_2 endAngle:M_PI * 3 / 2 clockwise:YES];
    _shapeLayer.path = path.CGPath;
    _shapeLayer.lineWidth = _radius;
    _shapeLayer.strokeColor = [UIColor greenColor].CGColor;
    _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    _shapeLayer.strokeStart = 0;
    _shapeLayer.strokeEnd = 0;
    _backgroundLayer.mask = _shapeLayer;
    
    CABasicAnimation *basic =[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    basic.toValue = @1;
    basic.duration = _timeDuration;
    basic.removedOnCompletion = NO;
    basic.fillMode = kCAFillModeForwards;
    basic.delegate = self;
    [self.shapeLayer addAnimation:basic forKey:nil];
}
#pragma mark - 动画代理
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self setNeedsDisplay];
}
/**
 *  画线
 */
- (void)drawRect:(CGRect)rect{
    if (_isNeedInstructionLine) {
        for (int i = 0; i < _linePointArr.count; i++) {
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:(CGPoint)[_middlePointArr[i] CGPointValue]];
            [path addLineToPoint:(CGPoint)[_linePointArr[i] CGPointValue]];
            [[UIColor blackColor] set];
            path.lineWidth = 1;
            [path stroke];
        }
    }
}


- (void)startAni{
    [self sector];
    [self animation];
}
@end
