//
//  AppDelegate.m
//  禽病网
//
//  Created by WangHui on 2016/12/12.
//  Copyright © 2016年 wanghui. All rights reserved.
//

#import "AppDelegate.h"

#import "WHTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

//app 程序准备开始运行
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //状态栏样式
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    // 1、创建窗口
    self.window = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
    
    // 2、设置根控制器
    self.window.rootViewController = [[WHTabBarController alloc] init];
    
    // 3、显示窗口
    [self.window makeKeyAndVisible];
    
    return YES;
}

//app 将要失去焦点
- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

//app 已经进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

// app 将要进入前台
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

//app 已经获得焦点
- (void)applicationDidBecomeActive:(UIApplication *)application
{

}

//app 将要终止
- (void)applicationWillTerminate:(UIApplication *)application
{

}

@end
