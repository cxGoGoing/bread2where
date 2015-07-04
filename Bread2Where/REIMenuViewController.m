//
//  MenuViewController.m
//  ShouGongKe
//
//  Created by qianfeng on 15/4/23.
//  Copyright (c) 2015年 ZYF. All rights reserved.
//

#import "REIMenuViewController.h"

#define BUTTON_TAG 100

@interface REIMenuViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) NSArray *titleArray;
@property(nonatomic, strong)NSArray *vcArray;

@end

@implementation REIMenuViewController
{
    UIView * _scrollbuttonBackView;
    UIScrollView * _headerScrollView;
    UICollectionView * _collectionView;
}

#pragma mark init

-(id)initWithFrame:(CGRect)frame titles:(NSArray*)titleArray vcArray:(NSArray *)vcArray
{

    
    self = [super init];
        self.view.frame = frame;
    if(self)
    {
        self.titleArray = titleArray;
        self.vcArray = vcArray;
        [self setMenuBar];
        [self setCollectionView];
    }
    return self;
}
-(id)initViewControllerWithTitleArray:(NSArray *)titleArray vcArray:(NSArray*)vcArray
{
    self = [super init];
    if(self)
    {
        self.titleArray = titleArray;
        self.vcArray = vcArray;
        [self setMenuBar];
        [self setCollectionView];
    }
    return self;
}

#pragma mark 生命周期
- (void)viewDidLoad {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    [super viewDidLoad];


}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

#pragma mark UI

-(void)setMenuBar
{
    _headerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    _headerScrollView.contentSize = _headerScrollView.frame.size;
    _headerScrollView.pagingEnabled = NO;
    _headerScrollView.bounces = NO;
    [self.view addSubview:_headerScrollView];
    
    CGFloat width = self.view.frame.size.width / self.titleArray.count;
    int i = 0;
    for (NSString *title in self.titleArray) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i *width, 0, width, CGRectGetHeight(_headerScrollView.frame))];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor purpleColor] forState:UIControlStateSelected];
        button.tag = BUTTON_TAG + i;
        [button addTarget:self action:@selector(setSelectedButton:) forControlEvents:UIControlEventTouchUpInside];
        [_headerScrollView addSubview:button];
        i++;
    }
    
    [self createMenuButtonForeground];
    
}

-(void)createMenuButtonForeground
{
    UIButton *button = (UIButton*)[_headerScrollView viewWithTag:BUTTON_TAG];
    _scrollbuttonBackView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(button.frame) - 2, CGRectGetWidth(button.frame), 2)];
    _scrollbuttonBackView.backgroundColor = [UIColor redColor];
    [_headerScrollView addSubview:_scrollbuttonBackView];
}

-(void)setupMenuButtonForeground:(UIButton*)button
{
    CGRect frame = CGRectMake(CGRectGetMinX(button.frame), CGRectGetMaxY(button.frame) - 2, CGRectGetWidth(button.frame), 2);
    _scrollbuttonBackView.frame = frame;
}

-(void)setSelectedButton:(UIButton *)button
{
    [button setSelected:YES];
    NSArray *subArray = _headerScrollView.subviews;
    for (UIButton *subbutton  in subArray) {
        if ([subbutton isKindOfClass:[UIButton class]]) {
            if (subbutton != button) {
                [subbutton setSelected:NO];
            }
        }
        
    }
    
    [self setupMenuButtonForeground:button];

    [_collectionView setContentOffset:CGPointMake((button.tag - 100)* CGRectGetWidth(self.view.frame), 0) animated:YES];
}

-(void)setCollectionView
{
    CGRect frame = CGRectMake(0, CGRectGetMaxY(_headerScrollView.frame), self.view.frame.size.width, self.view.frame.size.height - CGRectGetHeight(_headerScrollView.frame));
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    //设置滑动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置item size
    flowLayout.itemSize = frame.size;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
    //设置是否页面滚动效果
    _collectionView.pagingEnabled = YES;
    _collectionView.bounces = NO;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
}

#pragma mark CollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UIViewController *vc = self.vcArray[indexPath.item];
     [self addChildViewController:vc];
    vc.view.frame = cell.contentView.bounds;
    [cell.contentView addSubview:vc.view];
//    [vc didMoveToParentViewController:self];
   
    return cell;
}


#pragma mark scrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    NSInteger index = (NSInteger)floor((point.x / self.view.frame.size.width));
    UIButton *button = (UIButton*)[_headerScrollView viewWithTag:BUTTON_TAG + index];
    if (self.delegate != nil && [self.delegate conformsToProtocol:NSProtocolFromString(@"REIMenuViewControllerDelegate")]) {
        [self.delegate menuViewController:self currentPageChanged:index];
    }
    
    [self setSelectedButton:button];
}


@end
