//
//  REIMoreCityController.h
//  Bread2Where
//
//  Created by FEI on 15/6/13.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface REIMoreCityController : UIViewController
-(void) setupRequest;
- (void) setupCollectionView;
@property(nonatomic,copy) NSString * urlStr;
@end
