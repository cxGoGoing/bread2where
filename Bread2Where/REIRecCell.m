//
//  REIRecCell.m
//  Bread2Where
//
//  Created by FEI on 15/6/10.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIRecCell.h"
#import "REITrip.h"
#import "REIUser.h"
@interface REIRecCell()
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIImageView *tripImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *dayLab;
@property (weak, nonatomic) IBOutlet UILabel *locLab;
@property (weak, nonatomic) IBOutlet UILabel *viewtimeLab;
@property (weak, nonatomic) IBOutlet UILabel *userNameLab;
@property (weak, nonatomic) IBOutlet UIImageView *userHeaderIcon;
@end
@implementation REIRecCell

+(instancetype)recCellWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath andObj:(REITrip *)trip{
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil] forCellReuseIdentifier:@"REIRecCell"];
    REIRecCell * cell = [tableView dequeueReusableCellWithIdentifier:@"REIRecCell"];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell loadTrip:trip];
    return cell;
}

-(void)loadTrip:(REITrip *) trip {
    self.tripImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.tripImage sd_setImageWithURL:[NSURL URLWithString:trip.cover_image_default] placeholderImage:[UIImage imageNamed:@"featured_theme"]];
    [self.tripImage makeCorner:7];
    
    NSDate * date = [[NSDate alloc]initWithTimeIntervalSince1970:trip.first_day];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy.MM.dd";
    NSString * dateStr = [dateFormatter stringFromDate:date];
    self.timeLab.text = dateStr;
    
    [self.lineView makeCorner:2];
    [self.lineView setBackgroundColor:[UIColor colorWithRed:62/255.0 green:176/255.0 blue:193/255.0 alpha:1]];
    
    self.dayLab.text = [NSString stringWithFormat:@"%ld天",trip.day_count];
    self.titleLab.text = trip.name;
    self.viewtimeLab.text = [NSString stringWithFormat:@"%ld次浏览",trip.view_count];
    
    self.locLab.text = trip.popular_place_str;
    
    self.userNameLab.text = trip.user.name;
    self.userHeaderIcon.contentMode = UIViewContentModeScaleAspectFill;
    [self.userHeaderIcon sd_setImageWithURL:[NSURL URLWithString:trip.user.avatar_l] placeholderImage:[UIImage imageNamed:@"avatar_placeholder_26"]];
    [self.userHeaderIcon makeCorner:13];
}
@end
