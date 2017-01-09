//
//  WHBaseViewController.h
//  禽病网
//
//  Created by WangHui on 2016/12/27.
//  Copyright © 2016年 wanghui. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WHBaseItem.h"

@interface WHBaseViewController : UIViewController

@property (nonatomic, strong) NSArray<WHBaseItem *> *dataSourceArr;

/**
 得到标题和Url
 */
- (NSMutableArray<WHBaseItem *> *)getDataFromePlistWithKey:(NSString *)key;

@end
