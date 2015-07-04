//
//  Helper.m
//  FavoriteFree
//
//  Created by leisure on 14-4-22.
//  Copyright (c) 2014年 leisure. All rights reserved.
//

#import "Helper.h"

@implementation Helper

//如果是缓存，name就是文件名,否则就是全路径
+(UIImage*)imageNamed:(NSString *)name cache:(BOOL)isCache
{
    if (isCache) {
        return [UIImage imageNamed:name];
    }
    else{
        return [UIImage imageWithContentsOfFile:name];
    }
}
+(NSInteger)screenHeight
{
    return [[UIScreen mainScreen] bounds].size.height;
}
+(NSInteger)screenWidth
{
    return [[UIScreen mainScreen] bounds].size.width;
}

//获得到指定时间的时间差字符串,传入目标时间字符串和格式
+(NSString*)stringNowToDate:(NSString*)toDate formater:(NSString*)formatStr
{
    NSDateFormatter *formater=[[NSDateFormatter alloc] init];
    if (formatStr) {
        [formater setDateFormat:formatStr];
    }
    else{
        [formater setDateFormat:[NSString stringWithFormat:@"yyyy-MM-dd HH:mm:ss"]];
    }
    NSDate *date=[formater dateFromString:toDate];
    
    return [self stringNowToDate:date];
    
}
//获得到指定时间的时间差字符串,格式在此方法内返回前自己根据需要格式化
+(NSString*)stringNowToDate:(NSDate*)toDate
{
    //创建日期 NSCalendar对象
    NSCalendar *cal = [NSCalendar currentCalendar];
    //初始化目标时间,可以随意设置时间
//    NSDateComponents *dc = [[NSDateComponents alloc] init];
//    [dc setYear:2014];
//    [dc setMonth:4];
//    [dc setDay:23];
//    [dc setHour:9];
//    [dc setMinute:0];
//    [dc setSecond:0];
    //把目标时间装载入date
    //NSDate *todate //= [cal dc];
    //得到当前时间
    NSDate *today = [NSDate date];
    //用来得到具体的时差,位运算
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ;
    
    if (toDate && today) {
        NSDateComponents *d = [cal components:unitFlags fromDate:today toDate:toDate options:0 ];
        
        //NSString *dateStr=[NSString stringWithFormat:@"%d年%d月%d日%d时%d分%d秒",[d year],[d month], [d day], [d hour], [d minute], [d second]];
        NSString *dateStr=[NSString stringWithFormat:@"%.2d:%.2d:%.2d",[d hour], [d minute], [d second]];

        return dateStr;
    }
    
    return @"";
    
}
@end






