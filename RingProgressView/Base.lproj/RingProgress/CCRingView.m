//
//  CCRingView.m
//  RingProgressView
//
//  Created by 9188iMac on 16/4/15.
//  Copyright © 2016年 9188iMac. All rights reserved.
//

#import "CCRingView.h"

@interface CCRingView ()
@property (strong, nonatomic) NSMutableArray<CAShapeLayer *> *layerArr; //保存生成的Layer数组
@property (strong, nonatomic) NSMutableArray<CABasicAnimation *> *animationArr; //保存生成的动画数组。
@property (nonatomic, assign) NSInteger excuteAnimation;//正在执行第几个动画
@property (nonatomic, assign) CGFloat startRatio;     //每一份环 动画开始位置
@property (nonatomic, assign) CGFloat endRatio;    //每一份环 动画结束位置
@end

@implementation CCRingView
- (void)awakeFromNib{
    self.excuteAnimation = 1;
    _startRatio = 0;
    _endRatio = 0;
    self.layerArr = [NSMutableArray array];
    self.animationArr = [NSMutableArray array];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.excuteAnimation = 1;
        self.layerArr = [NSMutableArray array];
        self.animationArr = [NSMutableArray array];
    }
    return self;
}

#pragma mark - 
/**
 *  创建每一部分的圆环图层
 */
- (void)createShapeLayer{
    //中心点
    CGPoint centerPoint = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    //半径
    _radius = (_radius > 0 && (_radius <= self.bounds.size.height / 2)) ? _radius : self.bounds.size.height / 2;
    _radius = (_ringWidth > 1) ? (_radius - _ringWidth / 2.0) : _radius;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:_radius startAngle:_startAngle endAngle:_endAngle clockwise:YES];
    
    for (int i = 0; i < self.ratioArr.count; i++) {
        CAShapeLayer * shapeLayer = [CAShapeLayer layer];
        shapeLayer.bounds = self.bounds;
        shapeLayer.position = centerPoint;
        shapeLayer.lineWidth = _ringWidth;
        shapeLayer.path = path.CGPath;
        shapeLayer.strokeColor = [UIColor clearColor].CGColor;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.strokeStart = 0;
        // zPosition 值越大，在superLayer上的位置越靠上。
        shapeLayer.zPosition = self.ratioArr.count - i;
        [self.layer addSublayer:shapeLayer];
        [self.layerArr addObject:shapeLayer];
        
        
        if (i == 0) {
            _startRatio = 0;
        }else{
            _startRatio += [_ratioArr[i - 1] floatValue];
        }
        _endRatio += [_ratioArr[i] floatValue];
        
        //mark  CA动画中 removedOnCompletion 必须与 fillMode 配套使用。
        CABasicAnimation * basciAni = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        basciAni.fromValue = @(_startRatio);
        basciAni.toValue = @(_endRatio);
        basciAni.duration = _duration * [_ratioArr[i] floatValue];
        basciAni.repeatCount = 1;
        basciAni.removedOnCompletion = NO;
        basciAni.fillMode = kCAFillModeForwards;
        basciAni.delegate = self;
        [self.animationArr addObject:basciAni];
    }
    self.layerArr[0].strokeColor = _colorArr[0].CGColor;
    [self.layerArr[0] addAnimation:self.animationArr[0] forKey:nil];
}

#pragma mark - animation delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (self.excuteAnimation == self.layerArr.count) {
        return;
    }
    self.layerArr[_excuteAnimation].strokeColor = _colorArr[_excuteAnimation].CGColor;
    [self.layerArr[self.excuteAnimation] addAnimation:self.animationArr[self.excuteAnimation] forKey:nil];
    self.excuteAnimation++;
}

#pragma mark - 移除执行过的动画
/**
 *  移除执行过的动画
 */
- (void)removeLayerAndAnimation{
    [self.layerArr removeObjectAtIndex:0];
    [self.animationArr removeObjectAtIndex:0];
}
/**
 *  开始动画
 */
- (void)startAnimation{
    [self createShapeLayer];
}
/**
 *  清空动画
 */
- (void)clearAnimation{
    for (CAShapeLayer *shapeLayer in self.layerArr) {
        [shapeLayer removeFromSuperlayer];
    }
    _startRatio = 0;
    _excuteAnimation = 1;
    _endRatio = 0;
    [self.layerArr removeAllObjects];
    [self.animationArr removeAllObjects];   
}
@end
