//
//  REIWebViewController.m
//  ForALongTimeWithU
//
//  Created by FEI on 15/5/29.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIWebViewController.h"
#import "ZCControl.h"
@interface REIWebViewController ()

@end

@implementation REIWebViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self createWebView];
}

-(void)createWebView{
     UIWebView * web = [[UIWebView alloc]initWithFrame:CGRectMake(0,0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)];
    _web = web;
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [_web loadRequest:request];
    [self.view addSubview:_web];
    
    self.view.backgroundColor = [UIColor clearColor];
    for (id subview in _web.subviews) {
        if ([[subview class] isSubclassOfClass: [UIScrollView class]])
        {
            ((UIScrollView *)subview).bounces = NO;
        }
    }
}

@end
