//
//  StarView.m
//  CustomCellDemo
//
//  Created by leisure on 14-4-9.
//  Copyright (c) 2014年 leisure. All rights reserved.
//

#import "StarView.h"

@implementation StarView

-(void)createContent
{
    self.backgroundColor=[UIColor clearColor];
    
    bgView=[[UIImageView alloc] initWithFrame:CGRectMake(0,0 , 65, 23)];
    //内容布局左对齐
    bgView.contentMode=UIViewContentModeLeft;
    bgView.image=[UIImage imageNamed:@"StarsBackground"];
    foreView=[[UIImageView alloc] initWithFrame:CGRectMake(0,0 , 65, 23)];
    //内容布局左对齐
    foreView.contentMode=UIViewContentModeLeft;
    foreView.image=[UIImage imageNamed:@"StarsForeground"];
    foreView.clipsToBounds=YES;
    [self addSubview:bgView];
    [self addSubview:foreView];
    
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createContent];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if (self) {
        [self createContent];
    }
    return self;
}
-(void)setRating:(CGFloat)rating
{
    CGRect frame=bgView.frame;
    //根据星级计算新宽度
    frame.size.width=frame.size.width*(rating/5.0f);
    foreView.frame=frame;
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
