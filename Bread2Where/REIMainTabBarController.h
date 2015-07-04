//
//  REIMainTabBarController.h
//  Rei
//
//  Created by FEI on 15/5/9.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import <UIKit/UIKit.h>
@class REIBaseTabBar;
@interface REIMainTabBarController : UITabBarController
-(void)loadBaseTabBar:(REIBaseTabBar *)baseTabBar;
@end
