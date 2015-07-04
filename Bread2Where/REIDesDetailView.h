//
//  REIDesDetailView.h
//  Bread2Where
//
//  Created by qianfeng on 15-6-13.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import <UIKit/UIKit.h>
@class REIDesDetailView;
@class REIDesDetailPitcureController;
@protocol REIDesDetailDelegate <NSObject>

- (void)btnClick:(REIDesDetailView *)detailView;
- (void)skipToIntro:(NSString *)url;
- (void)presentDesDetailPitcureController:(REIDesDetailPitcureController *)desDetailPitcureController;
-(void)desDetailViewTristPlaceBtnTcouch;
-(void)desDetailViewsSpecialProductBtnTouch;
-(void)deDetailViewsShouldKnowBtnTouch:(NSString *)url;
- (void)skipTointro:(NSInteger)btn;
@end

@interface REIDesDetailView : UIView
@property(nonatomic, strong)NSMutableArray * section;
@property(nonatomic, copy)NSString * cover;
@property(nonatomic, copy)NSString * cityName;
@property(nonatomic, assign)NSInteger visited_count;
@property(nonatomic, assign)NSInteger wish_to_go_count;
@property(nonatomic, copy)NSString * idDes;
@property(nonatomic, copy)NSString * type;
@property(nonatomic, weak)id<REIDesDetailDelegate>delegate;
+ (instancetype)desDetailViewSetUp;
@end
