//
//  REINearbyItem.m
//  Bread2Where
//
//  Created by FEI on 15/6/11.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REINearbyItem.h"

@implementation REINearbyItem

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([@"id" isEqualToString:key]) {
        
        
        self.idDes = value ;
    }
}
@end
