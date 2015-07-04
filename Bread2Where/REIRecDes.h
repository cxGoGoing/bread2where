//
//  REIRecDes.h
//  Bread2Where
//
//  Created by FEI on 15/6/10.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REIBaseModel.h"
@interface REIRecDes : REIBaseModel
/*
 "website": "http://www.ush.cn/",
 "rating": 4.5,
 "tel": "+1 8008648377",
 "description": "",
 "wish_to_go_count": 230,
 "visited_count": 1060,
 "currency": "USD",
 "rating_users": 15,
 "url": "/scenic/5/671007/",
 "address": "100 Universal City Plaza, Los Angeles, CA 91608 (Central L.A) ",
 "cover_s": "http://photos.breadtrip.com/photo_2012_08_16_b9ee06ccc4431007f4ac52dbf41f3ba7.jpg?imageView/1/w/280/h/280/q/75",
 "timezone": "America/Los_Angeles",
 "name_en": "Universal Studios Hollywood",
 "id": 2388365275,
 "icon": "http://media.breadtrip.com/images/icons/poi_category_11.png",
 "category": 11,
 "recommended_reason": "洛杉矶的必游之地，身历其境的奇幻电影之旅。",
 "fee": "100.00USD",
 "verified": true,
 "name": "好莱坞环球影城",
 "date_added": "2013-01-08 17:14:03",
 "cover_route_map_cover": "http://photos.breadtrip.com/photo_2012_08_16_b9ee06ccc4431007f4ac52dbf41f3ba7.jpg?imageView/1/w/380/h/240/q/75",
 "time_consuming_max": 480,
 "time_consuming": null,
 "cover": "http://photos.breadtrip.com/photo_2012_08_16_b9ee06ccc4431007f4ac52dbf41f3ba7.jpg?imageView/2/w/960/q/85",
 "has_experience": false,
 "extra1": "1906",
 "recommended": true,
 "comments_count": 0,
 "location": {},
 "opening_time": "一般是每天9:00-18:00但会每天上下波动一小时左右。",
 "slug_url": "/scenic/5/671007/",
 "type": 5,
 "has_route_maps": false,
 "time_consuming_min": 360
 */

@property(nonatomic,copy) NSString * name;
@property(nonatomic,copy) NSString * icon;
@property(nonatomic,copy) NSString * cover;

#warning 涂海生
@property(nonatomic, assign) NSInteger type;
#warning 涂海生
@property(nonatomic, strong) id idDes;
@property(nonatomic, assign)NSInteger visited_count;//去过
@property(nonatomic, assign)NSInteger wish_to_go_count;//喜欢
@end
