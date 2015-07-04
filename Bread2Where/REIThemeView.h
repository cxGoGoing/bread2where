//
//  REIThemeView.h
//  Bread2Where
//
//  Created by qianfeng on 15-6-14.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import <UIKit/UIKit.h>
@class REIThemeView;

enum REIThemeViewRefresh
{
    REIThemeViewRefreshHeaderView,
    REIThemeViewRefreshFooterView
};

typedef enum REIThemeViewRefresh REIThemeViewRefresh;

@protocol REIThemeViewDelegate <NSObject>
- (void)themeViewDidSelect:(REIThemeView *)themeView andObj:(id)obj;
- (void)themeviewRefresh:(REIThemeViewRefresh)status andPage:(int)page;
@end
@interface REIThemeView : UIView
@property(nonatomic, strong)NSMutableArray * mutableArray;

@property(nonatomic, weak)id<REIThemeViewDelegate> delegate;
+ (instancetype)themeViewCreate;
@end
