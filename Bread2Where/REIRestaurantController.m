//
//  REIRestaurantController.m
//  Bread2Where
//
//  Created by FEI on 15/6/11.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIRestaurantController.h"

@interface REIRestaurantController ()

@end

@implementation REIRestaurantController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:250/255.0 green:246/255.0 blue:232/255.0 alpha:1];
    self.urlStr = RES_URL;
    [self setupMainView];
    [self setupRefresh];
    [self setupRequest];
}

@end
