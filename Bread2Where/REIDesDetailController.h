//
//  REIDesDetailController.h
//  Bread2Where
//
//  Created by qianfeng on 15-6-13.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import <UIKit/UIKit.h>
@class REIDesDetailView;
@interface REIDesDetailController : UIViewController
@property(nonatomic, copy)NSString * idDes;
@property(nonatomic, strong)REIDesDetailView * detailView;
@property(nonatomic, copy)NSString * type;
@property(nonatomic, copy)NSString * cover;
@property(nonatomic, copy)NSString * cityName;
@property(nonatomic, assign)NSInteger visited_count;
@property(nonatomic, assign)NSInteger wish_to_go_count;
@end
