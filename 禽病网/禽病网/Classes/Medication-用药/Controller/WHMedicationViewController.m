//
//  WHMedicationViewController.m
//  禽病网
//
//  Created by WangHui on 2016/12/12.
//  Copyright © 2016年 wanghui. All rights reserved.
//

#import "WHMedicationViewController.h"

@interface WHMedicationViewController ()

@end

@implementation WHMedicationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataSourceArr = [self getDataFromePlistWithKey:MedicationKey];
}

@end
