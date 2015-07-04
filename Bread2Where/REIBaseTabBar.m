//
//  REIBaseTabBar.m
//  Rei
//
//  Created by FEI on 15/5/8.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIBaseTabBar.h"
#import "REIBaseTabBarBtn.h"
//#define TABBAR_HEIGHT (MAIN_SCREEN_WIDTH / 5.0) / (144.0 / 110)
#define TABBAR_HEIGHT 54
@interface REIBaseTabBar()
@property (nonatomic, weak) UIImageView * bgView;
@property (nonatomic, weak) UIButton *selectedBtn;
@end

@implementation REIBaseTabBar

+(instancetype)baseTabBar
{
    return [[self alloc]initWithFrame:CGRectZero];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        self.height = TABBAR_HEIGHT;
        self.backgroundColor = [UIColor colorWithRed:0.92 green:0.93 blue:0.93 alpha:0.97];
//        [self makeCorner:3];
    }
    return self;
}

-(void)setBtnItems:(NSArray *)btnItems
{
    _btnItems = btnItems;
    for(REIBaseTabBarBtn * btn in btnItems) {
        [self addSubview:btn];
    }
    [self setNeedsLayout];
}

- (void)setBackground:(UIImage *)background
{
    _background = background;
    
    if (_bgView == nil)
    {
        UIImageView * bgView = [[UIImageView alloc]init];
        [self insertSubview:bgView atIndex:0];
        self.bgView = bgView;
    }
    
    self.bgView.image = background;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    

    CGFloat btnWidth = MAIN_SCREEN_WIDTH / self.btnItems.count;
    
    //for循环从 第二个UIButton对象开始添加约束
    for(int i = 0; i < self.btnItems.count; i++)
    {
        REIBaseTabBarBtn * btn = self.btnItems[i];
        btn.x = btnWidth * i;
        btn.width = btnWidth;
        btn.height = TABBAR_HEIGHT;
        btn.tag = i;
        [btn addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self.btnItems[0] setSelected:YES];
    self.selectedBtn = self.btnItems[0];
    self.bgView.frame = self.bounds;
    
    
    //自定义 tabbar 顶部的线
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 0.25)];
    line.backgroundColor = [UIColor colorWithRed:0.85f green:0.85f blue:0.85f alpha:1.00f];
    [self addSubview:line];
}


- (void)btnTouch:(UIButton *)btn
{
//    int i = 0;
//    if(i == 0) {
//        self.selectedBtn = btn;
//        i++;
//    }
    self.selectedBtn.selected = NO;
    //2.再将当前按钮设置为选中
    btn.selected = YES;
    //3.最后把当前按钮赋值为之前选中的按钮
    self.selectedBtn = btn;
    [self.delegate baseTabBar:self selectedFrom:(int)self.selectedBtn.tag to:(int)btn.tag];
}

- (void)didMoveToSuperview
{
    
    //添加约束 左 右 上 高度
    
    if (self.superview == nil) return;
    
    //1.禁止autoresizing
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    //2.创建约束条件
    //左 下 右 高
    NSLayoutConstraint * left = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    
    NSLayoutConstraint * right = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    
    NSLayoutConstraint * bottm = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    
    NSLayoutConstraint * height = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:TABBAR_HEIGHT];
    
    //3.添加约束
    [self.superview addConstraint:left];
    [self.superview addConstraint:right];
    [self.superview addConstraint:bottm];
    [self addConstraint:height];
    
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    self.frame = newSuperview.bounds;
}


@end
