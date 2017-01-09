//
//  UIBarButtonItem+Extension.h
//  禽病网
//
//  Created by WangHui on 2016/12/12.
//  Copyright © 2016年 wanghui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)


/**
 返回按钮

 @param image 默认图片
 @param highImage 高亮图片
 @param target 接收者
 @param action 执行方法
 @param title 文字
 @return 返回按钮
 */
+ (UIBarButtonItem *)backItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action title:(NSString *)title;

@end
