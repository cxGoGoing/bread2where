//
//  REIThemeArticleModel.m
//  Bread2Where
//
//  Created by qianfeng on 15-6-15.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIThemeArticleModel.h"
#import "REINoteModel.h"
@implementation REIThemeArticleModel
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if(self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    
        NSDictionary * note = dict[@"note"];
        REINoteModel * noteModel = [REINoteModel modelWithDict:note];
        self.noteModel = noteModel;
        

        
        
        
    }
    return self;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([@"description" isEqualToString:key]) {
        self.desc = value;
    }
}
@end
