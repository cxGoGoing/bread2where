//
//  REIWaterFlowLayout.h
//  StarWardrobe
//
//  Created by FEI on 15/6/8.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import <UIKit/UIKit.h>

@class REIWaterFlowLayout;

@protocol REIWaterflowLayoutDelegate <NSObject>
- (CGFloat)waterflowLayout:(REIWaterFlowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;
@end

@interface REIWaterFlowLayout : UICollectionViewLayout




@property (nonatomic, assign) UIEdgeInsets sectionInset;
/** 每一列之间的间距 */
@property (nonatomic, assign) CGFloat columnMargin;
/** 每一行之间的间距 */
@property (nonatomic, assign) CGFloat rowMargin;
/** 显示多少列 */
@property (nonatomic, assign) int columnsCount;

@property (nonatomic, weak) id<REIWaterflowLayoutDelegate> delegate;

@end
