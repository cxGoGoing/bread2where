//
//  REIMainNavigationController.m
//  Rei
//
//  Created by FEI on 15/5/8.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIMainNavigationController.h"
#import "UIView+Extension.h"
@interface REIMainNavigationController ()

@end

@implementation REIMainNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    //设置导航栏主题
    UINavigationBar * navBar = [UINavigationBar appearance];
    [navBar setBackgroundImage:[UIImage imageNamed:@"bg_navigationBar"] forBarMetrics:UIBarMetricsDefault];
    [navBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil]];
    
    //设置导航栏按钮,以及文字主题
    UIBarButtonItem * btnItem = [UIBarButtonItem appearance];
    NSDictionary * dicNormal = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:16]};
    [btnItem setTitleTextAttributes:dicNormal forState:UIControlStateNormal];
    
}

//重写UINavigationController 的 push 方法
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(self.viewControllers.count > 0){
        
        UIBarButtonItem * item = [UIBarButtonItem itemWithTarget: self action:@selector(btnLeftBtn) image:@"icon_nav_back_button"  selectImage:@"nav-bar-lovingzone-back-btn"];
        viewController.navigationItem.leftBarButtonItems = @[item];
        
        
    }
    [super pushViewController:viewController animated:YES];
}


-(void)btnLeftBtn
{
    [self popViewControllerAnimated:YES];
//    self.navigationController.navigationBarHidden = NO;
}


@end
