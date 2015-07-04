//
//  REIUser.h
//  Bread2Where
//
//  Created by FEI on 15/6/10.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REIBaseModel.h"
/*
 "user": {
 "gender": 1,
 "email_verified": false,
 "location_name": "",
 "name": "廣州遇到泰迪熊",
 "resident_city_id": "",
 "mobile": "",
 "avatar_s": "http://photos.breadtrip.com/avatar_37_df_4d317353eb0e117cd4f25d8388498bcb7d2f5f45.jpg-avatar.s",
 "cover": "http://photos.breadtrip.com/default_user_cover_06.jpg-usercover.display",
 "custom_url": "",
 "email": "",
 "birthday": "",
 "country_num": null,
 "avatar_l": "http://photos.breadtrip.com/avatar_37_df_4d317353eb0e117cd4f25d8388498bcb7d2f5f45.jpg-avatar.l",
 "avatar_m": "http://photos.breadtrip.com/avatar_37_df_4d317353eb0e117cd4f25d8388498bcb7d2f5f45.jpg-avatar.m",
 "country_code": null,
 "id": 2386603144,
 "user_desc": ""
 },
 */
@interface REIUser : REIBaseModel
@property(nonatomic,assign) NSInteger gender;
@property(nonatomic,assign) id ID;
@property(nonatomic,assign) BOOL email_verified;
@property(nonatomic,copy) NSString * location_name;
@property(nonatomic,copy) NSString * name;
@property(nonatomic,copy) NSString * resident_city_id;
@property(nonatomic,copy) NSString * mobile;
@property(nonatomic,copy) NSString * avatar_s;
@property(nonatomic,copy) NSString * cover;
@property(nonatomic,copy) NSString * custom_url;
@property(nonatomic,copy) NSString * email;
@property(nonatomic,copy) NSString * birthday;
@property(nonatomic,copy) NSString * avatar_l;
@property(nonatomic,copy) NSString * country_num;
@property(nonatomic,copy) NSString * avatar_m;
@property(nonatomic,copy) NSString * country_code;
@property(nonatomic,copy) NSString * user_desc;
@end
