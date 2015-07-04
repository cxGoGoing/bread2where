//
//  HttpRequestBlock.m
//  HttpRequestDemo
//
//  Created by 张诚 on 15/1/5.
//  Copyright (c) 2015年 zhangcheng. All rights reserved.
//

#import "HttpRequestBlock.h"
#import "MyMD5.h"
#import "NSFileManager+Method.h"
@implementation HttpRequestBlock
-(id)initWithUrlPath:(NSString *)urlStr Block:(void (^)(BOOL, HttpRequestBlock *))a
{
    if (self=[super init]) {
        //保存地址  保存block指针
        self.path=urlStr;
        self.httpRequest=a;
        
        //判断这个文件是否存在并且是否在我规定的时间范围内，不超时
        manager=[NSFileManager defaultManager];
        
        if ([manager fileExistsAtPath:[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),[MyMD5 md5:self.path]]]&&[manager timeOutWithPath:[MyMD5 md5:self.path] timeOut:60*60]) {
            //使用缓存
            NSString*filePath=[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),[MyMD5 md5:self.path]];
            self.data=[NSMutableData dataWithContentsOfFile:filePath];
            
            [self jsonValue];
            
        }else{
            
            [self createRequest];
        
        }
        
        
        
    }
    return self;
}
-(void)createRequest{
    _connection=[NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.path]] delegate:self];

}
#pragma mark NSURLConnectionDelegate
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
//与服务器连接成功，数据初始化
    self.data=[NSMutableData dataWithCapacity:0];
    
    //如果self.data已经初始化过了，但是原来有旧数据，如何清空
    //[self.data setLength:0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
//追加数据
    [self.data appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
//完成请求，数据保存  进行数据解析
    
    NSString*writePath=[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),[MyMD5 md5:self.path]];
    
    
    [self.data writeToFile:writePath atomically:YES];
    
    [self jsonValue];
    
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
//请求失败
    if (self.httpRequest) {
        self.httpRequest(NO,self);
    }
}
#pragma mark 进行数据解析
-(void)jsonValue{

    id result=[NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableContainers error:nil];
    
    //判断结果
    if ([result isKindOfClass:[NSArray class]]) {
        self.dataArray=result;
    }else{
        if ([result isKindOfClass:[NSDictionary class]]) {
            self.dataDic=result;
        }else{
        //不是数组不是字典，那么就是UIImage
            self.dataImage=[UIImage imageWithData:self.data];
        }
    
    }
    
    //解析完成后调用block
    if (self.httpRequest) {
        self.httpRequest(YES,self);
    }

}

@end




