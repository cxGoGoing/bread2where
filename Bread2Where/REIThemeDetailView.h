//
//  REIThemeDetailView.h
//  Bread2Where
//
//  Created by qianfeng on 15-6-15.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import <UIKit/UIKit.h>
@class REIThemeDetailModel;


@interface REIThemeDetailView : UIView
@property(nonatomic, strong)NSMutableArray * mutableArray;
@property(nonatomic, strong)REIThemeDetailModel* detailModel;
@property(nonatomic, strong)NSMutableArray * titleArray;
+ (instancetype)themeDetailViewCreate;
@end
