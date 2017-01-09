//
//  WHBaseItem.h
//  禽病网
//
//  Created by WangHui on 2017/1/4.
//  Copyright © 2017年 wanghui. All rights reserved.
//

FOUNDATION_EXTERN NSString *const QuotaionKey;
FOUNDATION_EXTERN NSString *const CultureKey;
FOUNDATION_EXTERN NSString *const DiseaseKey;
FOUNDATION_EXTERN NSString *const MedicationKey;

#import <Foundation/Foundation.h>

@interface WHBaseItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *url;

@end
