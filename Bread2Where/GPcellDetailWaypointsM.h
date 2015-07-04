//
//  GPcellDetailWaypointsM.h
//  面包旅行
//
//  Created by qianfeng on 15-6-13.
//  Copyright (c) 2015年 李中飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPcellDetailWaypointsM : NSObject
/**
 *  图片
 */
@property(nonatomic,copy)NSString * photo;
/**
 *  text正文
 */
@property(nonatomic,copy)NSString *text;
/**
 *  时间
 */
@property(nonatomic,copy)NSString *local_time;
/**
 *  图片的高度（真实高度*缩小比例）（缩小比例=SCREEN_WIDTH/真实宽度）
 */
@property(nonatomic,assign)NSInteger photo_H;

+(id)cellDetailWaypointsMWithDict:(NSDictionary *)dict;
-(id)initWithDict:(NSDictionary *)dict;
/**
 *  增加定义一个变量保存是第几天
 */
@property(nonatomic,assign)NSInteger dayCount;

@end
