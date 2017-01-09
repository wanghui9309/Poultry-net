//
//  WHQuotationViewController.m
//  禽病网
//
//  Created by WangHui on 2016/12/12.
//  Copyright © 2016年 wanghui. All rights reserved.
//

#import "WHQuotationViewController.h"

@interface WHQuotationViewController ()

@end

@implementation WHQuotationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataSourceArr = [self getDataFromePlistWithKey:QuotaionKey];
}

@end
