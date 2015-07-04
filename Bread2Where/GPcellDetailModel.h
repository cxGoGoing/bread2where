//
//  GPcellDetailModel.h
//  面包旅行
//
//  Created by qianfeng on 15-6-13.
//  Copyright (c) 2015年 李中飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPcellDetailModel : NSObject
/**
 *  日期
 */
@property(nonatomic,copy)NSString *date;
/**
 *  第几天
 */
@property(nonatomic,assign)NSInteger day;
/**
 *  数据数组
 */
@property(nonatomic,strong)NSMutableArray * waypoints;

//+(id)cellDetailModelWithDict:(NSDictionary *)dict;
//-(id)initWithDict:(NSDictionary *)dict;

@end
