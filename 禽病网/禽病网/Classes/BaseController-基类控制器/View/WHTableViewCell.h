//
//  WHTableViewCell.h
//  禽病网
//
//  Created by WangHui on 2017/1/8.
//  Copyright © 2017年 wanghui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WHQuotationDetailItem;
@interface WHTableViewCell : UITableViewCell

/**
 设置数据
 
 @param item 模型
 */
- (void)setUpDatawithItem:(WHQuotationDetailItem *)item;

@end
