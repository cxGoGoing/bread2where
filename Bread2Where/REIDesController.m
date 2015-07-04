//
//  REIDesController.m
//  Bread2Where
//
//  Created by FEI on 15/6/9.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIDesController.h"
#import "REISearchBar.h"
#import "REIDesCell.h"
#import "REICity.h"
#import "REIRecDes.h"
#import "REIDesSectionHeader.h"
#import "REIDesEuropeController.h"
#import "REIChinaCityController.h"
#import "REIAsiaController.h"
#import "REINearbyController.h"
#import "REIDesDetailController.h"
#import "REIHotRecView.h"
#import "SVProgressHUD.h"
#import "REIHotDes.h"
#define MARGIN 10

@interface REIDesController ()<UISearchBarDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,REIHotRecViewDelegate>
{
    REISearchBar * _searchBar;
    UIButton * _nearbyBtn;
    UIButton * _cancelBtn;
    UIView * _titleView;
    UICollectionView * _collectionView;
    REIHotRecView * _hotRecView;
}

@property(nonatomic,strong) NSMutableDictionary * dataDict;
@property(nonatomic,strong) NSMutableArray * titleArray;
@property(nonatomic,strong) NSMutableArray * abroadData;
@property(nonatomic,strong) NSMutableArray * insideData;
@end

@implementation REIDesController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavBar];
    [self setupRequest];
    [self setupCollectionView];
    
    _hotRecView = [REIHotRecView hotRecView];
    _hotRecView.frame= self.view.bounds;
    _hotRecView.delegate = self;
    //    _hotRecView.userInteractionEnabled = YES;
    [self setupRequestSearchItems];
    [self.view addSubview:_hotRecView];
    _hotRecView.hidden = YES;
}

- (void) setupCollectionView {
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 80, 0);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
    [self.view addSubview:_collectionView];
}

-(NSMutableDictionary *)dataDict
{
    if(_dataDict == nil) {
        _dataDict = [NSMutableDictionary dictionary];
    }
    return _dataDict;
}

-(NSMutableArray *)titleArray
{
    if(_titleArray == nil) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}


-(void) setupRequest
{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:DES_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *requestDict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        
        NSMutableArray *items = [NSMutableArray arrayWithArray:requestDict[@"elements"]];
        
        for (NSDictionary * itemDict in items) {
            NSString * title = itemDict[@"title"];
            [self.titleArray addObject:title];
        }
        
        NSArray * desArray = items[0][@"data"];
        NSMutableArray * recDesArray = [NSMutableArray array];
        for (NSDictionary * dict in desArray) {

            REIRecDes * recDes = [REIRecDes modelWithDict:dict];
            [recDesArray addObject:recDes];
        }
        
        [self.dataDict setObject:recDesArray forKey:self.titleArray[0]];
        
        for (int i = 1; i < items.count; i ++) {
            NSArray * cityData = items[i][@"data"];
            NSMutableArray * cityArray = [NSMutableArray array];
            for (NSDictionary * dict in cityData) {
                REICity * city = [REICity modelWithDict:dict];
                [cityArray addObject:city];
            }
            [self.dataDict setObject:cityArray forKey:self.titleArray[i]];
        }

        [_collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataDict.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataDict[self.titleArray[section]] count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * key = self.titleArray[indexPath.section];
    id obj = [self.dataDict objectForKey:key][indexPath.row];
    REIDesCell * cell = [REIDesCell desCellWithCollectionView:collectionView andIndexPath:indexPath andObj:obj];
    return cell;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return MARGIN;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return MARGIN;
}

-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger width = (MAIN_SCREEN_WIDTH - 3 * MARGIN) * 0.5;
    return CGSizeMake(width, width);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, MARGIN, 0, MARGIN);
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([UICollectionElementKindSectionHeader isEqualToString:kind]) {
        REIDesSectionHeader * header = [REIDesSectionHeader desSectionHeaderWithCollectionView:collectionView andIndexPath:indexPath];
        header.titleLab.text = self.titleArray[indexPath.section];
        if ([header.titleLab.text isEqualToString:@"欧洲国家"]) {
            header.moreBtn.hidden = NO;
            [header.moreBtn addTarget:self action:@selector(moreCity1) forControlEvents:UIControlEventTouchUpInside];
        } else if ([header.titleLab.text isEqualToString:@"亚洲国家"]) {
            header.moreBtn.hidden = NO;
            [header.moreBtn addTarget:self action:@selector(moreCity2) forControlEvents:UIControlEventTouchUpInside];
        } else if ([header.titleLab.text isEqualToString:@"国内城市"]) {
            header.moreBtn.hidden = NO;
            [header.moreBtn addTarget:self action:@selector(moreCity3) forControlEvents:UIControlEventTouchUpInside];
        } else {
            header.moreBtn.hidden = YES;
            [header.moreBtn addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
        }
        return header;
    }
    return nil;
    
}

