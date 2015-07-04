//
//  REINoteModel.h
//  Bread2Where
//
//  Created by qianfeng on 15-6-15.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REIBaseModel.h"
@interface REINoteModel : REIBaseModel
@property(nonatomic, assign)id  idDes;
@property(nonatomic, assign)NSInteger trip_id;
@property(nonatomic, copy)NSString * trip_name;
@property(nonatomic, copy)NSString * user_name;
@end
