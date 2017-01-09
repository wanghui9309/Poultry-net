//
//  WHNetworkRequest.h
//  禽病网
//
//  Created by WangHui on 2016/12/12.
//  Copyright © 2016年 wanghui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WHNetworkRequest : NSObject

SHARE_INSTANCE_H(NetworkRequest)

/**
 GET请求
 
 @param urlStr URL
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
- (void)GETWithUrl:(NSString *)urlStr success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 POST请求
 
 @param urlStr URL
 @param parameters 参数
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
- (void)POSTWithUrl:(NSString *)urlStr withParameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
