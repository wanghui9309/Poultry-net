//
//  WHTableViewController.m
//  禽病网
//
//  Created by WangHui on 2016/12/29.
//  Copyright © 2016年 wanghui. All rights reserved.
//

#import "WHTableViewController.h"
#import "WHWebViewController.h"

#import "WHQuotationItem.h"

#import "WHTableViewCell.h"

#import "NSAttributedString+Extension.h"
#import "TFHpple.h"
#import <YYCategories/NSString+YYAdd.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import <MJRefresh/MJRefresh.h>
#import <WebKit/WebKit.h>

@interface WHTableViewController ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate, WKNavigationDelegate>

/** 数据模型 */
@property (nonatomic, strong) WHQuotationItem *item;
/** url */
@property (nonatomic, strong) NSString *url;
/** 是否加载成功 */
@property (nonatomic, assign) BOOL isLoadSuccess;
/** 网页View */
@property (nonatomic, weak) WKWebView *wkWebView;

@end

@implementation WHTableViewController

static NSString *const reuseIdentifier = @"TableViewCell";

/**
 快速创建

 @param url url
 @return WHTableViewController
 */
+ (instancetype)tableViewControllerWithUrl:(NSString *)url
{
    WHTableViewController *tableVC = [WHTableViewController new];
    tableVC.url = url;
    
    return tableVC;
}

- (WHQuotationItem *)item
{
    if (_item == nil)
    {
        _item = [WHQuotationItem new];
    }
    return _item;
}

- (WKWebView *)wkWebView
{
    if (_wkWebView == nil)
    {
        WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame];
        webView.hidden = YES;
        webView.navigationDelegate = self;
        webView.scrollView.bounces = NO;
        [self.view insertSubview:webView atIndex:0];
        _wkWebView = webView;
    }
    return _wkWebView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 200;
    self.tableView.rowHeight = 60;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WHTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    
    self.isLoadSuccess = YES;
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestDataWithUrl:weakSelf.url];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestDataWithUrl:weakSelf.item.nextPage];
    }];
}

/**
 请求数据
 */
- (void)requestDataWithUrl:(NSString *)urlStr
{
    NSURL *url = [NSURL URLWithString:[ServerUrl stringByAppendingPathComponent:urlStr]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.wkWebView loadRequest:request];
}

/**
 结束刷新
 */
- (void)endRefreshing
{
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    __weak typeof(self) weakSelf = self;
    /** 获取网页html */
    [webView evaluateJavaScript:@"document.body.innerHTML" completionHandler:^(NSString * _Nullable html, NSError * _Nullable error) {
        if (html.length !=0)
        {
            [weakSelf tableWithData:[html dataUsingEncoding:NSUTF8StringEncoding]];
        }
        else
        {
            weakSelf.isLoadSuccess = NO;
            [weakSelf endRefreshing];
        }
    }];
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark 根据data解析出table 数据
- (void)tableWithData:(NSData *)data
{
    @autoreleasepool {
        // 解析html数据
        TFHpple *table = [[TFHpple alloc] initWithHTMLData:data];
        WHQuotationItem *item = self.item;
        
        // 根据标签来进行过滤
        NSArray *td = [table searchWithXPathQuery:@"//td"];
        NSMutableArray<WHQuotationDetailItem *> *detailItems = [NSMutableArray array];
        
        for (TFHppleElement *element in td)
        {
            NSArray *div = [element searchWithXPathQuery:@"//div"];
            WHQuotationDetailItem *detailItem = [WHQuotationDetailItem new];
            
            TFHppleElement *list2Elem = div.firstObject;
            detailItem.title = [list2Elem.content stringByTrim];
            
            TFHppleElement *hrefElem = [list2Elem searchWithXPathQuery:@"//a"].firstObject;
            detailItem.href = [hrefElem objectForKey:@"href"];
            
            TFHppleElement *list3Elem = div.lastObject;
            detailItem.time = [list3Elem.content stringByTrim];
            
            [detailItems addObject:detailItem];
        }
        
        NSArray *span = [table searchWithXPathQuery:@"//span"];
        for (TFHppleElement *element in span)
        {
            TFHppleElement *fontElem = [element searchWithXPathQuery:@"//font"].firstObject;
            item.page = fontElem.content;
            
            TFHppleElement *nextPageElem = [element searchWithXPathQuery:@"//a"].lastObject;
            item.nextPage = [nextPageElem objectForKey:@"href"];
        }
        
        if ([item.page isEqualToString:@"1"])
        {
            item.detailItems = detailItems;
        }
        else
        {
            [item.detailItems addObjectsFromArray:detailItems];
        }
        self.item = item;
    }
    
    [self endRefreshing];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.item.detailItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell setUpDatawithItem:self.item.detailItems[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = self.item.detailItems[indexPath.row].title;
    NSString *url = self.item.detailItems[indexPath.row].href;

    WHWebViewController *webVC = [WHWebViewController WebViewControllerWithTitile:title withWebUrl:url];
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - DZNEmptyDataSetSource
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSAttributedString *attrib = nil;
    if (_isLoadSuccess)
    {
        attrib = [NSAttributedString noDataDescriptionAttributedWith:@"数据加载中..."];
    }
    else
    {
        attrib = [NSAttributedString noDataDescriptionAttributedWith:@"数据加载失败"];
    }
    return attrib;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"img_profile_none"];
}

/**
 处理空白区域的点击事件
 */
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    [self.tableView.mj_header beginRefreshing];
}

- (void)dealloc
{
    WHLog(@"%s", __func__)
}

@end
