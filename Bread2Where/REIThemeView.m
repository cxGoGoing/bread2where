//
//  REIThemeView.m
//  Bread2Where
//
//  Created by qianfeng on 15-6-14.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIThemeView.h"
#import "REIThemeCellView.h"
#import "MJRefresh.h"
#import "REIThemeDetailModel.h"
#import "REIThemeDetailFrameCell.h"
@interface REIThemeView ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>
@property(nonatomic, weak)UITableView * tableView;
@property (weak, nonatomic) MJRefreshHeaderView * refreshHeaderView;
@property (weak, nonatomic) MJRefreshFooterView * refreshFooterView;
@end

@implementation REIThemeView

- (void)awakeFromNib
{
    
}


+ (instancetype)themeViewCreate
{
    return [[self alloc]initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        UITableView * tableView = [[UITableView alloc]init];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView = tableView;
        [self addSubview:tableView];
        
        UIView * footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 60)];
        tableView.tableFooterView = footerView;
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
        //添加第三方的上拉刷新,以及下拉加载更多控件
        //1.添加下拉刷新
        MJRefreshHeaderView * refreshHeaderView = [MJRefreshHeaderView header];
        //目的是要监听到,tableView对象的滑动
        refreshHeaderView.scrollView = self.tableView;
        //设置代理
        refreshHeaderView.delegate = self;
        self.refreshHeaderView = refreshHeaderView;
        
        //2.添加上拉加载更多
        MJRefreshFooterView * refreshFooterView = [MJRefreshFooterView footer];
        refreshFooterView.scrollView = self.tableView;
        refreshFooterView.delegate = self;
        self.refreshFooterView = refreshFooterView;
    }
    return self;
}

- (void)setMutableArray:(NSMutableArray *)mutableArray
{
    _mutableArray = mutableArray;
    [self.tableView reloadData];
    //3.去掉下拉刷新动画
    [self.refreshHeaderView endRefreshing];
    //4.去掉上拉加载更多动画
    [self.refreshFooterView endRefreshing];
}
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    self.frame = newSuperview.bounds;
    self.tableView.frame = self.frame;
}

#pragma mark 数据源方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mutableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    REIThemeCellView * cell = [REIThemeCellView themeCellViewWithTable:tableView andObj:self.mutableArray[indexPath.row]];
    return cell;
}
#pragma mark 代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_delegate themeViewDidSelect:self andObj:self.mutableArray[indexPath.row]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 220;
}
#pragma mark  下拉刷新代理

- (void)refreshView:(MJRefreshBaseView *)refreshView stateChange:(MJRefreshState)state
{
    if ([refreshView isKindOfClass:[MJRefreshHeaderView class]])
    {
        [_delegate themeviewRefresh:REIThemeViewRefreshHeaderView andPage:1];
    }else
    {
        int pageNumber = (int)self.mutableArray.count/10 + 1;
        [_delegate themeviewRefresh:REIThemeViewRefreshFooterView andPage:pageNumber];
    }
}



@end
