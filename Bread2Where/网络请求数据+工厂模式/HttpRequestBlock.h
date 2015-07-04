//
//  HttpRequestBlock.h
//  HttpRequestDemo
//
//  Created by 张诚 on 15/1/5.
//  Copyright (c) 2015年 zhangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface HttpRequestBlock : NSObject<NSURLConnectionDataDelegate,NSURLConnectionDelegate>
{
    NSFileManager*manager;
}
//保存请求地址
@property(nonatomic,copy)NSString*path;

//请求
@property(nonatomic)NSURLConnection*connection;
@property(nonatomic)NSMutableData*data;

//解析结果
@property(nonatomic,strong)NSArray*dataArray;
@property(nonatomic,strong)NSDictionary*dataDic;
@property(nonatomic)UIImage*dataImage;


//block指针
@property(nonatomic,copy)void(^httpRequest)(BOOL,HttpRequestBlock*);

-(id)initWithUrlPath:(NSString*)urlStr Block:(void(^)(BOOL,HttpRequestBlock*))a;



@end
