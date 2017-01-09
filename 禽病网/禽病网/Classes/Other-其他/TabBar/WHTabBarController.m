//
//  WHTabBarController.m
//  禽病网
//
//  Created by WangHui on 2016/12/12.
//  Copyright © 2016年 wanghui. All rights reserved.
//

#import "WHTabBarController.h"
#import "WHQuotationViewController.h"
#import "WHCultureViewController.h"
#import "WHDiseaseViewController.h"
#import "WHMedicationViewController.h"
#import "WHNavigationController.h"

@interface WHTabBarController ()

@end

@implementation WHTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBar.backgroundColor = [UIColor whiteColor];
    // 添加所有的子控制器
    [self addChildViewControllers];
}

#pragma mark - 添加所有的子控制器
- (void)addChildViewControllers
{
    // 行情
    WHQuotationViewController *quotationVC = [[WHQuotationViewController alloc] init];
    [self addOneChildViewController:quotationVC title:@"行情" imageName:@"Tabbar_Feed_Normal" selectedImageName:nil];
    
    // 养殖
    WHCultureViewController *cultureVC = [[WHCultureViewController alloc] init];
    [self addOneChildViewController:cultureVC title:@"养殖" imageName:@"Tabbar_Discover_Normal" selectedImageName:nil];
    
    // 鸡病
    WHDiseaseViewController *diseaseVC = [[WHDiseaseViewController alloc] init];
    [self addOneChildViewController:diseaseVC title:@"鸡病" imageName:@"Tabbar_Messages_Normal" selectedImageName:nil];
    
    // 用药
    WHMedicationViewController *medicationVC = [[WHMedicationViewController alloc] init];
    [self addOneChildViewController:medicationVC title:@"用药" imageName:@"Tabbar_More_Normal" selectedImageName: nil];
}

#pragma mark - 添加单个子控制器
- (void)addOneChildViewController:(UIViewController *)vc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    //view 不向四周延展，原点从（导航栏）左下角开始算
    vc.edgesForExtendedLayout = UIRectEdgeNone;
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
//    vc.tabBarItem.selectedImage = [UIImage imageNamed: selectedImageName];
    
    WHNavigationController *nav = [[WHNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController: nav];
}

@end
