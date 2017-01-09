//
//  NSAttributedString+Extension.m
//  育龟答疑
//
//  Created by WangHui on 2016/12/14.
//  Copyright © 2016年 wanghui. All rights reserved.
//

#import "NSAttributedString+Extension.h"

@implementation NSAttributedString (Extension)

/**
 处理页面无数据时返回的字符及样式
 
 @param text 文本信息
 @return 新的文本
 */
+ (NSAttributedString *)noDataDescriptionAttributedWith:(NSString *)text
{
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{
                                 NSFontAttributeName : [UIFont systemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName : WHColor(162, 190, 212),
                                 NSParagraphStyleAttributeName : paragraphStyle
                                 };
    return [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
}


@end
