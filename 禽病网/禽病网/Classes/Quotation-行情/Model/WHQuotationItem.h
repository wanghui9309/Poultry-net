//
//  WHQuotationItem.h
//  禽病网
//
//  Created by WangHui on 2017/1/7.
//  Copyright © 2017年 wanghui. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WHQuotationDetailItem.h"

@interface WHQuotationItem : NSObject

@property (nonatomic, strong) NSString *page;
@property (nonatomic, strong) NSString *nextPage;
@property (nonatomic, strong) NSMutableArray<WHQuotationDetailItem *> *detailItems;

@end
