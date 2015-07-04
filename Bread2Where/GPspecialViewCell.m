//
//  GPspecialViewCell.m
//  面包旅行
//
//  Created by qianfeng on 15-6-11.
//  Copyright (c) 2015年 李中飞. All rights reserved.
//

#import "GPspecialViewCell.h"
#import "GPspecialProductModel.h"
#import "UIImageView+WebCache.h"

@interface GPspecialViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *specialImageView;
@property (weak, nonatomic) IBOutlet UILabel *specialTitle;
@property (weak, nonatomic) IBOutlet UILabel *specialDateLab;
@property (weak, nonatomic) IBOutlet UILabel *specialWhererLab;
@property (weak, nonatomic) IBOutlet UILabel *specialMinPrice;
@property (weak, nonatomic) IBOutlet UILabel *specialCurrentPrice;


@end


@implementation GPspecialViewCell

+(id)specialViewCell:(UITableView *)tableView
{
    static NSString * const specialCellIdentifier=@"special";
    
    UINib * nib=[UINib nibWithNibName:@"GPspecialViewCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:specialCellIdentifier];
    GPspecialViewCell * cell=[tableView dequeueReusableCellWithIdentifier:specialCellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    cell.specialImageView.layer.cornerRadius=8;
    cell.specialImageView.layer.masksToBounds=YES;
    
    return cell;
    
}
-(void)setSpecialProductM:(GPspecialProductModel *)specialProductM
{
    _specialProductM=specialProductM;
     
    NSMutableString * dateString=[NSMutableString string];
    
    [self.specialImageView sd_setImageWithURL:[NSURL URLWithString:specialProductM.cover] placeholderImage:[UIImage imageNamed:@"featured_sale"]];
    self.specialImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.specialTitle.text=specialProductM.title;
    self.specialTitle.textColor = [UIColor darkGrayColor];
    self.specialTitle.font = [UIFont systemFontOfSize:16];
    self.specialWhererLab.text=specialProductM.depart_place;
    self.specialWhererLab.textColor = [UIColor grayColor];

    
    NSString * tempstr = [NSString stringWithFormat:@"%ld 元起",(long)specialProductM.min_price];
    
    if (MAIN_SCREEN_WIDTH == 320) {
        self.specialMinPrice.attributedText = [self setContent:tempstr andIndex:3 andSize1:16.0 andSize2:12.0 andFont1:@"Courier-BoldOblique" andFont2:@"Arial-BoldItalicMT" andColor1:[UIColor redColor] andColor2:USEFUL_COLOR1];
    } else {
        self.specialMinPrice.attributedText = [self setContent:tempstr andIndex:3 andSize1:20.0 andSize2:12.0 andFont1:@"Courier-BoldOblique" andFont2:@"Arial-BoldItalicMT" andColor1:[UIColor redColor] andColor2:USEFUL_COLOR1];
    }
    
    

    
    for(NSString * str in specialProductM.depart_dates)
    {
        
        [dateString appendString:str];
        [dateString appendString:@" "];
    }
    self.specialDateLab.text=[NSString stringWithFormat:@"出发日期:   %@",dateString];
    self.specialDateLab.textColor = [UIColor grayColor];
    self.specialWhererLab.text=specialProductM.depart_place;
    
    //市场价格
    NSString * priceStr =[NSString stringWithFormat:@"市场价:￥%ld",(long)specialProductM.market_price];
   
    
    self.specialCurrentPrice.attributedText = [self setContent:priceStr andIndex:priceStr.length - 4 + 1 andSize1:11.0 andSize2:13.0 andFont1:@"Courier-BoldOblique" andFont2:@"Courier-BoldOblique" andColor1:[UIColor lightGrayColor] andColor2:[UIColor lightGrayColor]];
    
}

//设置字体的大小
- (NSMutableAttributedString *)setContent:(NSString *)tempstr andIndex:(NSInteger)index andSize1:(CGFloat)size1 andSize2:(CGFloat)size2 andFont1:(NSString *)font1 andFont2:(NSString *)font2 andColor1:(UIColor *)color1 andColor2:(UIColor *)color2;
{
    NSMutableAttributedString * attriString = [[NSMutableAttributedString alloc] initWithString:tempstr];
    
    //价格
    [attriString addAttribute:NSForegroundColorAttributeName value:color1 range:NSMakeRange(0, tempstr.length - index)];
    //元起
    [attriString addAttribute:NSForegroundColorAttributeName value:color2 range:NSMakeRange(tempstr.length - index, index)];
    
    //字体的大小
    [attriString addAttribute:NSFontAttributeName value:[UIFont fontWithName:font1 size:size1] range:NSMakeRange(0, tempstr.length - index)];
    
    [attriString addAttribute:NSFontAttributeName value:[UIFont fontWithName:font2  size:size2] range:NSMakeRange(tempstr.length - index, index)];
    return attriString;

}




@end