-(void)moreCity1 {
    REIDesEuropeController * europeController = [[REIDesEuropeController alloc]init];
    [self.navigationController pushViewController:europeController animated:YES];
}

-(void)moreCity2 {
    REIAsiaController * asiaController = [[REIAsiaController alloc]init];
    [self.navigationController pushViewController:asiaController animated:YES];
}

-(void)moreCity3 {
    REIChinaCityController * chinaCityController = [[REIChinaCityController alloc]init];
    [self.navigationController pushViewController:chinaCityController animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(MAIN_SCREEN_WIDTH, 60);
}

#pragma mark 设置顶部导航栏中的搜索框和按钮
-(void) setupNavBar
{
    _titleView = [[UIView alloc]initWithFrame:CGRectMake(20, 0, MAIN_SCREEN_WIDTH, 44)];
    
    _searchBar = [[REISearchBar alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH - 60, 25)];
    _searchBar.delegate = self;
    _searchBar.centerY = _titleView.centerY ;
    [_searchBar makeCorner:12];
    [_titleView addSubview:_searchBar];
    
    _nearbyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nearbyBtn.frame = CGRectMake(CGRectGetMaxX(_searchBar.frame) + 8, 0, 40, 25);
    _nearbyBtn.centerY = _titleView.centerY;
    [_nearbyBtn setTitle:@"附近" forState:UIControlStateNormal];
    [_nearbyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_nearbyBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    _nearbyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_nearbyBtn addTarget:self action:@selector(nearBtnTouch) forControlEvents:UIControlEventTouchUpInside];
    [_titleView addSubview:_nearbyBtn];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.frame = CGRectMake(CGRectGetMaxX(_searchBar.frame) + 8, 0, 40, 25);
    _cancelBtn.centerY = _titleView.centerY;
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _cancelBtn.hidden = YES;
    [_cancelBtn addTarget:self action:@selector(cancelBtnTouch) forControlEvents:UIControlEventTouchUpInside];
    [_titleView addSubview:_cancelBtn];
    
    self.navigationItem.titleView = _titleView;
}

-(void)nearBtnTouch {
    REINearbyController * nearbyController = [[REINearbyController alloc]init];
//    [self.navigationController pushViewController:nearbyController animated:YES];
    nearbyController.navigationItem.title = @"我的附近";
    UINavigationController * nav=[[UINavigationController alloc]initWithRootViewController:nearbyController];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void) cancelBtnTouch
{
    _searchBar.text = nil;
    [_searchBar resignFirstResponder];
}

#pragma mark 搜索框编辑状态下,按钮状态改变
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    _nearbyBtn.hidden = YES;
    _cancelBtn.hidden = NO;
    
    _hotRecView.hidden = NO;
    _hotRecView.userInteractionEnabled = YES;
    
}

#pragma mark 搜索框结束编辑后,按钮状态改变
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    _nearbyBtn.hidden = NO;
    _cancelBtn.hidden = YES;
    _hotRecView.hidden = YES;
    _hotRecView.userInteractionEnabled = NO;

}

