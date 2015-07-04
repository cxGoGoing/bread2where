//
//  REIBaseTabBar.h
//  Rei
//
//  Created by FEI on 15/5/8.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import <UIKit/UIKit.h>
@class REIBaseTabBar;
//实现 tabBar 按钮点击事件需实现本协议
@protocol REIBaseTabBarDelegate <NSObject>
//-(void)baseTabBarItemTouch:(REIBaseTabBar *)tabBar andIndex:(int)index;

/**
 *  工具栏按钮被选中, 记录从哪里跳转到哪里. (方便以后做相应特效)
 */
- (void) baseTabBar:(REIBaseTabBar *)tabBar selectedFrom:(NSInteger) from to:(NSInteger)to;
@end

@interface REIBaseTabBar : UIView
//设置背景图片
@property(nonatomic,weak)UIImage * background;
//加在tabBar上面的按钮的集合
@property (nonatomic,strong) NSArray * btnItems;
//实现了REIBaseTabBarDelegate的代理
@property (nonatomic,assign) id<REIBaseTabBarDelegate> delegate;

+(instancetype)baseTabBar;

@end
