//
//  GPcellDetailFrameModel.m
//  面包旅行
//
//  Created by qianfeng on 15-6-13.
//  Copyright (c) 2015年 李中飞. All rights reserved.
//
#define LITextFont [UIFont systemFontOfSize:12]
#import "GPcellDetailFrameModel.h"
#import "GPcellDetailModel.h"
#import "GPcellDetailWaypointsM.h"

@implementation GPcellDetailFrameModel

+(id)cellDetailFrameModel
{
    return [[GPcellDetailFrameModel alloc]init];
}

//计算文字尺寸
-(CGSize)setNameFontSize:(NSString *)text andFont:(UIFont *)font andMaxSize:(CGSize)maxSize
{
    NSDictionary * atts=@{NSFontAttributeName:font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:atts context:nil].size;
    
}
/**
 *  计算Frame
 *
 *  @param cellDetailW <#cellDetailW description#>
 */
-(void)setCellDetailW:(GPcellDetailWaypointsM *)cellDetailW
{
    _cellDetailW=cellDetailW;
    /**
     *  计算各个子控件的Frame
     */
    //photo的Frame
    CGFloat padding=10;
    CGFloat photoImageViewX=padding;
    CGFloat photoImageViewY=padding;
    CGFloat photoImageViewW=MAIN_SCREEN_WIDTH-20;
    CGFloat photoImageViewH=cellDetailW.photo_H;
    
    _photoF=CGRectMake(photoImageViewX, photoImageViewY, photoImageViewW, photoImageViewH);
    
    //text的Frame
    CGFloat textX=photoImageViewX;
    CGFloat textY=CGRectGetMaxY(_photoF)+padding;
    CGSize textSize=[self setNameFontSize:self.cellDetailW.text andFont:LITextFont andMaxSize:CGSizeMake(MAIN_SCREEN_WIDTH-20, MAXFLOAT)];
    _textF=CGRectMake(textX, textY, textSize.width, textSize.height);
    
    //最后的日期local_time
    CGFloat local_timeX=photoImageViewX + 16;
    CGFloat local_timeY=CGRectGetMaxY(_textF)+padding;
    CGFloat local_timeW=textSize.width + 100;
    CGFloat local_timeH=15;//随便给的
    
    _local_timeF=CGRectMake(local_timeX, local_timeY, local_timeW, local_timeH);
    
    //cell的高度
    _cellHeight=CGRectGetMaxY(_local_timeF)+padding;
}


@end
