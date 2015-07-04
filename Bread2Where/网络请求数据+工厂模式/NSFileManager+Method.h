//
//  NSFileManager+Method.h
//  HttpRequestDemo
//
//  Created by 张诚 on 15/1/5.
//  Copyright (c) 2015年 zhangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (Method)
//判断时间
-(BOOL)timeOutWithPath:(NSString*)path timeOut:(NSTimeInterval)time;

//清空缓存
-(void)clearCache;


@end
