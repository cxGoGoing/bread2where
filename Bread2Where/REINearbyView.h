//
//  REINearbyView.h
//  Bread2Where
//
//  Created by FEI on 15/6/11.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import <UIKit/UIKit.h>
@class REINearbyView;
@class REINearbyItem;
@protocol REINearbyViewDelegate <NSObject>

- (void)nearByView:(REINearbyView *)nearByView andDidSelectRowObj:(REINearbyItem *)obj;

@end

@interface REINearbyView : UIView
@property(nonatomic, weak)id<REINearbyViewDelegate> delegate;
@property(nonatomic,strong) NSArray * dataArray;
@property(nonatomic,weak) UITableView * tableView;
+ (instancetype)nearbyView;
@end