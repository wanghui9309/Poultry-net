//
//  WHTableViewController.h
//  禽病网
//
//  Created by WangHui on 2016/12/29.
//  Copyright © 2016年 wanghui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WHTableViewController : UITableViewController

/**
 快速创建
 
 @param url url
 @return WHTableViewController
 */
+ (instancetype)tableViewControllerWithUrl:(NSString *)url;

@end
