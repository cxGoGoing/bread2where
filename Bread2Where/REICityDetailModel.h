//
//  REICityDetailModel.h
//  Bread2Where
//
//  Created by qianfeng on 15-6-13.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface REICityDetailModel : NSObject
@property(nonatomic, copy)NSString * photo;
@property(nonatomic, copy)NSString * desc;
@property(nonatomic, copy)NSString * arrival_type;
@property(nonatomic, copy)NSString * tel;
@property(nonatomic, copy)NSString * name;
+ (instancetype)cityDetailModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
