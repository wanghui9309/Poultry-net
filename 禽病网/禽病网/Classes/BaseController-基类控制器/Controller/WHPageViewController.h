//
//  WHPageViewController.h
//  禽病网
//
//  Created by WangHui on 2016/12/29.
//  Copyright © 2016年 wanghui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WHPageViewController : UIPageViewController

@property (nonatomic, strong) NSArray<UIViewController *> *viewControllerArr;
@property (nonatomic, strong) void (^operationBlack)(NSInteger index);

/**
 快速创建
 
 @param operationBlack 操作回调
 @return WHPageViewController
 */
+ (instancetype)PageViewControllerWithViewControllers:(void (^)(NSInteger index))operationBlack;

/**
 选着控制器
 
 @param index 索引
 */
- (void)selectViewControllerAtIndex:(NSInteger)index;

@end
