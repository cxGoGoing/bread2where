//
//  NSDate+Extension.m
//  Kitchen
//
//  Created by 肖喆 on 15/1/10.
//  Copyright (c) 2015年 肖喆. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)



+(NSString *)year
{
    NSDate * now = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    return [formatter stringFromDate:now];
}
+(NSString *)month
{
    NSDate * now = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM"];
    return [formatter stringFromDate:now];
}
+(NSString *)day
{
    NSDate * now = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd"];
    return [formatter stringFromDate:now];
}

+(NSString *)yearWithFormatterString:(NSString *)formatterString
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * date = [formatter dateFromString:formatterString];
    
    [formatter setDateFormat:@"yyyy"];
    
    NSString * year = [formatter stringFromDate:date];
    return year;
}

+(NSString *)monthWithFormatterString:(NSString *)formatterString
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * date = [formatter dateFromString:formatterString];
    
    [formatter setDateFormat:@"MM"];
    
    return [formatter stringFromDate:date];
}
+(NSString *)dayWithFormatterString:(NSString *)formatterString
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * date = [formatter dateFromString:formatterString];
    [formatter setDateFormat:@"dd"];
    
    return [formatter stringFromDate:date];
}

@end
