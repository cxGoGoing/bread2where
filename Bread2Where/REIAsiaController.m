//
//  REIAsiaController.m
//  Bread2Where
//
//  Created by FEI on 15/6/13.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIAsiaController.h"

@interface REIAsiaController ()

@end

@implementation REIAsiaController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common-content-bg"]];
    [self setupNavBar];
    self.urlStr = ASIA_URL;
    [self setupRequest];
    [self setupCollectionView];
    [super viewDidLoad];
}

- (void) setupNavBar {
    self.navigationItem.title = @"亚洲国家";
}

@end
