//
//  REIThemeDetailView.m
//  Bread2Where
//
//  Created by qianfeng on 15-6-15.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIThemeDetailView.h"
#import "REIThemeDetailCell.h"
#import "UIImageView+WebCache.h"
#import "REIThemeDetailModel.h"
#import "REIThemeDetailFrameCell.h"

@interface REIThemeDetailView()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, weak)UIImageView * imgView;
@property(nonatomic, weak)UITableView * tableView;
@property(nonatomic, weak)UILabel * nameLabel;
@property(nonatomic, weak)UILabel * titleLabel;
@end
@implementation REIThemeDetailView

+ (instancetype)themeDetailViewCreate
{
    return [[self alloc]initWithFrame:CGRectZero];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createHeadView];
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imgView.frame), MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        tableView.delegate =self;
        tableView.dataSource = self;
        self.tableView = tableView;
        [self addSubview:tableView];
        tableView.tableHeaderView = self.imgView;
        UIView * footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 50)];
        [self addSubview:footerView];
        
        tableView.tableFooterView = footerView;
    }
    return self;
}

//创建headView
- (void)createHeadView
{
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 200)];
    self.imgView = imgView;
    //名字
    CGFloat nameLabelX = 0;
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(nameLabelX, 30, MAIN_SCREEN_WIDTH, 50)];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont boldSystemFontOfSize:28];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel = nameLabel;
    [imgView addSubview:nameLabel];
    //下划线
    CGFloat botNameX = (MAIN_SCREEN_WIDTH - 300)*0.5;
    UIView * botNameView = [[UIView alloc]initWithFrame:CGRectMake(botNameX, CGRectGetMaxY(nameLabel.frame)+10, 300, 1)];
    botNameView.backgroundColor = [UIColor whiteColor];
    botNameView.alpha = 0.5;
    [imgView addSubview:botNameView];
    //标题
    CGFloat titleLabelX = (MAIN_SCREEN_WIDTH - 200)*0.5;
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabelX, CGRectGetMaxY(nameLabel.frame) + 20, 200, 10)];
    self.titleLabel = titleLabel;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    [imgView addSubview:titleLabel];
    [self addSubview:imgView];
}

//头部的文字
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    REIThemeArticleModel * artilceModel = _titleArray[section];
    return artilceModel.title;
}

- (void)setDetailModel:(REIThemeDetailModel *)detailModel
{
   _detailModel = detailModel;
    NSURL * url = [NSURL URLWithString:detailModel.image_url];
    [self.imgView sd_setImageWithURL:url placeholderImage: [UIImage imageNamed:@"featured_theme" ]];
    self.titleLabel.text =  detailModel.title;
    self.nameLabel.text = detailModel.name;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    self.frame = newSuperview.bounds;
    self.tableView.frame = self.frame;
}

- (void)setMutableArray:(NSMutableArray *)mutableArray
{
    _mutableArray = mutableArray;
    [self.tableView reloadData];
}

#pragma mark 数据源

//返回多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

   return self.mutableArray.count;
}

//返回一组多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

//返回每一行的cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    REIThemeDetailFrameCell * statusFrame = self.mutableArray[indexPath.section];
    return statusFrame.cellHeight;
}

- (void)setTitleArray:(NSMutableArray *)titleArray
{
    _titleArray = titleArray;
}

//显示每一行的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    REIThemeDetailCell * cell = [REIThemeDetailCell themeDetailCellWithTableView:tableView ];
    cell.detailFrame = self.mutableArray[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//title的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   REIThemeArticleModel * model = _titleArray[section];
    if ([@""isEqualToString:model.title])
    {
        return 0.2;
    }
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
@end
