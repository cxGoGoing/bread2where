//
//  REIChinaCityController.m
//  Bread2Where
//
//  Created by FEI on 15/6/13.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIChinaCityController.h"

@interface REIChinaCityController ()

@end

@implementation REIChinaCityController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common-content-bg"]];
    [self setupNavBar];
    self.urlStr = CHINA_URL;
    [self setupRequest];
    [self setupCollectionView];
    [super viewDidLoad];
}

- (void) setupNavBar {
    self.navigationItem.title = @"国内城市";
}

@end
