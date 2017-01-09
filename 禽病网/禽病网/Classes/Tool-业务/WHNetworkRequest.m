//
//  WHNetworkRequest.m
//  禽病网
//
//  Created by WangHui on 2016/12/12.
//  Copyright © 2016年 wanghui. All rights reserved.
//

#import "WHNetworkRequest.h"

#import "WHNetworkActivityIndicator.h"
#import "Reachability.h"
#import <AFNetworking/AFNetworking.h>

typedef NS_ENUM(NSInteger, NetworkRequestType)
{
    NetworkRequestType_GET,    //GET请求
    NetworkRequestType_POST    //POST请求
};

@interface WHNetworkRequest()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) NSMutableSet<NSURLSessionTask *> *operationTask;

@end

@implementation WHNetworkRequest

SHARE_INSTANCE_M(NetworkRequest, WHNetworkRequest)

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.requestSerializer.timeoutInterval = 15.0f;
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sessionManager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", @"image/png",nil];
        
        _operationTask = [NSMutableSet set];
        
#if TARGET_OS_IOS
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backgroundNotification) name:UIApplicationDidEnterBackgroundNotification object:nil];
#endif
    }

    return self;
}

#pragma mark -
#pragma mark requestMethod
/**
 发起请求

 @param requestType 请求类型
 @param urlStr url
 @param parameters 参数
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
- (void)requestWithNetworkType:(NetworkRequestType)requestType
                       withUrl:(NSString *)urlStr
                withParameters:(NSDictionary *)parameters
                       success:(void (^)(id responseObject))success
                       failure:(void (^)(NSError *error))failure
{
    BOOL isReachable = [[Reachability reachabilityForInternetConnection] isReachable];
    if (!isReachable)
    {
        if (failure) failure(nil);
        return;
    }
    
    [[WHNetworkActivityIndicator sharedActivityIndicator] startActivity];
    
    __weak typeof(self) weakSelf = self;
    //请求成功的回调
    void (^successBlock)(NSURLSessionTask *task, id responseObject) = ^(NSURLSessionTask *task, id responseObject){
        
        [weakSelf.operationTask removeObject:task];
        [[WHNetworkActivityIndicator sharedActivityIndicator] stopActivity];
        
        WHLog(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        
        if (success)
        {
            success(responseObject);
        }
    };
    
    //请求失败的回调
    void (^failureBlock)(NSURLSessionTask *task, NSError *error) = ^(NSURLSessionTask *task, NSError *error){
        
        [weakSelf.operationTask removeObject:task];
        [[WHNetworkActivityIndicator sharedActivityIndicator] stopActivity];
        
        WHLog(@"%@", error);
        
        if (failure)
        {
            failure(error);
        }
    };
    
    NSURLSessionTask *task = nil;
    urlStr = [@"http://www.qinbing.cn" stringByAppendingPathComponent:urlStr];
    
    switch (requestType)
    {
        case NetworkRequestType_GET:
        {
            task = [_sessionManager GET:urlStr parameters:parameters progress:nil success:successBlock failure:failureBlock];
        }
            break;
            
        case NetworkRequestType_POST:
        {
            task = [_sessionManager POST:urlStr parameters:parameters progress:nil success:successBlock failure:failureBlock];
        }
            break;
            
        default:
            break;
    }
    [_operationTask addObject:task];
}

/**
 GET请求

 @param urlStr URL
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
- (void)GETWithUrl:(NSString *)urlStr success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    [self requestWithNetworkType:NetworkRequestType_GET withUrl:urlStr withParameters:nil success:success failure:failure];
}

/**
 POST请求

 @param urlStr URL
 @param parameters 参数
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
- (void)POSTWithUrl:(NSString *)urlStr withParameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    [self requestWithNetworkType:NetworkRequestType_POST withUrl:urlStr withParameters:parameters success:success failure:failure];
}

#pragma mark -
#pragma mark Notification
/**
 进入后台通知
 */
- (void)backgroundNotification
{
    [self cancelAllTask];
    [[WHNetworkActivityIndicator sharedActivityIndicator] stopAllActivity];
}

/**
 取消全部task
 */
- (void)cancelAllTask
{
    for (NSURLSessionTask *task in _operationTask)
    {
        [task cancel];
    }
    [_operationTask removeAllObjects];
}

- (void)dealloc
{
    [self backgroundNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
