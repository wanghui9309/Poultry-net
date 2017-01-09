//
//  WHBaseViewController.m
//  禽病网
//
//  Created by WangHui on 2016/12/27.
//  Copyright © 2016年 wanghui. All rights reserved.
//

#import "WHBaseViewController.h"
#import "WHTitleBarController.h"
#import "WHPageViewController.h"
#import "WHTableViewController.h"

#import <MJExtension/MJExtension.h>

@interface WHBaseViewController ()

@property (strong, nonatomic) WHPageViewController *pageVC;
@property (strong, nonatomic) WHTitleBarController *titleBar;

@end

@implementation WHBaseViewController

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.titleBar.view.frame = CGRectMake(0, 0, WHScreenWidth, 40);
    self.pageVC.view.frame = CGRectMake(0, self.titleBar.view.h, WHScreenWidth, WHScreenHeight - 40 - 64 - 49);
}

/**
 得到标题和Url
 */
- (NSMutableArray<WHBaseItem *> *)getDataFromePlistWithKey:(NSString *)key
{
    NSMutableArray<WHBaseItem *> *items = [NSMutableArray array];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TitleWithURL" ofType:@"plist"];
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] initWithContentsOfFile:path][key];
    for (NSDictionary *dict in dataDict[@"data"])
    {
        [items addObject:[WHBaseItem mj_objectWithKeyValues:dict]];
    }
    return items;
}

- (void)setDataSourceArr:(NSArray<WHBaseItem *> *)dataSourceArr
{
    _dataSourceArr = [NSArray arrayWithArray:dataSourceArr];
    [self initTitleBar];
    [self initPageViewController];
}

/**
 初始化TitleBar控制器
 */
- (void)initTitleBar
{
    __weak typeof(self) weakSelf = self;
    self.titleBar = [WHTitleBarController titleBarControllerWithOperationBlock:^(NSInteger index) {
        [weakSelf.pageVC selectViewControllerAtIndex:index];
    }];    
    self.titleBar.dataSourceArr = [self.dataSourceArr valueForKey:@"title"];
    [self addChildViewController:self.titleBar];
    [self.view addSubview:self.titleBar.view];
}

/**
 初始化Page控制器
 */
- (void)initPageViewController
{
    NSMutableArray<UIViewController *> *viewControllers = [NSMutableArray array];
    for (int i = 0; i < self.dataSourceArr.count; i++)
    {
        WHTableViewController *vc = [WHTableViewController tableViewControllerWithUrl:self.dataSourceArr[i].url];
        [viewControllers addObject:vc];
    }

    __weak typeof(self) weakSelf = self;
    self.pageVC = [WHPageViewController PageViewControllerWithViewControllers:^(NSInteger index) {
        [weakSelf.titleBar selectTitleWithIndex:index];
    }];
    self.pageVC.viewControllerArr = viewControllers;
    [self addChildViewController:self.pageVC];
    [self.view addSubview:self.pageVC.view];
}

@end
