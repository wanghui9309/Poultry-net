//
//  WHProgressHUD.h
//  禽病网
//
//  Created by WangHui on 2016/12/13.
//  Copyright © 2016年 wanghui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WHProgressHUD : NSObject

/**
 显示HUD
 */
+ (void)showMBProgressHUD;

/**
 移除HUD
 */
+ (void)removeMBProgressHUD;

/**
 显示文本信息
 
 @param text 消息
 */
+ (void)showMessage:(NSString *)text;

@end
