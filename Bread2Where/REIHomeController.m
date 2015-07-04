//
//  REIHomeController.m
//  Rei
//
//  Created by FEI on 15/5/8.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIHomeController.h"
#import "REIBaseFooter.h"
#import "GPspecialController.h"
#import "REIDesController.h"
#import "REIRecController.h"
#import "REIMeController.h"
#import "REIThemeController.h"

@interface REIHomeController ()
@end

@implementation REIHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.viewControllers = [self loadViewControllers];
    /**底部导航条*/
    [self loadBaseTabToFooter];
}

-(NSArray *)loadViewControllers
{

    REIRecController * recController = [[REIRecController alloc]init];
    REIMainNavigationController * recNavController = [[REIMainNavigationController alloc]initWithRootViewController:recController];
    
    REIMeController * meController = [[REIMeController alloc]init];
    REIMainNavigationController * meNavController = [[REIMainNavigationController alloc]initWithRootViewController:meController];
    
    REIDesController * desController = [[REIDesController alloc]init];
    REIMainNavigationController * desNavController = [[REIMainNavigationController alloc]initWithRootViewController:desController];
    
    GPspecialController * spController = [[GPspecialController alloc]init];
    REIMainNavigationController * spNavController = [[REIMainNavigationController alloc]initWithRootViewController:spController];
    
    REIThemeController * themeController = [[REIThemeController alloc]init];
    REIMainNavigationController * themeNavController = [[REIMainNavigationController alloc]initWithRootViewController:themeController];
    
    return @[recNavController,desNavController,themeNavController,spNavController,meNavController];
}

#pragma mark 加载底部自定义导航条
-(void)loadBaseTabToFooter
{
    //测试添加自己的视图
    REIBaseFooter * baseFooter = [REIBaseFooter baseFooter];
    [super loadBaseTabBar:baseFooter];
    
    [self.view addSubview:baseFooter];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
