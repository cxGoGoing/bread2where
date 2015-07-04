
//
//  NSFileManager+Method.m
//  HttpRequestDemo
//
//  Created by 张诚 on 15/1/5.
//  Copyright (c) 2015年 zhangcheng. All rights reserved.
//

#import "NSFileManager+Method.h"

@implementation NSFileManager (Method)
-(BOOL)timeOutWithPath:(NSString*)path timeOut:(NSTimeInterval)time{
    NSFileManager*manager=[NSFileManager defaultManager];
    //设置路径
    NSString*filePath=[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),path];
    
    NSDictionary*fileMessage=[manager attributesOfItemAtPath:filePath error:nil];
    //读取出创建的时间
    NSDate*createDate=[fileMessage objectForKey:NSFileCreationDate];
    //现在的时间
    NSDate*date=[NSDate date];
    //二个时间计算出差值
    NSTimeInterval fileTime=[date timeIntervalSinceDate:createDate];
    
    if (fileTime>time) {
        return NO;
    }else{
        return YES;
    }

}
-(void)clearCache{
    NSString*path=[NSString stringWithFormat:@"%@/Documents",NSHomeDirectory()];
    
    //获取这个文件夹下的所有的文件名
    NSFileManager*manager=[NSFileManager defaultManager];
    NSArray*array=[manager contentsOfDirectoryAtPath:path error:nil];
    
    //遍历数组依次删除 3种方式
    //第一种方式
    for (NSString*str in array) {
        NSString*newPath=[NSString stringWithFormat:@"%@/%@",path,str];
        [manager removeItemAtPath:newPath error:nil];
    }
//    //第二种方式
//    for (int i=0; i<array.count; i++) {
//        NSString*fileName=array[i];
//        NSString*newPath1=[NSString stringWithFormat:@"%@/%@",path,fileName];
//        [manager removeItemAtPath:newPath1 error:nil];
//    }
//    //以上2种在数据量相对较大的时候，会阻塞主线程
//    
//    //第三种方法 枚举遍历 使用block开辟一条线程，在线程中遍历  obj我们遍历的对象 idx第几位 stop是否停止
//    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        NSString*newPath2=[NSString stringWithFormat:@"%@/%@",path,obj];
//        [manager removeItemAtPath:newPath2 error:nil];
//    }];
//    
//    //字典的遍历  key字典的key obj字典的Value
//    NSDictionary*dic=@{@"111":@"222"};
//    [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//        
//    }];

}


@end
