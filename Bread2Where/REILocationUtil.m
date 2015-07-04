//
//  REILocationUtil.m
//  Bread2Where
//
//  Created by FEI on 15/6/13.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REILocationUtil.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@interface REILocationUtil()<CLLocationManagerDelegate>

@property(nonatomic, strong) CLLocationManager *locationManager;//定义Manager


@end

@implementation REILocationUtil

+(instancetype) sharedLocationUtil{
    static REILocationUtil *sharedLocation = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedLocation = [[self alloc] init];
    });
    return sharedLocation;
}

-(instancetype)init
{
    if (self = [super init]) {
        self.locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 10;
        [_locationManager requestAlwaysAuthorization];//添加这句
        [_locationManager startUpdatingLocation];
    }
    
    return self;
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    
    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
    CLLocation *currentLocation = [locations lastObject];
    
    CLLocationCoordinate2D coor = currentLocation.coordinate;
    self.latitude =  coor.latitude;
    self.longitude = coor.longitude;
    [self.locationManager stopUpdatingLocation];

}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"%@", @"ok");
}

// 错误信息
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"error");
}

@end
