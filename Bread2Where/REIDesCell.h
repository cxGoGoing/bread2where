//
//  REIDesCell.h
//  Bread2Where
//
//  Created by FEI on 15/6/10.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface REIDesCell : UICollectionViewCell
+(instancetype)desCellWithCollectionView:(UICollectionView *)collectionView andIndexPath:(NSIndexPath *)indexPath andObj:(id) obj;
@end
