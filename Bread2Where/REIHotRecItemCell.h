//
//  REIHotRecItemCell.h
//  Bread2Where
//
//  Created by FEI on 15/6/13.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import <UIKit/UIKit.h>
@class REIHotRecItemCell;
@class REIHotDes;
@protocol REIHotRecItemCellDelegate <NSObject>
- (void)hotRecItemCellDelegate:(REIHotRecItemCell *)hotRecItemCell withHotRec:(REIHotDes *)hotDes;
@end

@interface REIHotRecItemCell : UICollectionViewCell
@property(nonatomic,weak) id<REIHotRecItemCellDelegate>delegate;
+(instancetype) hotRecItemCellWithCollectionView:(UICollectionView *)collectionView andIndexPath:(NSIndexPath *)indexPath andObj:(REIHotDes *)obj;
@end
