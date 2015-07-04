//
//  REICityDetailModel.m
//  Bread2Where
//
//  Created by qianfeng on 15-6-13.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REICityDetailModel.h"

@implementation REICityDetailModel
+ (instancetype)cityDetailModelWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self =[super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
 }

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
//    if ([@"description" isEqualToString:key]) {
//        self.desc = value;
//    }
}
@end
