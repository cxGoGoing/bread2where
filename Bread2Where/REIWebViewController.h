//
//  REIWebViewController.h
//  ForALongTimeWithU
//
//  Created by FEI on 15/5/29.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface REIWebViewController : UIViewController
@property(nonatomic,weak) UIWebView * web;
@property(nonatomic,copy) NSString *url;
@end
