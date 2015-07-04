//
//  REINearbyCell.h
//  Bread2Where
//
//  Created by FEI on 15/6/11.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import <UIKit/UIKit.h>
@class REINearbyItem;
@interface REINearbyCell : UITableViewCell
@property(nonatomic, strong) REINearbyItem * model;
+(instancetype)nearbyCellAndTableView:(UITableView *)tableView andObj:(id)obj;
@end
