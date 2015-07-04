//
//  REIThemeCellView.m
//  Bread2Where
//
//  Created by qianfeng on 15-6-14.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIThemeCellView.h"
#import "REIThemeModel.h"
#import "UIImageView+WebCache.h"
@interface REIThemeCellView ()


@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation REIThemeCellView

- (void)awakeFromNib {
    
}

+ (instancetype)themeCellViewWithTable:(UITableView *)tableView andObj:(id)obj
{   static NSString * ID = @"ThemeCell";
    UINib * nib = [UINib nibWithNibName:@"REIThemeCellView" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:ID];
    REIThemeCellView * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.model = obj;
    return cell;
}

- (void)setModel:(REIThemeModel *)model
{
    _model = model;
    self.imgView.contentMode = UIViewContentModeScaleToFill;
    [self.imgView makeCorner:5];
    
    NSURL * url = [NSURL URLWithString:model.image_url ];
    [self.imgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"featured_theme"]];

    self.titleLabel.text = model.title;
    self.nameLabel.text = model.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
