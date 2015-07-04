//
//  GPcellDetailCell.m
//  面包旅行
//
//  Created by qianfeng on 15-6-13.
//  Copyright (c) 2015年 李中飞. All rights reserved.
//
#define LITextFont [UIFont systemFontOfSize:12]
#define LIdateFont [UIFont systemFontOfSize:10]
#import "GPcellDetailCell.h"
#import "GPcellDetailWaypointsM.h"
#import "GPcellDetailFrameModel.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+ProgressView.h"
@interface GPcellDetailCell()


@end

@implementation GPcellDetailCell

+(id)cellDetailCellWithTableView:(UITableView *)tableView
{
    static NSString * cellDetailCellID=@"DetailCell";
    GPcellDetailCell * cell=[tableView dequeueReusableCellWithIdentifier:cellDetailCellID];
    if (cell==nil) {
        cell=[[GPcellDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellDetailCellID];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell makeCorner:10];
    return cell;
    
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        /**
         *  创建cell上得子控件
         */

        UIImageView * imageView=[[UIImageView alloc]init];
        [self.contentView addSubview:imageView];
        self.photoImageView=imageView;
        
        UILabel * textLab=[[UILabel alloc]init];
        [self.contentView addSubview:textLab];
        textLab.numberOfLines=0;
        textLab.font=LITextFont;
        self.textLab=textLab;
        
        
        UILabel * local_timeLab=[[UILabel alloc]init];
        [self.contentView addSubview:local_timeLab];
        local_timeLab.font=LIdateFont;
        self.local_timeLab=local_timeLab;
        
        
        UIImageView * clockView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"clock_gray"]];
        self.clockImageView = clockView;
        [self addSubview:clockView];
        

    }
    return self;

}

-(void)setCellDetailF:(GPcellDetailFrameModel *)cellDetailF
{
    _cellDetailF=cellDetailF;
    
    //设置数据
    [self setData];
    //设置Frame
    [self setFrame];
    
}
/**
 *  设置数据
 */
-(void)setData
{
    GPcellDetailWaypointsM * cellDetailWay=_cellDetailF.cellDetailW;
    if(cellDetailWay.photo == nil || cellDetailWay.photo.length == 0) {
        [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:cellDetailWay.photo]];
    } else {
        [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:cellDetailWay.photo] placeholderImage:[UIImage imageNamed:@"poi_bg_placeholder"] usingProgressView:UIProgressViewStyleDefault];
    }
    
    self.textLab.text=cellDetailWay.text;
    self.local_timeLab.text=cellDetailWay.local_time;
}

/**
 *  设置Frame
 */
-(void)setFrame
{
    self.photoImageView.frame=_cellDetailF.photoF;
    [self.photoImageView makeCorner:10];
    self.textLab.frame=_cellDetailF.textF;
    self.textLab.textColor = [UIColor darkGrayColor];
    self.local_timeLab.frame=_cellDetailF.local_timeF;
    self.local_timeLab.textColor = [UIColor grayColor];
    self.clockImageView.frame = CGRectMake(CGRectGetMinX(self.local_timeLab.frame) - 15, CGRectGetMinY(self.local_timeLab.frame) + 1, 13, 13);
}



@end
