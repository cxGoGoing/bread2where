//
//  REITrip.h
//  Bread2Where
//
//  Created by FEI on 15/6/10.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REIBaseModel.h"
@class REIUser;
@interface REITrip : REIBaseModel
/*
 "mileage": 12180.8395514088,
 "description": "",
 "recommended": false,
 "waypoints": 191,
 "wifi_sync": true,
 "last_day": 1433462400,
 "last_modified": 1433903504.79565,
 "user": {},
 "cover_image_default": "http://photos.breadtrip.com/photo_2015_06_04_5457dc287e29d8cbc778d619db7dcadc.jpg?imageView/2/w/960/q/85",
 "date_complete": 1433448127,
 "device": 1,
 "date_added": 1433170140,
 "summary": "",
 "id": 2386619691,
 "popular_place_str": "斐济, Savusavu",
 "view_count": 10710,
 "name": "脱掉Bra才是享受“斐济时间”的正确方法～",
 "privacy": 0,
 "first_day": 1433116800,
 "cover_image_1600": "http://photos.breadtrip.com/photo_2015_06_04_5457dc287e29d8cbc778d619db7dcadc.jpg?imageView/2/w/1384/h/1384/q/85",
 "comment_count": 4,
 "cover_image_w640": "http://photos.breadtrip.com/photo_2015_06_05_f21a3fc6ae899c2b2b708a8df91dc860.jpg?imageView/1/w/640/h/480/q/85",
 "is_hot_trip": true,
 "day_count": 5,
 "recommendations": 48,
 "cover_image": "http://photos.breadtrip.com/photo_2015_06_05_f21a3fc6ae899c2b2b708a8df91dc860.jpg?imageView/1/w/640/h/480/q/85",
 "start_point": {},
 "is_featured_trip": false
 */

@property(nonatomic,assign) NSInteger mileage;
@property(nonatomic,copy) NSString * desc;
@property(nonatomic,assign) BOOL recommended;
@property(nonatomic,assign) NSInteger waypoints;
@property(nonatomic,assign) BOOL wifi_sync;
@property(nonatomic,assign) NSInteger last_day;
@property(nonatomic,assign) NSInteger last_modified;
//@property(nonatomic,assign) NSUInteger date_complete;
@property(nonatomic,assign) NSInteger device;
@property(nonatomic,assign) NSUInteger ID;
@property(nonatomic,assign) NSInteger view_count;
@property(nonatomic,assign) NSInteger privacy;
@property(nonatomic,assign) NSInteger first_day;
@property(nonatomic,assign) NSInteger comment_count;
@property(nonatomic,assign) NSInteger day_count;
@property(nonatomic,assign) NSInteger recommendations;
@property(nonatomic,assign) NSInteger date_added;
@property(nonatomic,assign) BOOL is_hot_trip;
@property(nonatomic,assign) BOOL is_featured_trip;
@property(nonatomic,copy) NSString * cover_image_default;
@property(nonatomic,copy) NSString * summary;
@property(nonatomic,copy) NSString * popular_place_str;
@property(nonatomic,copy) NSString * name;
@property(nonatomic,copy) NSString * cover_image_1600;
@property(nonatomic,copy) NSString * cover_image_w640;
@property(nonatomic,copy) NSString * cover_image;
@property(nonatomic,strong) REIUser * user;
@end
