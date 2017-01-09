//
//  NSAttributedString+Extension.h
//  育龟答疑
//
//  Created by WangHui on 2016/12/14.
//  Copyright © 2016年 wanghui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (Extension)

/**
 处理页面无数据时返回的字符及样式
 
 @param text 文本信息
 @return 新的文本
 */
+ (NSAttributedString *)noDataDescriptionAttributedWith:(NSString *)text;

@end
