//
//  REINearbyItem.h
//  Bread2Where
//
//  Created by FEI on 15/6/11.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIBaseModel.h"

@interface REINearbyItem : REIBaseModel

@property(nonatomic,assign)CGFloat rating;
@property(nonatomic,assign)NSInteger  visited_count;
@property(nonatomic,assign)NSInteger type;
//@property(nonatomic,strong)NSDictionary * city;
//@property(nonatomic,copy)NSString * fee;
//@property(nonatomic,copy)NSString * time_consuming;
//@property(nonatomic,strong)NSDictionary * location;
//@property(nonatomic,copy)NSString * opening_time;
//@property(nonatomic,assign)NSNumber * type;
//
//@property(nonatomic,assign)BOOL * has_route_maps;
//@property(nonatomic,copy)NSString * website;
@property(nonatomic,assign)NSInteger tips_count;
//
//@property(nonatomic,copy)NSString * date_added;
//@property(nonatomic,assign)BOOL * has_experience;
//
@property(nonatomic,assign)double  distance;
@property(nonatomic,copy)NSString * name;
//@property(nonatomic,copy)NSString * cover_route_map_cover;
//
@property(nonatomic,assign)NSInteger  wish_to_go_count;
//@property(nonatomic,copy)NSString * comments_count;
//
//@property(nonatomic,copy)NSString * tel;
//
//@property(nonatomic,copy)NSString * currency;
//
@property(nonatomic,copy)NSString * cover_s;
//
//@property(nonatomic,copy)NSString * timezone;
//
@property(nonatomic,strong)id idDes;
//@property(nonatomic,copy)NSString * slug_url;
//@property(nonatomic,assign)NSNumber * category;
//
//
//
@property(nonatomic,copy)NSString * recommended_reason;
//
//@property(nonatomic,assign)BOOL * verified;
//
//@property(nonatomic,copy)NSString * time_consuming_min;
//
//@property(nonatomic,copy)NSString * time_consuming_max;
//@property(nonatomic,copy)NSString * extra1;
//@property(nonatomic,assign)BOOL * recommended;
//
//
//@property(nonatomic, strong)NSArray * tips;
//@property(nonatomic, copy)NSString * rating_users;
//
//
//@property(nonatomic, copy)NSString * province;
//@property(nonatomic, copy)NSString * description;
//@property(nonatomic, copy)NSString * arrival_type;
//@property(nonatomic, copy)NSString * address;
//
//
//@property(nonatomic, copy)NSString * name_en;
//@property(nonatomic, copy)NSString * icon;
//@property(nonatomic, copy)NSString * url;
//@property(nonatomic, strong)NSDictionary * country;

@property(nonatomic, copy)NSString * trip_name;
@property(nonatomic, copy)NSString * cover;



@end
