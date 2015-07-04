//
//  REIDesDetailJPViewCell.m
//  Bread2Where
//
//  Created by qianfeng on 15-6-16.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIDesDetailJPViewCell.h"
#import "UIImageView+WebCache.h"
#import "REIDestDetailJPModel.h"


@interface REIDesDetailJPViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (weak, nonatomic) IBOutlet UILabel *dayCountLabel;
@property (weak, nonatomic) IBOutlet UIView *dot1;
@property (weak, nonatomic) IBOutlet UIView *dot2;


@property (weak, nonatomic) IBOutlet UILabel *waypointsLabel;
@property (weak, nonatomic) IBOutlet UILabel *recommendationsLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end
@implementation REIDesDetailJPViewCell

- (void)awakeFromNib {
    // Initialization code
}
+ (instancetype)desDetailJPViewCellWithTableView:(UITableView *)tableView andObj:(id)obj
{
    static NSString * ID = @"JPcell";
//    REIDesDetailJPViewCell * cell =[tableView dequeueReusableCellWithIdentifier:ID];
//    if (cell == nil) {
//        cell = [[REIDesDetailJPViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//    }
    
    UINib * nib = [UINib nibWithNibName:@"REIDesDetailJPViewCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:ID];
    REIDesDetailJPViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    [cell makeCorner:5];
    cell.model = obj;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setModel:(REIDestDetailJPModel *)model
{
    _model = model;
    self.nameLabel.text = model.name;
    self.nameLabel.font = [UIFont boldSystemFontOfSize:17];
    NSURL * url = [NSURL URLWithString:model.cover_image_w640];
    
    [self.imgView makeCorner:5];
    [self.imgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"trip_waypoint_photo_placeholder"]];
    
    self.imgView.contentMode = UIViewContentModeScaleToFill; //剪裁图片
    self.dot1.backgroundColor = [UIColor colorWithRed:62/255.0 green:176/255.0 blue:193/255.0 alpha:1];
    self.dot2.backgroundColor = [UIColor colorWithRed:62/255.0 green:176/255.0 blue:193/255.0 alpha:1];
    [self.dot1 makeCorner:2.5];
    [self.dot2 makeCorner:2.5];
    self.lineView.backgroundColor = [UIColor colorWithRed:62/255.0 green:176/255.0 blue:193/255.0 alpha:1];
    [self.lineView makeCorner:2];
    //分割字符串
    NSArray * separatorArray = [model.cover_image componentsSeparatedByString:@"_"];
    NSMutableString * dayString = [NSMutableString string];
    for (int i = 1; i < separatorArray.count-1; i++)
    {
        NSString * string = [NSString stringWithFormat:@"%@.", separatorArray[i]];
        [dayString appendString:string];
        
    }
    [dayString deleteCharactersInRange:NSMakeRange(dayString.length - 1, 1)];
    self.timeLabel.text = dayString;
    
    NSString * way = [NSString stringWithFormat:@"%ld",model.waypoints];
    self.waypointsLabel.text =way;
    

    //天数
    NSString * dayCount = [NSString stringWithFormat:@"%ld天",model.day_count];
    self.dayCountLabel.text = dayCount;
    //足迹
    self.waypointsLabel.text = [NSString stringWithFormat:@"%ld 足迹",model.waypoints];
    
    self.recommendationsLabel.text = [NSString stringWithFormat:@"%ld 喜欢",model.recommendations];
}

@end
