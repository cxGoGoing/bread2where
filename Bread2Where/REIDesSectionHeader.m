//
//  REIDesSectionHeader.m
//  Bread2Where
//
//  Created by FEI on 15/6/11.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIDesSectionHeader.h"
@interface REIDesSectionHeader()
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end
@implementation REIDesSectionHeader

+(instancetype)desSectionHeaderWithCollectionView:(UICollectionView *)collectionView andIndexPath:(NSIndexPath *)indexPath
{
    [collectionView registerNib:[UINib nibWithNibName:CLAZZ_STR bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CLAZZ_STR];
    REIDesSectionHeader * sectionHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CLAZZ_STR forIndexPath:indexPath];
    [sectionHeader setupItems];
    return sectionHeader;
}

-(void)setupItems {
    [_lineView setBackgroundColor:[UIColor colorWithRed:59/255.0 green:186/255.0 blue:201/255.0 alpha:1]];
    [_lineView makeCorner:4];
   
}

@end
