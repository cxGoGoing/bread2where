//
//  REIDesDetailJPView.h
//  Bread2Where
//
//  Created by qianfeng on 15-6-16.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import <UIKit/UIKit.h>
@class REIDesDetailJPView;
enum REIThemeViewRefresh
{
    REIThemeViewRefreshHeaderView,
    REIThemeViewRefreshFooterView
};

typedef enum REIThemeViewRefresh REIThemeViewRefresh;
@protocol REIDesDetailJPViewDelegate <NSObject>
- (void)themeViewDidSelect:(REIDesDetailJPView *)themeView andObj:(id)obj;
- (void)themeviewRefresh:(REIThemeViewRefresh)status andPage:(int)page;
@end

@interface REIDesDetailJPView : UIView
@property(nonatomic, strong)NSMutableArray * sectionArray;
@property(nonatomic, weak)id<REIDesDetailJPViewDelegate> delegate;
+ (instancetype)desDetailJPView;
@end
