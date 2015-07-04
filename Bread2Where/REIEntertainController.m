
//
//  REIEntertainController.m
//  Bread2Where
//
//  Created by FEI on 15/6/11.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIEntertainController.h"

@interface REIEntertainController ()

@end

@implementation REIEntertainController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor colorWithRed:250/255.0 green:246/255.0 blue:232/255.0 alpha:1];
    

    self.urlStr = SCENE_URL;
    [self setupMainView];
    [self setupRefresh];
    [self setupRequest];
    [super viewDidLoad];

}

@end
