//
//  REIDesDetailPitcureController.h
//  Bread2Where
//
//  Created by qianfeng on 15-6-15.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface REIDesDetailPitcureController : UIViewController

/**
 *  图片信息数组
 */
@property(nonatomic,strong)NSMutableArray * desDetailPitcureArray;
/**
 *  定义一个NSInteger保存单击的Item的Index
 */
@property(nonatomic,assign)NSInteger itemIndex;

@end
