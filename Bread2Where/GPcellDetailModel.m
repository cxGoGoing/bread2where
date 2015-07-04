//
//  GPcellDetailModel.m
//  面包旅行
//
//  Created by qianfeng on 15-6-13.
//  Copyright (c) 2015年 李中飞. All rights reserved.
//

#import "GPcellDetailModel.h"
#import "GPcellDetailWaypointsM.h"

@implementation GPcellDetailModel

//+(id)cellDetailModelWithDict:(NSDictionary *)dict
//{
//    return [[self alloc]initWithDict:dict];
//}
//-(id)initWithDict:(NSDictionary *)dict
//{
//    if (self=[super init]) {
//        
//        self.date=dict[@"date"];
//        self.day=[dict[@"day"] integerValue];
//        NSMutableArray * objs=[NSMutableArray array];
//        for(NSDictionary * sub in dict[@"waypoints"])
//        {
//            GPcellDetailWaypointsM * cellDetailW=[GPcellDetailWaypointsM cellDetailWaypointsMWithDict:sub];
//            [objs addObject:cellDetailW];
//        }
//        _waypoints=objs;
//        
//    }
//    
//    
//    
//    return self;
//}


@end
