//
//  UIView+Frame.h
//  禽病网
//
//  Created by WangHui on 2016/12/12.
//  Copyright © 2016年 wanghui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat w;
@property (nonatomic, assign) CGFloat h;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize  size;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

/**
 颜色垂直渐变，从这个颜色渐变另外一个颜色
 
 @param startColor 起始颜色
 @param endColor 结束颜色
 */
- (void)verticalGradientFromWithColor:(UIColor *)startColor toColor:(UIColor *)endColor;

@end
