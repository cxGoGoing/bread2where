//
//  GPimageViewTouchController.m
//  面包旅行
//
//  Created by qianfeng on 15-6-10.
//  Copyright (c) 2015年 李中飞. All rights reserved.
//

#import "GPimageViewTouchController.h"
#import "SVProgressHUD.h"
@interface GPimageViewTouchController ()<UIWebViewDelegate>

@end

@implementation GPimageViewTouchController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.navigationItem.title = self.navTitle;
    [self createWebView];
}

-(void)createWebView{
    UIWebView * web = [[UIWebView alloc]initWithFrame:CGRectMake(0,0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT - 16)];
    _web = web;
    _web.delegate = self;
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


-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [SVProgressHUD show];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}

-(void)viewWillAppear:(BOOL)animated
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
    [super viewWillDisappear:YES];
    REIBaseFooter * footer = [REIBaseFooter baseFooter];
    footer.hidden = NO;
    [SVProgressHUD dismiss];
}

-(void)dealloc
{
    
}

@end
