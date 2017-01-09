//
//  WHDiseaseViewController.m
//  禽病网
//
//  Created by WangHui on 2016/12/12.
//  Copyright © 2016年 wanghui. All rights reserved.
//

#import "WHDiseaseViewController.h"

@interface WHDiseaseViewController ()

@end

@implementation WHDiseaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataSourceArr = [self getDataFromePlistWithKey:DiseaseKey];
}

@end
