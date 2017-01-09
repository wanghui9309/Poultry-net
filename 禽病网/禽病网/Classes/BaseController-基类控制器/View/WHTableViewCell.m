//
//  WHTableViewCell.m
//  禽病网
//
//  Created by WangHui on 2017/1/8.
//  Copyright © 2017年 wanghui. All rights reserved.
//

#import "WHTableViewCell.h"

#import "WHQuotationDetailItem.h"

@implementation WHTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/**
 设置数据

 @param item 模型
 */
- (void)setUpDatawithItem:(WHQuotationDetailItem *)item
{
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.time;
}

@end
