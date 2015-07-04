//
//  REIdesDetailSpecialController.m
//  Bread2Where
//
//  Created by qianfeng on 15-6-17.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIdesDetailSpecialController.h"

@interface REIdesDetailSpecialController ()

@end

@implementation REIdesDetailSpecialController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createBackButton];
}

/**
 *  创建返回按钮
 */
-(void)createBackButton
{
    UIButton * backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(0, 0, 25, 25);
    [self.view addSubview:backBtn];
    [backBtn setImage:[UIImage imageNamed:@"icon_nav_back_button"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"nav-bar-lovingzone-back-btn"] forState:UIControlStateSelected];
    [backBtn addTarget:self action:@selector(backBtnTcouch) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:backBtn];
    UIView * barView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [barView addSubview:backBtn];
    UIBarButtonItem * item=[[UIBarButtonItem alloc]initWithCustomView:barView];
    self.navigationItem.leftBarButtonItem=item;
}
-(void)backBtnTcouch
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)dealloc
{
    
}

@end