#pragma mark cell点击跳转到另一个页面
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray * recDesArray = [self.dataDict objectForKey:self.titleArray[0]];
    NSMutableArray * cityGroupArray = [NSMutableArray array];
    for (int i = 1; i < self.dataDict.count; i++)
    {
        [cityGroupArray addObject:[self.dataDict objectForKey:self.titleArray[i]]];
    }
    REIDesDetailController * detailController = [[REIDesDetailController alloc]init];
    if (indexPath.section == 0)
    {
//        NSLog(@"indexPath.section = %ld,indexPath.item=%ld",indexPath.section,indexPath.item);
        REIRecDes * recModel = recDesArray[indexPath.item];
        NSString * des = [NSString stringWithFormat:@"%@",recModel.idDes];
        detailController.idDes = des;
        
        NSString * type = [NSString stringWithFormat:@"%ld",(long)recModel.type];
        detailController.type = type;
        detailController.cityName = recModel.name;
        detailController.cover = recModel.cover;
        detailController.visited_count = recModel.visited_count;
        detailController.wish_to_go_count = recModel.wish_to_go_count;
    }else
    {
        long indexSection = indexPath.section-1;
        REICity * cityModel = cityGroupArray[indexSection][indexPath.item];
        NSString * des = [NSString stringWithFormat:@"%@",cityModel.idDes];
        detailController.idDes = des;
        
        NSString * type = [NSString stringWithFormat:@"%ld",(long)cityModel.type];
        detailController.type = type;
        detailController.cover = cityModel.cover;
        detailController.cityName = cityModel.name;
        detailController.visited_count = cityModel.visited_count;
        detailController.wish_to_go_count = cityModel.wish_to_go_count;
    }
    detailController.view.backgroundColor = [UIColor clearColor];
    
    REIMainNavigationController * detailNavController = [[REIMainNavigationController alloc]initWithRootViewController:detailController];
    
    [self presentViewController:detailNavController animated:YES completion:nil];
}

-(NSMutableArray *)abroadData
{
    if(_abroadData == nil) {
        _abroadData = [NSMutableArray array];
    }
    return _abroadData;
}

-(NSMutableArray *)insideData
{
    if(_insideData == nil) {
        _insideData = [NSMutableArray array];
    }
    return _insideData;
}

-(void) setupRequestSearchItems
{
    
    [SVProgressHUD show];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:DES_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *requestDict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        
        NSMutableArray *items = [NSMutableArray arrayWithArray:requestDict[@"search_data"]];
        
        NSArray * abordArray = items[0][@"elements"];
        
        for(NSDictionary * dict in abordArray) {
            REIHotDes * hotDes = [REIHotDes modelWithDict:dict];
            [self.abroadData addObject:hotDes];
        }
        
        NSArray * insideArray = items[1][@"elements"];
        
        for(NSDictionary * dict in insideArray) {
            REIHotDes * hotDes = [REIHotDes modelWithDict:dict];
            [self.insideData addObject:hotDes];
        }
        _hotRecView.abroadData = self.abroadData;
        _hotRecView.insideData = self.insideData;
        
        [SVProgressHUD dismiss];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

    }];
}

-(void)hotRecViewDelegate:(REIHotRecView *)hotRecItemCell withHotRec:(REIHotDes *)hotDes
{
    REIDesDetailController * desDetailController = [[REIDesDetailController alloc]init];
    desDetailController.idDes = hotDes.ID;
    desDetailController.type = [NSString stringWithFormat:@"%ld",hotDes.type];
    desDetailController.cityName = hotDes.name;
    
    //    desDetailController.cover = hotDes.cover;
    desDetailController.visited_count = hotDes.visited_count;
    desDetailController.wish_to_go_count = hotDes.wish_to_go_count;
    REIMainNavigationController * desDetailNavController = [[REIMainNavigationController alloc]initWithRootViewController:desDetailController];

    [self presentViewController:desDetailNavController animated:YES completion:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [SVProgressHUD dismiss];
}
@end
