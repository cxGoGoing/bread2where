//
//  REIThemeCellView.h
//  Bread2Where
//
//  Created by qianfeng on 15-6-14.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import <UIKit/UIKit.h>
@class REIThemeModel;
@interface REIThemeCellView : UITableViewCell
@property(nonatomic, strong)REIThemeModel * model;
+ (instancetype)themeCellViewWithTable:(UITableView *)tableView andObj:(id)obj;
@end
