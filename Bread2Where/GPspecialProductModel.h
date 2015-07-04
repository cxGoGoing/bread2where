//
//  GPspecialProductModel.h
//  面包旅行
//
//  Created by qianfeng on 15-6-11.
//  Copyright (c) 2015年 李中飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPspecialProductModel : NSObject

/**
 *  图片的url
 */
@property(nonatomic,copy)NSString *cover;
/**
 *  详情url
 */
@property(nonatomic,copy)NSString *url;
/**
 *  显示的主题
 */
@property(nonatomic,copy)NSString *title;
/**
 *  出发地
 */
@property(nonatomic,copy)NSString *depart_place;
/**
 *  起价
 */
@property(nonatomic,assign)NSInteger min_price;
/**
 *  市场价
 */
@property(nonatomic,assign)NSInteger market_price;
/**
 *  出发日期数组
 */
@property(nonatomic,strong)NSArray * depart_dates;

@end
