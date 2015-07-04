//
//  QFDevice.m
//  LimitFree
//
//  Created by yang on 16/12/13.
//  Copyright (c) 2013 北京千锋互联科技有限公司. All rights reserved.
//

#import "QFDevice.h"
#import <UIKit/UIKit.h>
@implementation QFDevice
+ (float) getOSVersion {
    // 6.1.1
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}
+ (float) getScreenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}
+ (float) getScreenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}
+ (NSString *) getIPhoneName {
    return nil;
}

@end
