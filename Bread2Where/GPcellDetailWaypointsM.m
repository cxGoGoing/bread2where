//
//  GPcellDetailWaypointsM.m
//  面包旅行
//
//  Created by qianfeng on 15-6-13.
//  Copyright (c) 2015年 李中飞. All rights reserved.
//

#import "GPcellDetailWaypointsM.h"


@implementation GPcellDetailWaypointsM

+(id)cellDetailWaypointsMWithDict:(NSDictionary *)dict
{
    return [[GPcellDetailWaypointsM alloc]initWithDict:dict];
}

-(id)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        
        self.photo=dict[@"photo"];
        self.text=dict[@"text"];
        self.local_time=dict[@"local_time"];
        /**
         *  处理json解析出来的图片宽和高信息，通过比例算出来在cell中得高度，并存于photo_W中
         */
#warning 注意此时后台给的数据中字典的key对应的有时是个字典，但是如果没有数据后台竟然给个null，如果这里不处理就会崩掉
        if (dict[@"photo_info"]==[NSNull null]) {
            
            self.photo_H=0;
            
        }else{
            
            NSDictionary * photo_info=dict[@"photo_info"];
            NSInteger w=[[photo_info objectForKey:@"w"] integerValue];
            NSInteger h=[[photo_info objectForKey:@"h"] integerValue];
            self.photo_H=h * (MAIN_SCREEN_WIDTH/w);
        }
        /**
         *  到这就可以直接计算每个控件的Frame值，然后定义一个变量保存，但为了美观和保持封装性，把算Frame的工作单独搞一个类出来，但是这样由于本app后台的缘故，在下载完数据处理时就要那麻烦点
         */
        
    }
    return self;
}



@end
