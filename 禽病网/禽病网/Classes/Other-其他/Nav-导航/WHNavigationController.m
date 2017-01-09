//
//  WHNavigationController.m
//  禽病网
//
//  Created by WangHui on 2016/12/12.
//  Copyright © 2016年 wanghui. All rights reserved.
//

#import "WHNavigationController.h"

#import "UIBarButtonItem+Extension.h"

@interface WHNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation WHNavigationController

+ (void)load
{
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    /*
     navBar.barTintColor = WTColor(42, 183, 103);
     navBar.translucent = NO;
     */
    // 当设置不透明的图片，效果是如上面的代码，会导致View位移，在控制器里面使用 extendedLayoutIncludesOpaqueBars = YES就行了
    [navBar setBackgroundImage: [UIImage imageWithColor:NavBackGroundColor] forBarMetrics:UIBarMetricsDefault];
    
    //隐藏NavBar黑线
//    navBar.shadowImage = [[UIImage alloc] init];
    NSDictionary *textAttr = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    [navBar setTitleTextAttributes:textAttr];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1、取消系统手势返回功能
    self.interactivePopGestureRecognizer.enabled = NO;
    
    /*
     <UIScreenEdgePanGestureRecognizer: 0x135e89c80; state = Possible; enabled = NO; delaysTouchesBegan = YES; view = <UILayoutContainerView 0x135dc6100>; target= <(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x135e89790>)>>
     
     */
    
    // 2、添加全屏返回手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    
    //状态栏样式
//    self.navigationBar.barStyle = UIStatusBarStyleLightContent;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 非根控制器隐藏tabBar
    if (self.childViewControllers.count >= 1)
    {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithImage:[UIImage imageNamed:@"nav_back_normal"] highImage:nil target:self action: @selector(back) title:nil];
    }
    //当NavBar使用了不透明图片时，视图是否延伸至NavBar所在区域，默认值时NO
//    viewController.extendedLayoutIncludesOpaqueBars = YES;
    [super pushViewController:viewController animated:animated];
}

#pragma mark - 点击事件
- (void)back
{
    [self popViewControllerAnimated:YES];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return self.childViewControllers.count > 1;
}

- (void)handleNavigationTransition:(UIPanGestureRecognizer *)pan{}

@end
