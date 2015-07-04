//
//  REIThemeArticleModel.h
//  Bread2Where
//
//  Created by qianfeng on 15-6-15.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REINoteModel.h"
#import "REIAttractionModel.h"
@interface REIThemeArticleModel : REIBaseModel
@property(nonatomic, copy)NSString * title;
@property(nonatomic, copy)NSString * image_url;
@property(nonatomic, assign)NSInteger image_width;
@property(nonatomic, assign)NSInteger image_height;
@property(nonatomic, strong)NSDictionary * description_user_id;
@property(nonatomic, copy)NSString * desc;

@property(nonatomic, strong)REINoteModel * noteModel;

@property(nonatomic, strong)REIAttractionModel * attractionModel;


@end
