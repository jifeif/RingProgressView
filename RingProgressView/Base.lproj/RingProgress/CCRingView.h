//
//  CCRingView.h
//  RingProgressView
//
//  Created by 9188iMac on 16/4/15.
//  Copyright © 2016年 9188iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCRingView : UIView

/**
 *  圆环每一部分所占的比例.
 */
@property (nonatomic, strong) NSArray * ratioArr;
/**
 *  圆环每一部分的颜色。
 */
@property (nonatomic, strong) NSArray<UIColor *> * colorArr;
/**
 *  起始角度
 */
@property (nonatomic, assign) CGFloat startAngle;
/**
 *  终止角度
 */
@property (nonatomic, assign) CGFloat endAngle;
/**
 *  半径
 */
@property (nonatomic, assign) CGFloat radius;
/**
 *  圆环的宽度
 */
@property (nonatomic, assign) CGFloat ringWidth;
/**
 *  动画时间
 */
@property (nonatomic, assign) CGFloat duration;
/**
 *  开始动画
 */
- (void)startAnimation;
/**
 *  清楚动画
 */
- (void)clearAnimation;
@end
