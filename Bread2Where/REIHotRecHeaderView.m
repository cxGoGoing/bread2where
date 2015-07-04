//
//  REIHotRecHeaderView.m
//  Bread2Where
//
//  Created by FEI on 15/6/13.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIHotRecHeaderView.h"
@interface REIHotRecHeaderView()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UIView *line2;

@end
@implementation REIHotRecHeaderView
+(instancetype)hotRecHeaderWithCollectionView:(UICollectionView *)collectionView andIndexPath:(NSIndexPath *)indexPath
{
    [collectionView registerNib:[UINib nibWithNibName:CLAZZ_STR bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CLAZZ_STR];
    REIHotRecHeaderView * sectionHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CLAZZ_STR forIndexPath:indexPath];
    if(indexPath.section == 0) {
        sectionHeader.line2.hidden = YES;
        sectionHeader.titleLab.text = @"国外热门目的地";
    } else if(indexPath.section == 1) {
        sectionHeader.line2.hidden = NO;
        sectionHeader.line2.backgroundColor = [UIColor colorWithRed:59/255.0 green:188/255.0 blue:201/255.0 alpha:1];
        sectionHeader.titleLab.text = @"国内热门目的地";
    }
    sectionHeader.titleLab.textColor = [UIColor colorWithRed:59/255.0 green:188/255.0 blue:201/255.0 alpha:1];
    sectionHeader.line.backgroundColor = [UIColor colorWithRed:59/255.0 green:188/255.0 blue:201/255.0 alpha:1];

    return sectionHeader;
}


@end
