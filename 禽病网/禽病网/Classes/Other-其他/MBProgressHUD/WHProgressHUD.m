//
//  WHProgressHUD.m
//  禽病网
//
//  Created by WangHui on 2016/12/13.
//  Copyright © 2016年 wanghui. All rights reserved.
//

#import "WHProgressHUD.h"

#import <MBProgressHUD/MBProgressHUD.h>

@implementation WHProgressHUD

#pragma mark - MBProgressHUD
/**
 显示HUD
 */
+ (void)showMBProgressHUD
{
    UIViewController *currentVC = [WHProgressHUD currentViewController:WHProgressHUD.rootViewController];
    [MBProgressHUD showHUDAddedTo:currentVC.view animated:YES];
}

/**
 移除HUD
 */
+ (void)removeMBProgressHUD
{
    UIViewController *currentVC = [WHProgressHUD currentViewController:WHProgressHUD.rootViewController];
    [MBProgressHUD hideHUDForView:currentVC.view animated:YES];
}

/**
 显示文本信息
 
 @param text 消息
 */
+ (void)showMessage:(NSString *)text
{
    UIViewController *currentVC = [WHProgressHUD currentViewController:WHProgressHUD.rootViewController];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:currentVC.view animated:YES];
    hud.label.text = text;
    // 设置模式
    hud.mode = MBProgressHUDModeText;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:1.0];
}

/**
 获得根控制器
 */
+ (UIViewController *)rootViewController
{
    return UIApplication.sharedApplication.delegate.window.rootViewController;
}

/**
 得到当前控制器
 
 @param vc 控制器
 */
+ (UIViewController *)currentViewController:(UIViewController *)vc
{
    if ([vc isKindOfClass:[UINavigationController class]])
    {
        return [self currentViewController:[(UINavigationController *)vc topViewController]];
    }
    else if ([vc isKindOfClass:[UITabBarController class]])
    {
        return [self currentViewController:((UITabBarController *)vc).selectedViewController];
    }
    else if (vc.presentedViewController)
    {
        return vc.presentedViewController;
    }
    return vc;
}

@end
