//
//  CLPhotoFlowLayout.m
//  CLPhotoBrower
//
//  Created by zyyt on 16/12/1.
//  Copyright © 2016年 zyyt. All rights reserved.
//

#import "CLPhotoFlowLayout.h"
#import "CLImageBrower.h"
@interface CLPhotoFlowLayout ()

//section的数量
@property (nonatomic) NSInteger numberOfSections;

//section中Cell的数量
@property (nonatomic) NSInteger numberOfCellsInSections;
@end

@implementation CLPhotoFlowLayout

#pragma mark -- <UICollectionViewLayout>虚基类中重写的方法

/**
 * 该方法是预加载layout, 只会被执行一次
 */
- (void)prepareLayout{
    [super prepareLayout];
    [self initData];
}


/**
 * 该方法返回CollectionView的ContentSize的大小
 */
- (CGSize)collectionViewContentSize{
    
    return CGSizeMake((kCLScreenWidth + kCLImageSpace) * _numberOfCellsInSections,kCLScreenHeight);
}

/**
 * 该方法为每个Cell绑定一个Layout属性~
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *array = [NSMutableArray array];
    
    //add cells
    for (int i=0; i < _numberOfCellsInSections; i++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        [array addObject:attributes];
    }
    
    return array;
    
}

/**
 * 该方法为每个Cell绑定一个Layout属性~
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGRect frame = CGRectZero;
    
    CGFloat cellHeight = kCLScreenHeight;
    
    CGFloat cellWidth = kCLScreenWidth;
    
    CGFloat tempX = (kCLScreenWidth + kCLImageSpace) * indexPath.row;
    
    CGFloat tempY = 0;
    
    frame = CGRectMake(tempX, tempY, cellWidth, cellHeight);
    
    //计算每个Cell的位置
    attributes.frame = frame;
    
    return attributes;
}
/**
 * 初始化相关数据
 */
- (void) initData{
    _numberOfSections = [self.collectionView numberOfSections];
    _numberOfCellsInSections = [self.collectionView numberOfItemsInSection:0];
}

@end
