//
//  REIBaseModel.h
//  ForALongTimeWithU
//
//  Created by FEI on 15/5/26.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface REIBaseModel : NSObject
-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)modelWithDict:(NSDictionary *)dict;
@end
