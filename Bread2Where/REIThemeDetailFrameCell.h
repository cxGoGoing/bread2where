//
//  REIThemeDetailFrameCell.h
//  Bread2Where
//
//  Created by qianfeng on 15-6-15.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REIBaseModel.h"
@class REIThemeArticleModel;
@interface REIThemeDetailFrameCell : NSObject

@property(nonatomic, weak)UIImageView * image_url;//图片
@property(nonatomic, weak)UILabel * descriptionLabel;//描述

//@property(nonatomic, weak)UILabel * trip_name;//旅行名字
//@property(nonatomic, weak)UILabel * user_name;//作者名字

@property(nonatomic, copy) NSString * title;
@property(nonatomic, assign, readonly)CGRect imageF;
@property(nonatomic, assign, readonly)CGRect descripF;
/**
 cell的高度
 */

@property(nonatomic, assign, readonly)CGFloat cellHeight;
@property(nonatomic, strong)REIThemeArticleModel * articleModel;
@end
