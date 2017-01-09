//
//  WHTitleBarController.m
//  禽病网
//
//  Created by WangHui on 2016/12/30.
//  Copyright © 2016年 wanghui. All rights reserved.
//

#import "WHTitleBarController.h"

#import "WHTitleCollectionViewCell.h"

#import <YYCategories/NSString+YYAdd.h>

@interface WHTitleBarController ()<UICollectionViewDelegateFlowLayout>

@property (assign, nonatomic) NSInteger selectIndex;

@end

@implementation WHTitleBarController

static NSString *const reuseIdentifier = @"TitleCollectionViewCell";

/**
 快速创建

 @param operationBlock 操作回调
 @return WHTitleBarController
 */
+ (instancetype)titleBarControllerWithOperationBlock:(void (^)(NSInteger index))operationBlock
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    WHTitleBarController *titleBar = [[WHTitleBarController alloc] initWithCollectionViewLayout:layout];
    titleBar.operationBlock = operationBlock;
    
    return titleBar;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([WHTitleCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, WHScreenWidth, 0.5)];
    lineView.backgroundColor = [UIColor colorWithWhite:0.1f alpha:1.0f];
    [self.view addSubview:lineView];
}

/**
 选中的标题
 
 @param index index
 */
- (void)selectTitleWithIndex:(NSInteger)index
{
    self.selectIndex = index;
    [self.collectionView reloadData];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSourceArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WHTitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell setUpTitle:self.dataSourceArr[indexPath.row] withSelected:self.selectIndex == indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self selectTitleWithIndex:indexPath.row];
    if (self.operationBlock) self.operationBlock(indexPath.row);
}

#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = [self.dataSourceArr[indexPath.row] widthForFont:[UIFont systemFontOfSize:17.0f]] + 10;
    
    return CGSizeMake(width, 39);
}

@end
