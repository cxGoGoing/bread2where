//
//  REIHotRecView.m
//  Bread2Where
//
//  Created by FEI on 15/6/13.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIHotRecView.h"
#import "REIHotRecItemCell.h"
#import "REIHotDes.h"
#import "REIHotRecHeaderView.h"
#define MARGIN 12
@interface REIHotRecView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,REIHotRecItemCellDelegate>
{
    UICollectionView * _collectionView;
}
@property(nonatomic,weak) REIHotRecView * hotRecView;

@end
@implementation REIHotRecView

+(instancetype) hotRecView {
    return [[self alloc] initWithFrame:CGRectZero];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        
        [self setupCollectionView];
    }
    return self;
}

- (void) setupCollectionView {
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT) collectionViewLayout:flowLayout];
//    _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 80, 0);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor colorWithRed:250/255.0 green:246/255.0 blue:232/255.0 alpha:1.0];
    _collectionView.userInteractionEnabled = YES;
    _collectionView.delaysContentTouches = NO;
    [self addSubview:_collectionView];
}

-(void)setAbroadData:(NSMutableArray *)abroadData
{
    _abroadData = abroadData;
    [_collectionView reloadData];
}

-(void)setInsideData:(NSMutableArray *)insideData
{
    _insideData = insideData;
    [_collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.abroadData.count;
    } else if(section == 1) {
        return self.insideData.count;
    }
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    REIHotRecItemCell * cell;
    if (indexPath.section == 0) {
        cell = [REIHotRecItemCell hotRecItemCellWithCollectionView:collectionView andIndexPath:indexPath andObj:self.abroadData[indexPath.item]];
    } else if (indexPath.section == 1) {
        cell = [REIHotRecItemCell hotRecItemCellWithCollectionView:collectionView andIndexPath:indexPath andObj:self.insideData[indexPath.item]];
    }
    cell.delegate = self;
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([UICollectionElementKindSectionHeader isEqualToString:kind]) {
        REIHotRecHeaderView * header = [REIHotRecHeaderView hotRecHeaderWithCollectionView:collectionView andIndexPath:indexPath];
        
        return header;
    }
    return nil;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return CGSizeMake(MAIN_SCREEN_WIDTH, 75);
    }
    return CGSizeMake(MAIN_SCREEN_WIDTH, 68);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger width = (MAIN_SCREEN_WIDTH - 2 * MARGIN - 2 * 8) / 3;
    return CGSizeMake(width, 35);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, MARGIN, 0, MARGIN);
}

-(void)hotRecItemCellDelegate:(REIHotRecItemCell *)hotRecItemCell withHotRec:(REIHotDes *)hotDes
{
    [_delegate hotRecViewDelegate:self withHotRec:hotDes];
    
}



-(void)willMoveToSuperview:(UIView *)newSuperview
{
    self.frame = newSuperview.bounds;
}

@end
