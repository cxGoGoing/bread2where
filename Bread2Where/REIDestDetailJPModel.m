//
//  REIDestDetailJPModel.m
//  Bread2Where
//
//  Created by qianfeng on 15-6-16.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIDestDetailJPModel.h"

@implementation REIDestDetailJPModel
+ (instancetype)DestDetailJPModelWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict;
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([@"id" isEqualToString:key]) {
        self.idDes = value;
    }
}


- (void)setNilValueForKey:(NSString *)key
{
    if ([@"date_complete" isEqualToString:key]) {
        self.date_complete = 0;
    }
}
@end
