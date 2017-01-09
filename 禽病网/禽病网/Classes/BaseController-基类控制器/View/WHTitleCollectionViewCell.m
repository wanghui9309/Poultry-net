//
//  WHTitleCollectionViewCell.m
//  禽病网
//
//  Created by WangHui on 2016/12/27.
//  Copyright © 2016年 wanghui. All rights reserved.
//

#import "WHTitleCollectionViewCell.h"

@interface WHTitleCollectionViewCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *lineLab;

@end

@implementation WHTitleCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

/**
 设置标题
 
 @param title 标题
 @param select 是否选中
 */
- (void)setUpTitle:(NSString *)title withSelected:(BOOL)select
{
    self.titleLab.text = title;
    
    [self cellSelected:select];
}

- (void)cellSelected:(BOOL)selected
{
    if (selected)
    {
        self.titleLab.textColor = [UIColor redColor];
        self.lineLab.hidden = NO;
    }
    else
    {
        self.titleLab.textColor = [UIColor blackColor];
        self.lineLab.hidden = YES;
    }
}

@end
