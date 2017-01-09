//
//  WHPageViewController.m
//  禽病网
//
//  Created by WangHui on 2016/12/29.
//  Copyright © 2016年 wanghui. All rights reserved.
//

#import "WHPageViewController.h"

@interface WHPageViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@end

@implementation WHPageViewController

/**
 快速创建

 @param operationBlack 操作回调
 @return WHPageViewController
 */
+ (instancetype)PageViewControllerWithViewControllers:(void (^)(NSInteger index))operationBlack
{
    //定义两个页面之间的间距
    NSDictionary *options = @{UIPageViewControllerOptionInterPageSpacingKey : @0};
    WHPageViewController *page = [[WHPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
    page.operationBlack = operationBlack;
    
    return page;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self;
    self.dataSource = self;
    
    [self selectViewControllerAtIndex:0];
}

/**
 选着控制器

 @param index 索引
 */
- (void)selectViewControllerAtIndex:(NSInteger)index
{
    NSArray<UIViewController *> *controllerArr = @[[self viewControllerAtIndex:index]];

    [self setViewControllers:controllerArr direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

/**
 得到当前控制器的下标
 */
- (NSInteger)indexOfViewControllers:(UIViewController *)currentVC
{
    return [self.viewControllerArr indexOfObject:currentVC];
}

/**
 根据下标得到控制器

 @param index 下标
 @return 控制器
 */
- (UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if ([self.viewControllerArr count] == 0 || index >= [self.viewControllerArr count]) return nil;

    return [self.viewControllerArr objectAtIndex:index];
}

#pragma mark - UIPageViewControllerDataSource
/**
 这个方法是返回前一个页面,如果返回为nil,那么UIPageViewController就会认为当前页面是第一个页面不可以向前滚动或翻页
 */
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [self indexOfViewControllers:viewController];
    if (index == 0) return nil;
    
    index--;
    return [self viewControllerAtIndex:index];
}
/**
 这个方法是下一个页面,如果返回为nil,那么UIPageViewController就会认为当前页面是最后一个页面不可以向后滚动或翻页
 */
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewControllers:viewController];
    if (index == NSNotFound) return nil;

    index++;
    if (index == [self.viewControllerArr count]) return nil;

    return [self viewControllerAtIndex:index];
}

#pragma mark UIPageViewControllerDelegate
/**
 这个方法是UIPageViewController开始滚动或翻页的时候触发
 */
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
{

}
/**
 这个方法是在UIPageViewController结束滚动或翻页的时候触发
 */
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    NSInteger index = [self indexOfViewControllers:pageViewController.viewControllers.firstObject];
    
    if (self.operationBlack) self.operationBlack(index);
}

@end
