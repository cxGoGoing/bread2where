//
//  REIRecCell.h
//  Bread2Where
//
//  Created by FEI on 15/6/10.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import <UIKit/UIKit.h>
@class REITrip;
@interface REIRecCell : UITableViewCell
+(instancetype)recCellWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath andObj:(REITrip *)trip;
@end
