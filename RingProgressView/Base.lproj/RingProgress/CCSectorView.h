//
//  CCSectorView.h
//  RingProgressView
//
//  Created by 9188iMac on 16/4/27.
//  Copyright © 2016年 9188iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCSectorView : UIView

/**
 *  比例数组。
 */
@property (nonatomic, strong) NSArray * rationArr;
/**
 *  颜色数组。
 */
@property (nonatomic, strong) NSArray<UIColor *> *colorArr;
/**
 *  扇形大小
 */
@property (nonatomic, assign) CGRect pictrueBounds;
/**
 *  扇形半径。
 */
@property (nonatomic, assign) CGFloat radius;
/**
 *  动画时间。
 */
@property (nonatomic, assign) CGFloat timeDuration;
/**
 *  是否需要显示指示线
 */
@property (nonatomic, assign) BOOL isNeedInstructionLine;
- (void)startAni;
@end
