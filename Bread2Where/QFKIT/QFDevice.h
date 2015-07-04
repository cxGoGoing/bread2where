//
//  QFDevice.h
//  LimitFree
//
//  Created by yang on 16/12/13.
//  Copyright (c) 2013 北京千锋互联科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QFDevice : NSObject

+ (float) getOSVersion;
+ (float) getScreenWidth;
+ (float) getScreenHeight;
+ (NSString *) getIPhoneName;

@end

#define kScreenWidth [QFDevice getScreenWidth]
#define kScreenHeight [QFDevice getScreenHeight]
#define kOSVersion [QFDevice getOSVersion]


#define SysFont(f) [UIFont systemFontOfSize:f]




#define PropertyString(p) @property (nonatomic, copy) NSString *p;
#define PropertyFloat(p) @property (nonatomic, assign) float p;
#define PropertyInt(p) @property (nonatomic, assign) NSInteger p;
#define PropertyUInt(p) @property (nonatomic, assign) NSUInteger p;




