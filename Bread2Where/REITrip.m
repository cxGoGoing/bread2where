//
//  REITrip.m
//  Bread2Where
//
//  Created by FEI on 15/6/10.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REITrip.h"
#import "REIUser.h"
@implementation REITrip

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([@"description" isEqualToString:key]) {
        _desc = value;
    }
    if ([@"id" isEqualToString:key]) {
        _ID = [value intValue];
    }
}

+(instancetype)modelWithDict:(NSDictionary *) dict {
    return [[self alloc]initWithDict:dict];
}

-(instancetype)initWithDict:(NSDictionary *) dict {
    if(self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    NSDictionary * userDict = dict[@"user"];
    REIUser * user = [REIUser modelWithDict:userDict];
    [self setUser:user];
    return self;
}
@end
