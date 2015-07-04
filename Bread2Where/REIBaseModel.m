//
//  REIBaseModel.m
//  ForALongTimeWithU
//
//  Created by FEI on 15/5/26.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIBaseModel.h"

@implementation REIBaseModel

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if(self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)modelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}
@end
