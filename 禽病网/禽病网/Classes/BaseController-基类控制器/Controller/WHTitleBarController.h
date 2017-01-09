//
//  WHTitleBarController.h
//  禽病网
//
//  Created by WangHui on 2016/12/30.
//  Copyright © 2016年 wanghui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WHTitleBarController : UICollectionViewController

@property (nonatomic, strong) NSArray<NSString *> *dataSourceArr;
@property (nonatomic, strong) void (^operationBlock)(NSInteger index);

/**
 快速创建
 
 @param operationBlock 操作回调
 @return WHTitleBarController
 */
+ (instancetype)titleBarControllerWithOperationBlock:(void (^)(NSInteger index))operationBlock;

/**
 选中的标题
 
 @param index index
 */
- (void)selectTitleWithIndex:(NSInteger)index;

@end
