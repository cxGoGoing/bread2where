//
//  REIDesCell.m
//  Bread2Where
//
//  Created by FEI on 15/6/10.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIDesCell.h"
#import "REICity.h"
#import "REIRecDes.h"
@interface REIDesCell()
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end
@implementation REIDesCell
+(instancetype)desCellWithCollectionView:(UICollectionView *)collectionView andIndexPath:(NSIndexPath *)indexPath andObj:(id) obj {
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil] forCellWithReuseIdentifier:@"REIDesCell"];
    REIDesCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"REIDesCell" forIndexPath:indexPath];
    if ([obj isKindOfClass:[REICity class]]) {
        [cell setupCellWithCity:obj];
    }
    if ([obj isKindOfClass:[REIRecDes class]]) {
        [cell setupCellWithRecDes:obj];
    }
    [cell makeCorner:5];
    return cell;
}

-(void) setupCellWithCity:(REICity *)city
{
    [_mainImage sd_setImageWithURL:[NSURL URLWithString:city.cover]
                  placeholderImage:[UIImage imageNamed:@"featured_photo"]];
    _titleLab.text = city.name;
}

-(void) setupCellWithRecDes:(REIRecDes *)recDes
{
    _mainImage.contentMode = UIViewContentModeScaleAspectFill;
    [_mainImage sd_setImageWithURL:[NSURL URLWithString:recDes.cover] placeholderImage:[UIImage imageNamed:@"featured_photo"]];
    _titleLab.text = recDes.name;
}
@end
