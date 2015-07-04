//
//  REIRecAdsWebController.m
//  Bread2Where
//
//  Created by FEI on 15/6/20.
//  Copyright (c) 2015年 FEIS. All rights reserved.
//

#import "REIRecAdsWebController.h"

@interface REIRecAdsWebController ()

@end

@implementation REIRecAdsWebController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
    REIBaseFooter * footer = [REIBaseFooter baseFooter];
    footer.hidden = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self createWebView];
}

-(void)createWebView{
    UIWebView * web = [[UIWebView alloc]initWithFrame:CGRectMake(0,-65, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT + 100)];
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

/**
 *  这个界面的将要销毁时候显示tabBar
 *
 *  @param animated
 */
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    REIBaseFooter * footer = [REIBaseFooter baseFooter];
    footer.hidden = NO;
    [SVProgressHUD dismiss];
}
@end
