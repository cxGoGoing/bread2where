//
//  REIThemeDetailModel.h
//  Bread2Where
//
//  Created by qianfeng on 15-6-15.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REIThemeArticleModel.h"
#import "REIBaseModel.h"
@interface REIThemeDetailModel : REIBaseModel
@property(nonatomic, assign)id idDes;
@property(nonatomic, copy)NSString * name;
@property(nonatomic, copy)NSString * image_url;
@property(nonatomic, copy)NSString * title;
@property(nonatomic, assign)NSInteger comments_count;
@property(nonatomic, strong)id destination_id;
@property(nonatomic, assign)BOOL commentable;
@property(nonatomic, assign)BOOL current_user_favorite;
@property(nonatomic, assign)NSInteger updated_at;
@property(nonatomic, strong)REIThemeArticleModel * article;
@end
