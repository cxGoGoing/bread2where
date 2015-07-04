//
//  REINearbyCell.m
//  Bread2Where
//
//  Created by FEI on 15/6/11.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REINearbyCell.h"
#import "REINearbyItem.h"
#import "StarView.h"
@interface REINearbyCell()
@property (weak, nonatomic) IBOutlet UIImageView *conver_s;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet StarView *ratingView;
@property (weak, nonatomic) IBOutlet UILabel *recommenderLab;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *visitedLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@end
@implementation REINearbyCell

+(instancetype)nearbyCellAndTableView:(UITableView *)tableView andObj:(id)obj
{
    UINib * nib = [UINib nibWithNibName:CLAZZ_STR bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:CLAZZ_STR];
    REINearbyCell * cell = [tableView dequeueReusableCellWithIdentifier:CLAZZ_STR];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = obj;
    return cell;
}

-(void)setModel:(REINearbyItem *)model
{
    _model = model;
    _mainView.backgroundColor = [UIColor clearColor];
    NSURL * url = [NSURL URLWithString:model.cover_s];
    [self.conver_s sd_setImageWithURL:url placeholderImage: [UIImage imageNamed:
     @"featured_sale"]];
    [self.conver_s makeCorner:8];
    
    self.nameLabel.text = model.name;
    NSString * name = @" 点评";
    NSString * tipsCount = [NSString stringWithFormat:@"%ld",model.tips_count];
    NSString * tips = [tipsCount stringByAppendingString:name];
    
    self.tipLabel.text = tips;
    self.recommenderLab.text = model.recommended_reason;
    NSString * distanceStr = [NSString stringWithFormat:@"%.0f",model.distance];
    NSString * distance;
    if ([distanceStr floatValue] < 1.0) {
        distance = [[NSString stringWithFormat:@"%d",(int)([distanceStr floatValue] * 1000)] stringByAppendingString:@" M"];
    } else {
        distance = [[NSString stringWithString:distanceStr]  stringByAppendingString:@" KM"];
    }
    
    self.distanceLabel.text = distance;
    NSString * visited_count = [NSString stringWithFormat:@"%ld 人去过",model.visited_count];
    self.visitedLabel.text = visited_count;
    

    [self.ratingView setRating:model.rating];
//    self.ratingView.backgroundColor = [UIColor redColor];
}

@end
