//
//  REIHotDes.h
//  Bread2Where
//
//  Created by FEI on 15/6/13.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REIBaseModel.h"
/*
 "visited_count": 18645,
 "rating": 0,
 "name": "泰国",
 "url": "/scenic/1/TH/",
 "wish_to_go_count": 21389,
 "name_orig": "泰国",
 "has_experience": true,
 "comments_count": 0,
 "location": {},
 "rating_users": 0,
 "slug_url": "/th/",
 "type": 1,
 "id": "TH",
 "has_route_maps": false,
 "icon": "http://media.breadtrip.com/images/icons/country.png"
 */
@interface REIHotDes : REIBaseModel
@property(nonatomic,assign) NSInteger visited_count;
@property(nonatomic,assign) NSInteger rating;
@property(nonatomic,copy) NSString * url;
@property(nonatomic,assign) NSInteger wish_to_go_count;
@property(nonatomic,assign) NSInteger comments_count;
@property(nonatomic,assign) NSInteger rating_users;
@property(nonatomic,assign) NSInteger type;
@property(nonatomic,copy) NSString * name_orig;
@property(nonatomic,copy) NSString * slug_url;
@property(nonatomic,copy) NSString * ID;
@property(nonatomic,copy) NSString * icon;
@property(nonatomic,copy) NSString * name;
@end
