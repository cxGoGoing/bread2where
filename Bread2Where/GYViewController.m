//
//  GYViewController.m
//  我的项目
//
//  Created by qianfeng on 15-1-28.
//  Copyright (c) 2015年 xiehengbo. All rights reserved.
//

#import "GYViewController.h"
#import "ZCControl.h"
@interface GYViewController ()

@end

@implementation GYViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
	[self createView];

}

-(void)leftButtonCick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)createView{
    self.title=@"版本声明";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    
    UILabel*label1=[ZCControl createLabelWithFrame:CGRectMake(100, 160, 150,30) font:20 text:@"IOS客户端1.0.0版本\n"];
    label1.centerY = MAIN_SCREEN_HEIGHT * 0.35;
    label1.textColor = USEFUL_COLOR1;
    label1.textAlignment = NSTextAlignmentCenter;
    label1.centerX = MAIN_SCREEN_WIDTH * 0.5;
    [self.view addSubview:label1];
    
    UIImageView *imageView=[ZCControl createImageViewFrame:CGRectMake(100,55,80, 80) imageName:@"attraction_count_icon"];
    imageView.centerY = label1.centerY - 75;
    [imageView makeCorner:8];
    imageView.centerX = MAIN_SCREEN_WIDTH * 0.5;
    [self.view addSubview:imageView];
    
    UILabel*label2=[ZCControl createLabelWithFrame:CGRectMake(100, 220, 120,30) font:15 text:@"技术支持:"];
    label2.centerY = label1.centerY + 50;
    label2.textColor = USEFUL_COLOR1;
    label2.textAlignment = NSTextAlignmentCenter;
    label2.centerX = MAIN_SCREEN_WIDTH * 0.5;
    label2.numberOfLines=0;
    [self.view addSubview:label2];
    
    
    UILabel*label3=[ZCControl createLabelWithFrame:CGRectMake(100, 240, 120,30) font:15 text:@"QQ:1497332442"];
    label3.centerY = label2.centerY + 30;
    label3.textColor = USEFUL_COLOR1;
    label3.textAlignment = NSTextAlignmentCenter;
    label3.centerX = MAIN_SCREEN_WIDTH * 0.5;
    [self.view addSubview:label3];
}












- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
