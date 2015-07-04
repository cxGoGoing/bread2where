//
//  REIAttractionModel.h
//  Bread2Where
//
//  Created by qianfeng on 15-6-15.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REIBaseModel.h"
@interface REIAttractionModel : REIBaseModel
@property(nonatomic, assign)id idDes;
@property(nonatomic, copy)NSString * name;
@property(nonatomic, copy)NSString * user_score;
@property(nonatomic, assign)NSInteger attraction_trips_count;
@property(nonatomic, copy)NSString * image_url;
@end
