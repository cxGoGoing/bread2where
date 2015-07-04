//
//  REIDesEuropeController.m
//  Bread2Where
//
//  Created by FEI on 15/6/13.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIDesEuropeController.h"
#import "REIDesCell.h"
@interface REIDesEuropeController ()
@end

@implementation REIDesEuropeController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common-content-bg"]];
    [self setupNavBar];
    self.urlStr = EUROPE_URL;
    [self setupRequest];
    [self setupCollectionView];
    [super viewDidLoad];
}

- (void) setupNavBar {
    self.navigationItem.title = @"欧洲国家";
}


@end
