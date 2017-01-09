//
//  WHTitleCollectionViewCell.h
//  禽病网
//
//  Created by WangHui on 2016/12/27.
//  Copyright © 2016年 wanghui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WHTitleCollectionViewCell : UICollectionViewCell

/**
 设置标题
 
 @param title 标题
 @param select 是否选中
 */
- (void)setUpTitle:(NSString *)title withSelected:(BOOL)select;

@end
