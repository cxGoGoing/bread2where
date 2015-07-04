//
//  REIThemeModel.h
//  Bread2Where
//
//  Created by qianfeng on 15-6-14.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface REIThemeModel : NSObject
@property(nonatomic, assign)NSInteger idDes;
@property(nonatomic, copy)NSString * name;
@property(nonatomic, copy)NSString * image_url;
@property(nonatomic, copy)NSString * title;
//@property(nonatomic, assign)NSInteger destination_id;
@property(nonatomic, assign)NSInteger updated_at;
+ (instancetype)themeModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
