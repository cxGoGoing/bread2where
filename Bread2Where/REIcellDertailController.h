//
//  REIcellDertailController.h
//  Bread2Where
//
//  Created by qianfeng on 15-6-14.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface REIcellDertailController : UIViewController

/**
 *  图片索引
 */
@property(nonatomic,assign)NSInteger index;
/**
 *  数据数组(由上个界面传过来)
 */
@property(nonatomic,strong)NSMutableArray * cellDetailArray;
/**
 *  存放数据模型的数组
 */
@property(nonatomic,strong)NSMutableArray * dataModelArray;



@end
