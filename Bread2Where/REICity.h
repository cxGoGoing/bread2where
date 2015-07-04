//
//  REICity.h
//  Bread2Where
//
//  Created by FEI on 15/6/10.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REIBaseModel.h"
@interface REICity : REIBaseModel
@property(nonatomic,copy) NSString * name;
@property(nonatomic,copy) NSString * icon;
@property(nonatomic,copy) NSString * cover;
#warning 涂海生
@property(nonatomic, assign) NSInteger type;
#warning 涂海生
@property(nonatomic, copy) NSString * idDes;
@property(nonatomic, assign)NSInteger visited_count;
@property(nonatomic, assign)NSInteger wish_to_go_count;
@end
