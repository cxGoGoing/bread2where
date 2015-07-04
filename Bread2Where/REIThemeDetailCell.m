//
//  REIThemeDetailCell.m
//  Bread2Where
//
//  Created by qianfeng on 15-6-15.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIThemeDetailCell.h"
#import "REIThemeDetailFrameCell.h"
#import "UIImageView+WebCache.h"
#import "REIThemeArticleModel.h"
@interface REIThemeDetailCell()
@property(nonatomic, weak)UILabel * title;//标题
@property(nonatomic, weak)UIImageView * image_url;//图片
@property(nonatomic, weak)UILabel * descriptionLabel;//描述
@property(nonatomic, weak)UILabel * trip_name;//旅行名字
@property(nonatomic, weak)UILabel * user_name;//作者名字


@end
@implementation REIThemeDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //图片
        UIImageView * imageView = [[UIImageView alloc]init];
        [self.contentView addSubview:imageView];
        self.image_url = imageView;
        
        //名字
        UILabel * nameLabel = [[UILabel alloc]init];
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.font = [UIFont systemFontOfSize:15];
        //旅游
        UILabel * tripLabel = [[UILabel alloc]init];
        tripLabel.textColor = [UIColor whiteColor];
        tripLabel.font = [UIFont systemFontOfSize:15];

        self.trip_name = nameLabel;
        self.trip_name = tripLabel;
        [imageView addSubview:nameLabel];
        [imageView addSubview:tripLabel];
        
        //描述
        UILabel * descLabel = [[UILabel alloc]init];
        descLabel.font = DescFont;
        [self.contentView addSubview:descLabel];
        descLabel.numberOfLines = 0;
        self.descriptionLabel = descLabel;

    }
    return self;
}


- (void)setDetailFrame:(REIThemeDetailFrameCell *)detailFrame
{
    _detailFrame = detailFrame;
    //1.设置数据
    [self settingData];
    //2.设置frame
    [self settingFrame];
}

- (void)settingData
{
    //获取数据
    REIThemeArticleModel * model = self.detailFrame.articleModel;
    
    //图片
    NSURL * url =[NSURL URLWithString:model.image_url];
    if (model.image_url.length > 0) {
        [self.image_url sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"featured_theme"]];
    } else {
        [self.image_url sd_setImageWithURL:url];
    }
    

    //描述
    self.descriptionLabel.text = model.desc;
    self.descriptionLabel.textColor = [UIColor grayColor];
    
    REINoteModel * noteDict = model.noteModel;
    self.trip_name.text = noteDict.trip_name;
    self.user_name.text = noteDict.user_name;
}

- (void)settingFrame
{
    self.image_url.frame = self.detailFrame.imageF;
    
    self.descriptionLabel.frame = self.detailFrame.descripF;
    
    CGFloat trip_nameX = 5;
    CGFloat trip_nameY = CGRectGetMaxY(self.image_url.frame) - 20;
    CGFloat trip_nameW = 300;
    CGFloat trip_nameH = 10;
    self.trip_name.frame = CGRectMake(trip_nameX, trip_nameY, trip_nameW, trip_nameH);

    CGFloat user_nameX = 5;
    CGFloat user_nameY = CGRectGetMaxY(self.image_url.frame) - 10;
    CGFloat user_nameW = 300;
    CGFloat user_nameH = 10;
    self.user_name.frame = CGRectMake(user_nameX, user_nameY, user_nameW, user_nameH);

}

+ (instancetype)themeDetailCellWithTableView:(UITableView *)tableView
{
    static NSString * ID = @"articleCell";
    
    REIThemeDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[REIThemeDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
   
 return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
