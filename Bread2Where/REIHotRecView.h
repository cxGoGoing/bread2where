//
//  REIHotRecView.h
//  Bread2Where
//
//  Created by FEI on 15/6/13.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import <UIKit/UIKit.h>
@class REIHotRecView;
@class REIHotDes;

@protocol REIHotRecViewDelegate <NSObject>
- (void)hotRecViewDelegate:(REIHotRecView *)hotRecItemCell withHotRec:(REIHotDes *)hotDes;
@end

@interface REIHotRecView : UIView
@property(nonatomic,weak) id<REIHotRecViewDelegate> delegate;
@property(nonatomic,strong) NSMutableArray * abroadData;
@property(nonatomic,strong) NSMutableArray * insideData;

+(instancetype) hotRecView;
@end
