//
//  REILocationUtil.h
//  Bread2Where
//
//  Created by FEI on 15/6/13.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface REILocationUtil : NSObject
@property(nonatomic,assign) double latitude;
@property(nonatomic,assign) double longitude;
+(instancetype) sharedLocationUtil;
@end
