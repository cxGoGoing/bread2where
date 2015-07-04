//
//  StarView.h
//  CustomCellDemo
//
//  Created by leisure on 14-4-9.
//  Copyright (c) 2014年 leisure. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StarView : UIView
{
    //背景图
    UIImageView *bgView;
    //前景图
    UIImageView *foreView;
}
//设置星级
-(void)setRating:(CGFloat)rating;
@end







