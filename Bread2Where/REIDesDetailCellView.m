//
//  REIDesDetailCellView.m
//  Bread2Where
//
//  Created by qianfeng on 15-6-13.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIDesDetailCellView.h"
#import "UIImageView+WebCache.h"
#import "REICityDetailModel.h"
@interface REIDesDetailCellView()

@property (weak, nonatomic) IBOutlet UIImageView *img;


@property(nonatomic, copy)NSString * cover;

@end
@implementation REIDesDetailCellView

+ (instancetype)desDetailCellViewWith:(UICollectionView*)collectionView andIndexPath:(NSIndexPath*)indexPath andObj:(id)obj
{
    static NSString * ID =@"cell";
    UINib * nib = [UINib nibWithNibName:@"REIDesDetailCellView" bundle:nil];
    [collectionView registerNib:nib forCellWithReuseIdentifier:ID];

    REIDesDetailCellView * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.model = obj;
    return cell;
}

- (void)setModel:(REICityDetailModel *)model
{
    _model = model;
    self.img.contentMode = UIViewContentModeScaleAspectFill;
    NSURL * url = [NSURL URLWithString:model.photo];
    
    [self.img sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"featured_photo"]];
    
    [self.img makeCorner:8];
}
@end
