//
//  REIBanner.h
//  Bread2Where
//
//  Created by FEI on 15/6/10.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface REIBanner : NSObject
/*
 {
 "image_url": "http://photos.breadtrip.com/covers_2015_06_06_3054323a494036456df526b987a7fd85.png",
 "html_url": "http://breadtrip.com/mobile/wonderful/2387718858/",
 "platform": "all"
 }
 */
@property(nonatomic,copy) NSString * image_url;
@property(nonatomic,copy) NSString * html_url;
@property(nonatomic,copy) NSString * platform;
@end
