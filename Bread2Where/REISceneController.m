//
//  REISceneController.m
//  Bread2Where
//
//  Created by FEI on 15/6/11.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REISceneController.h"

@interface REISceneController ()

@end

@implementation REISceneController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:250/255.0 green:246/255.0 blue:232/255.0 alpha:1];

    self.urlStr = SCENE_URL;
    
    [self setupRequest];
    [self setupMainView];
    [self setupRefresh];
    
    
}



@end
