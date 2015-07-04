//
//  REIHotRecItemCell.m
//  Bread2Where
//
//  Created by FEI on 15/6/13.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIHotRecItemCell.h"
#import "REIHotDes.h"
#import "UIImage+Tint.h"
@interface REIHotRecItemCell()
@property (weak, nonatomic) IBOutlet UIButton *hotRecBtn;
@property (nonatomic, strong) REIHotDes * hotDes;
@end
@implementation REIHotRecItemCell

- (IBAction)hotRecBtnTouch:(id)sender {
    
    [self.delegate hotRecItemCellDelegate:self withHotRec:_hotDes];
    
}

+(instancetype) hotRecItemCellWithCollectionView:(UICollectionView *)collectionView andIndexPath:(NSIndexPath *)indexPath andObj:(REIHotDes *)obj{
    
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil] forCellWithReuseIdentifier:CLAZZ_STR];
    REIHotRecItemCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CLAZZ_STR forIndexPath:indexPath];
    cell.userInteractionEnabled = YES;
    cell.hotRecBtn.width = cell.frame.size.width - 10;
    [cell setupHotDesItem:obj];
    [cell makeCorner:5];
    return cell;
}

-(void)setupHotDesItem:(REIHotDes *)hotDes {
    _hotDes = hotDes;
    [_hotRecBtn setTitle:hotDes.name forState:UIControlStateNormal];
//    [_hotRecBtn setTitle:hotDes.name forState:UIControlStateNormal];
    [_hotRecBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:187/255.0 green:224/255.0 blue:220/255.0 alpha:1] andSize:_hotRecBtn.size] forState:UIControlStateHighlighted];
    _hotRecBtn.layer.borderWidth = 0.5;
    _hotRecBtn.layer.borderColor = [UIColor colorWithRed:45/255.0 green:160/255.0 blue:178/255.0 alpha:1].CGColor;
    [_hotRecBtn makeCorner:12];
    [_hotRecBtn setTitleColor:[UIColor colorWithRed:45/255.0 green:160/255.0 blue:178/255.0 alpha:1] forState:UIControlStateNormal];
}

@end
