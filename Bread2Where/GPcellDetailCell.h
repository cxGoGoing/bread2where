//
//  GPcellDetailCell.h
//  面包旅行
//
//  Created by qianfeng on 15-6-13.
//  Copyright (c) 2015年 李中飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GPcellDetailFrameModel;
@interface GPcellDetailCell : UITableViewCell
@property(nonatomic,weak)UIImageView * photoImageView;
@property(nonatomic,weak)UILabel * textLab;
@property(nonatomic,weak)UILabel * local_timeLab;
@property(nonatomic,weak)UILabel * dateLab;
@property(nonatomic,weak)UILabel * dayLab;
@property(nonatomic,weak)UIImageView * clockImageView;
+(id)cellDetailCellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong)GPcellDetailFrameModel * cellDetailF;

@end
