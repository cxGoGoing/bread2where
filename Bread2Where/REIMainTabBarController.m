//
//  REIMainTabBarController.m
//  Rei
//
//  Created by FEI on 15/5/9.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIMainTabBarController.h"
#import "REIBaseTabBar.h"

@interface REIMainTabBarController ()<REIBaseTabBarDelegate>
@property (nonatomic, weak) UIButton *selectedBtn;
@end

@implementation REIMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
}

/**永远别忘记设置代理*/
- (void)baseTabBar:(REIBaseTabBar *)tabBar selectedFrom:(NSInteger)from to:(NSInteger)to{
    self.selectedIndex = to;
}

-(void)loadBaseTabBar:(REIBaseTabBar *)baseTabBar
{
    self.tabBar.hidden = YES;
    
    //删除现有的tabBar
    CGRect rect = self.tabBar.bounds; 
    baseTabBar.delegate = self;
    baseTabBar.frame = rect;
}

@end
