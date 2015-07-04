//
//  REIUser.m
//  Bread2Where
//
//  Created by FEI on 15/6/10.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIUser.h"

@implementation REIUser

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([@"id" isEqualToString:key]) {
        _ID = value;
    }
}

@end
