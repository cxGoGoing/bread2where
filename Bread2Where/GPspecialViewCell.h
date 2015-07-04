//
//  GPspecialViewCell.h
//  面包旅行
//
//  Created by qianfeng on 15-6-11.
//  Copyright (c) 2015年 李中飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GPspecialProductModel;
@interface GPspecialViewCell : UITableViewCell

+(id)specialViewCell:(UITableView *)tableView;
@property(nonatomic,strong)GPspecialProductModel * specialProductM;


@end
