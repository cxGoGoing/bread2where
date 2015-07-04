//
//  NSDate+Extension.h
//  Kitchen
//
//  Created by 肖喆 on 15/1/10.
//  Copyright (c) 2015年 肖喆. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

+(NSString *)year;
+(NSString *)month;
+(NSString *)day;

+(NSString *)yearWithFormatterString:(NSString *)formatterString;
+(NSString *)monthWithFormatterString:(NSString *)formatterString;
+(NSString *)dayWithFormatterString:(NSString *)formatterString;

@end
