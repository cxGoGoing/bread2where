//
//  REINearbyRootController.h
//  Bread2Where
//
//  Created by FEI on 15/6/11.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface REINearbyRootController : UIViewController

@property(nonatomic,copy) NSString * urlStr;

- (void)setupRequest;
- (void)setupMainView;
-(void) setupRefresh;
@end
