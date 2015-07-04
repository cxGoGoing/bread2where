//
//  REINearbyController.m
//  Bread2Where
//
//  Created by FEI on 15/6/11.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REINearbyController.h"
#import "REISceneController.h"
#import "REIRestaurantController.h"
#import "REIShopController.h"
#import "REIHotelController.h"
#import "SCNavTabBarController.h"
#import "REIAllController.h"
#import "REIEntertainController.h"
#import "SVProgressHUD.h"

@interface REINearbyController ()

@end

@implementation REINearbyController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self setupMainView];
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


- (void) setupMainView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    
    
    REIAllController * allController = [[REIAllController alloc]init];
    allController.title = @"全部";
    
    REISceneController * sceneController = [[REISceneController alloc]init];
    sceneController.title = @"景点";
    
    REIRestaurantController * restaurantController = [[REIRestaurantController alloc]init];
    restaurantController.title = @"餐厅";
    
    REIHotelController * hotelController = [[REIHotelController alloc]init];
    hotelController.title = @"住宿";
    
    REIEntertainController * entertainController = [[REIEntertainController alloc]init];
    entertainController.title = @"休闲娱乐";
    
    REIShopController * shopController = [[REIShopController alloc]init];
    shopController.title = @"购物";
    
    SCNavTabBarController *navTabBarController = [[SCNavTabBarController alloc] initWithShowArrowButton:NO];
    navTabBarController.subViewControllers = @[allController,sceneController,hotelController, restaurantController,entertainController, shopController];
    [navTabBarController addParentController:self];
}

-(void)viewWillAppear:(BOOL)ansimated
{
    [super viewWillAppear:YES];
    REIBaseFooter * footer = [REIBaseFooter baseFooter];
    footer.hidden = YES;
}
/**
 *  这个界面的将要销毁时候显示tabBar
 *
 *  @param animated
 */
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES ];
    REIBaseFooter * footer = [REIBaseFooter baseFooter];
    footer.hidden = NO;
    [SVProgressHUD dismiss];
}
@end
