//
//  REIDesDetailJPView.m
//  Bread2Where
//
//  Created by qianfeng on 15-6-16.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIDesDetailJPView.h"
#import "REIDesDetailJPViewCell.h"
#import "MJRefresh.h"
@interface  REIDesDetailJPView()<UITableViewDataSource ,UITableViewDelegate,MJRefreshBaseViewDelegate>
@property(nonatomic, weak)UITableView *tableView;

@property (weak, nonatomic) MJRefreshHeaderView * refreshHeaderView;
@property (weak, nonatomic) MJRefreshFooterView * refreshFooterView;

@end
@implementation REIDesDetailJPView

+ (instancetype)desDetailJPView
{
    return [[self alloc]initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UITableView * tableView = [[UITableView alloc]init];
        self.tableView = tableView;
        tableView.delegate = self;
        tableView.dataSource = self;
       

        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:tableView];
        
        
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

- (void)setSectionArray:(NSMutableArray *)sectionArray
{
    _sectionArray = sectionArray;
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

#pragma mark 数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sectionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    REIDesDetailJPViewCell * cell = [REIDesDetailJPViewCell desDetailJPViewCellWithTableView:tableView andObj:self.sectionArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    return 290;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_delegate themeViewDidSelect:self andObj:self.sectionArray[indexPath.row]];
}

#pragma mark 刷新
- (void)refreshView:(MJRefreshBaseView *)refreshView stateChange:(MJRefreshState)state
{
    if ([refreshView isKindOfClass:[MJRefreshHeaderView class]])
    {
        [_delegate themeviewRefresh:REIThemeViewRefreshHeaderView andPage:1];
    }else
    {
        int pageNumber = (int)self.sectionArray.count + 20;
        [_delegate themeviewRefresh:REIThemeViewRefreshFooterView andPage:pageNumber];
    
    }
}

- (void)dealloc
{
    [_refreshFooterView free];
    [_refreshHeaderView free];
}
@end

