//
//  UIView+Frame.m
//  禽病网
//
//  Created by WangHui on 2016/12/12.
//  Copyright © 2016年 wanghui. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (void)setX:(CGFloat)x
{
    CGRect frame   = self.frame;
    frame.origin.x = x;
    self.frame     = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame   = self.frame;
    frame.origin.y = y;
    self.frame     = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setW:(CGFloat)w
{
    CGRect frame     = self.frame;
    frame.size.width = w;
    self.frame       = frame;
}

- (CGFloat)w
{
    return self.frame.size.width;
}

- (void)setH:(CGFloat)h
{
    CGRect frame      = self.frame;
    frame.size.height = h;
    self.frame        = frame;
}

- (CGFloat)h
{
    return self.frame.size.height;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame   = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size   = size;
    self.frame   = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

/**
 颜色垂直渐变，从这个颜色渐变另外一个颜色
 
 @param startColor 起始颜色
 @param endColor 结束颜色
 */
- (void)verticalGradientFromWithColor:(UIColor *)startColor toColor:(UIColor *)endColor
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    gradientLayer.colors = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
    gradientLayer.locations = @[@(0.4),@(1.0)];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint   = CGPointMake(0, 1);
    [self.layer addSublayer:gradientLayer];
}

@end
