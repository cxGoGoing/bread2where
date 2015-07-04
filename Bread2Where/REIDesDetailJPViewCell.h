//
//  REIDesDetailJPViewCell.h
//  Bread2Where
//
//  Created by qianfeng on 15-6-16.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import <UIKit/UIKit.h>
@class REIDestDetailJPModel;
@interface REIDesDetailJPViewCell : UITableViewCell
@property(nonatomic, strong)REIDestDetailJPModel * model;
+ (instancetype)desDetailJPViewCellWithTableView:(UITableView *)tableView andObj:(id)obj;
@end
