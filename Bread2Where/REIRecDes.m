//
//  REIRecDes.m
//  Bread2Where
//
//  Created by FEI on 15/6/10.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIRecDes.h"

@implementation REIRecDes


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([@"id" isEqualToString:key]) {
        self.idDes = value;
    }
}
@end
