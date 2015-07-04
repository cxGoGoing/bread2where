//
//  REIDestDetailJPModel.h
//  Bread2Where
//
//  Created by qianfeng on 15-6-16.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface REIDestDetailJPModel : NSObject
@property(nonatomic, copy)NSString * mileage;
@property(nonatomic, copy)NSString * desDesc;
@property(nonatomic, assign)NSInteger waypoints;
@property(nonatomic, assign)BOOL wifi_sync;

@property(nonatomic, assign)NSInteger last_modified;
@property(nonatomic, copy)NSString * cover_image_default;

@property(nonatomic, assign)NSInteger date_complete;

@property(nonatomic, assign)NSInteger  device;
@property(nonatomic, assign)NSInteger date_added;
@property(nonatomic, copy)id idDes;
@property(nonatomic, copy)NSString * name;
@property(nonatomic, copy)NSString * cover_image_1600;
@property(nonatomic, copy)NSString * cover_image_w640;
@property(nonatomic, copy)NSString * cover_image;
@property(nonatomic, assign)NSInteger day_count;
@property(nonatomic, assign)NSInteger recommendations;

+ (instancetype)DestDetailJPModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
