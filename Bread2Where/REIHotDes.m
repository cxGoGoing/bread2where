//
//  REIHotDes.m
//  Bread2Where
//
//  Created by FEI on 15/6/13.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIHotDes.h"

@implementation REIHotDes

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if([@"id" isEqualToString:key]) {
        self.ID = value;
    }
}

@end
