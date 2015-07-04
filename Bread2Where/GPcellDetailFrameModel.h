//
//  GPcellDetailFrameModel.h
//  面包旅行
//
//  Created by qianfeng on 15-6-13.
//  Copyright (c) 2015年 李中飞. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GPcellDetailWaypointsM;
@interface GPcellDetailFrameModel : NSObject

@property(nonatomic,assign,readonly)CGRect photoF;
@property(nonatomic,assign,readonly)CGRect textF;
@property(nonatomic,assign,readonly)CGRect local_timeF;

/**
 *  cell高度
 */
@property(nonatomic,assign)CGFloat cellHeight;

@property(nonatomic,strong)GPcellDetailWaypointsM * cellDetailW;

+(id)cellDetailFrameModel;

@end
