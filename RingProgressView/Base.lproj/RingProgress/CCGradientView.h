//
//  CCGradientView.h
//  RingProgressView
//
//  Created by 9188iMac on 16/4/18.
//  Copyright © 2016年 9188iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCGradientView : UIView
/**
 *  起始角度
 */
@property (nonatomic, assign) CGFloat startAngle;
/**
 *  结束角度
 */
@property (nonatomic, assign) CGFloat endAngle;
/**
 *  遮罩环的宽度。
 */
@property (nonatomic, assign) CGFloat lineWidth;
/**
 *  进度。
 */
@property (nonatomic, assign) CGFloat progress;
/**
 *  渐变颜色数组。
 */
@property (nonatomic, strong) NSArray<UIColor *> * colorArr;
/**
 *  开始
 */
- (void)start;
@end
