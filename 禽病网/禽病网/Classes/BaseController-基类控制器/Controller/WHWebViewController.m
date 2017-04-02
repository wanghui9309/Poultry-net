//
//  WHWebViewController.m
//  育龟答疑
//
//  Created by WangHui on 2016/12/17.
//  Copyright © 2016年 wanghui. All rights reserved.
//

#import "WHWebViewController.h"

#import <WebKit/WebKit.h>
#import <YYCategories/UIApplication+YYAdd.h>

@interface WHWebViewController ()<WKUIDelegate>

@property (weak,   nonatomic) WKWebView *wkWebView;
@property (strong, nonatomic) NSString *webUrl;

@end

@implementation WHWebViewController

/**
 快速创建控制器
 
 @param title 标题
 @param url 网页URL
 @return WHWebViewController
 */
+ (instancetype)WebViewControllerWithTitile:(NSString *)title withWebUrl:(NSString *)url
{
    WHWebViewController *webVc = [WHWebViewController new];
    webVc.title = [title stringByReplacingOccurrencesOfString:@"·" withString:@""];
    webVc.webUrl = [ServerUrl stringByAppendingPathComponent:url];
    
    return webVc;
}

- (WKWebView *)wkWebView
{
    if (_wkWebView == nil)
    {
        WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame];
//        webView.UIDelegate = self;
        webView.scrollView.bounces = NO;
        [self.view addSubview:webView];
        _wkWebView = webView;
    }
    return _wkWebView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self removeWKWebViewCahce];
    
    [self loadWkWebView];
}

/**
 删除WkWebvie 缓存
 */
- (void)removeWKWebViewCahce
{
    if([[UIDevice currentDevice].systemVersion floatValue] >= 9)
    {
        WKWebsiteDataStore *dateStore = [WKWebsiteDataStore defaultDataStore];
        [dateStore fetchDataRecordsOfTypes:[WKWebsiteDataStore allWebsiteDataTypes]
                         completionHandler:^(NSArray<WKWebsiteDataRecord *> * __nonnull records) {
                             for (WKWebsiteDataRecord *record  in records)
                             {
                                 [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:record.dataTypes
                                                                           forDataRecords:@[record]
                                                                        completionHandler:^{
                                                                            WHLog(@"Cookies for %@ deleted successfully",record.displayName);
                                                                        }];
                             }
                         }];
    }
    else
    {
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *path = [NSString stringWithFormat:@"/WebKit/%@/WebsiteData/LocalStorage", [[UIApplication sharedApplication] appBundleID]];
        NSString *webKitWebCachePath = [libraryPath stringByAppendingPathComponent:path];
        [[NSFileManager defaultManager] removeItemAtPath:webKitWebCachePath error:nil];
        WHLog(@"%@", webKitWebCachePath)
    }
}

/**
 加载WkWebView
 */
- (void)loadWkWebView
{
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
}

#pragma mark WKUIDelegate
//加载网页后，点击 按钮 或者 URL 进行跳转
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    if (!navigationAction.targetFrame.isMainFrame)
    {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

- (void)dealloc
{
    WHLog(@"%s", __func__)
}

@end
