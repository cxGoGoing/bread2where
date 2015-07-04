//
//  REIDesDetailCellView.h
//  Bread2Where
//
//  Created by qianfeng on 15-6-13.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import <UIKit/UIKit.h>
@class REICityDetailModel;
@interface REIDesDetailCellView : UICollectionViewCell
@property(nonatomic, strong)REICityDetailModel * model;

+ (instancetype)desDetailCellViewWith:(UICollectionView*)collectionView andIndexPath:(NSIndexPath*)indexPath andObj:(id)obj;
@end
