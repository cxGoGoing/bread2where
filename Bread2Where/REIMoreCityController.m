//
//  REIDesEuropeController.m
//  Bread2Where
//
//  Created by FEI on 15/6/13.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIMoreCityController.h"
#import "REICity.h"
#import "REIDesCell.h"
#import "SVProgressHUD.h"
#import "REIDesDetailController.h"
#define MARGIN 10
@interface REIMoreCityController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView * _collectionView;
}
@property(nonatomic,strong) NSMutableArray * dataArray;
@end

@implementation REIMoreCityController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void) setupCollectionView {
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 130, 0);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
}

-(NSMutableArray *)dataArray
{
    if (_dataArray == nil)  {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark 获得顶部 banner 数据
-(void) setupRequest
{
    [SVProgressHUD show];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:_urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *requestDict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        
        NSMutableArray *items = [NSMutableArray arrayWithArray:requestDict[@"data"]];
        
        for (NSDictionary * dict in items) {
            REICity * city = [REICity modelWithDict:dict];
            [self.dataArray addObject:city];
        }
        
        [SVProgressHUD dismiss];
        [_collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    REICity * city = self.dataArray[indexPath.item];
    REIDesCell * cell = [REIDesCell desCellWithCollectionView:collectionView andIndexPath:indexPath andObj:city];
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
    return UIEdgeInsetsMake(10, MARGIN, 0, MARGIN);
}

#pragma mark 点击cell进入第二个页面
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    REIDesDetailController * detailController = [[REIDesDetailController alloc]init];
    REICity * cityModel = self.dataArray[indexPath.item];
    NSString * des = [NSString stringWithFormat:@"%@",cityModel.idDes];
    detailController.idDes = des;
    NSString * type = [NSString stringWithFormat:@"%ld",(long)cityModel.type];
    detailController.type = type;
    detailController.cover = cityModel.cover;
    detailController.cityName = cityModel.name;
    detailController.visited_count = cityModel.visited_count;
    detailController.wish_to_go_count = cityModel.wish_to_go_count;
    [self presentViewController:detailController animated:YES completion:nil];
}
@end