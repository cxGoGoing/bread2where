//
//  REIRecController.m
//  Bread2Where
//
//  Created by FEI on 15/6/9.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIRecController.h"
#import "REISearchBar.h"
#import "SDCycleScrollView.h"
#import "MMProgressHUD.h"
#import "REIBanner.h"
#import "MJExtension.h"
#import "REIWebViewController.h"
#import "REITrip.h"
#import "REIRecCell.h"
#import "REINearbyController.h"
#import "MJRefresh.h"
#import "REIHotRecView.h"
#import "REIHotDes.h"
#import "GPrecommandDetailController.h"
#import "REIDesDetailController.h"
#import "REIHotDes.h"
#import "REIDesDetailView.h"
#import "REICityDetailModel.h"
#import "SVProgressHUD.h"
#import "REIRecAdsWebController.h"
@interface REIRecController ()<UISearchBarDelegate,SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,REIHotRecViewDelegate>
{
    REISearchBar * _searchBar;
    UIButton * _nearbyBtn;
    UIButton * _cancelBtn;
    UIView * _titleView;
    NSMutableArray * _bannerURLStrings;
    NSMutableArray * _bannerArray;
    SDCycleScrollView * _adsScrollView;
    NSInteger _offset;
    UITableView * _tableView;
    MJRefreshHeaderView * _header;
    MJRefreshFooterView * _footer;
    REIHotRecView * _hotRecView;
}
@property(nonatomic,strong) NSMutableArray * dataArray;
@property(nonatomic,strong) NSMutableArray * abroadData;
@property(nonatomic,strong) NSMutableArray * insideData;
@end

@implementation REIRecController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavBar];
    
    [self setupTableView];
    
    [self setupRefresh];
    [self setupRequestToGetTrips];

    _hotRecView = [REIHotRecView hotRecView];
    _hotRecView.frame= self.view.bounds;
    _hotRecView.delegate = self;
    
//    UIGestureRecognizer * gestureTap = [[UIGestureRecognizer alloc]initWithTarget:self action:@selector(fingerTapped:)];

//    _hotRecView.userInteractionEnabled = YES;
    [self setupRequestSearchItems];
    [self.view addSubview:_hotRecView];
    _hotRecView.hidden = YES;
    

}

#pragma mark 创建主界面 tableview
- (void) setupTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.centerX = MAIN_SCREEN_WIDTH * 0.5;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];

    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 80, 0);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //创建顶部无限轮播控件
    [self setupRequestToGetBanners];
    [self.view addSubview:_tableView];
}

#pragma mark 顶部无限广告轮播,加载网络图片
- (void) setupAdsScrollView
{
    _adsScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 200) imageURLStringsGroup:_bannerURLStrings];
    _adsScrollView.delegate = self;
    _adsScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    _adsScrollView.placeholderImage = [UIImage imageNamed:@"poi_bg_placeholder"];
    _adsScrollView.dotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    _adsScrollView.autoScrollTimeInterval = 3;
    /*
    // 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _adsScrollView.imageURLStringsGroup = _bannerURLStrings;
    });
    */
    _tableView.tableHeaderView = _adsScrollView;
}

#pragma mark 获得顶部 banner 数据
-(void) setupRequestToGetBanners
{
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleDrop];
    [MMProgressHUD showWithTitle:nil status:@"正在加载数据"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:HOT_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *requestDict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        
        NSMutableArray *items = [NSMutableArray arrayWithArray:requestDict[@"banners"]];
        
        _bannerArray = [NSMutableArray array];
        _bannerURLStrings = [NSMutableArray array];
        
        for (NSDictionary *dict in items) {
            REIBanner * banner = [REIBanner objectWithKeyValues:dict];
            [_bannerArray addObject:banner];
            [_bannerURLStrings addObject:banner.image_url];
        }
        [MMProgressHUD dismiss];

        [self setupAdsScrollView];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MMProgressHUD dismissWithError:@"网络出错啦"];
    }];
}

#pragma mark dataArray 的懒加载
-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{

    REIRecAdsWebController * webViewController = [[REIRecAdsWebController alloc]init];
    REIBanner * banner = _bannerArray[index];
    webViewController.url = banner.html_url;
    webViewController.navigationItem.title = @"详情";
    [self.navigationController pushViewController:webViewController animated:YES];
}


-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    [_searchBar resignFirstResponder];
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
    nearbyController.navigationItem.title = @"我的附近";
    UINavigationController * recommandNearNav=[[UINavigationController alloc]initWithRootViewController:nearbyController];
    [self presentViewController:recommandNearNav animated:YES completion:nil];
}

- (void) cancelBtnTouch
{
    _searchBar.text = nil;
    _nearbyBtn.hidden = NO;
    _cancelBtn.hidden = YES;
    _hotRecView.hidden = YES;
    _hotRecView.userInteractionEnabled = NO;
    [_searchBar resignFirstResponder];
}

#pragma mark 搜索框编辑状态下,按钮状态改变
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    _nearbyBtn.hidden = YES;
    _cancelBtn.hidden = NO;
    
    _hotRecView.hidden = NO;
    _hotRecView.userInteractionEnabled = YES;
//    [searchBar resignFirstResponder];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_searchBar resignFirstResponder];
}

#pragma mark tableView 代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    REIRecCell * cell = [REIRecCell recCellWithTableView:tableView andIndexPath:indexPath andObj:_dataArray[indexPath.section]];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 9;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

#pragma mark 获得tableView数据
-(void) setupRequestToGetTrips
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:[NSString stringWithFormat:TRIP_URL, _offset] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSDictionary *requestDict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        
        NSMutableArray *trips = [NSMutableArray arrayWithArray:requestDict[@"trips"]];
        
        
        for (NSDictionary *dict in trips) {
            REITrip * trip = [REITrip modelWithDict:dict];
            [self.dataArray addObject:trip];
        }
        
        if (_offset == 0) {
            [_header endRefreshing];
        }else{
            [_footer endRefreshing];
        }
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(void) setupRefresh {
    _header = [MJRefreshHeaderView header];
    __block REIRecController * controller = self;
    _header.scrollView = _tableView;
    _header.beginRefreshingBlock = ^(MJRefreshBaseView *view){
        _offset = 0;
        [controller setupRequestToGetTrips];
    };
    _footer = [MJRefreshFooterView footer];
    _footer.scrollView = _tableView;
    _footer.beginRefreshingBlock = ^(MJRefreshBaseView*view){
        _offset += 20;
        [controller setupRequestToGetTrips];
    };
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
     
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GPrecommandDetailController * recommandDetailController = [[GPrecommandDetailController alloc]init];
    REITrip * trip = self.dataArray[indexPath.section];
    NSString * str =[NSString stringWithFormat:@"%ul",trip.ID];
    if ([str hasSuffix:@"l"]) {
        str = [str substringToIndex:str.length - 1];
    }
   
    recommandDetailController.urlString = [NSString stringWithFormat:SHOUYECELLDETAIL,str];
    recommandDetailController.navigationItem.title = trip.name;
    [self.navigationController pushViewController:recommandDetailController animated:YES];
}

-(void)hotRecViewDelegate:(REIHotRecView *)hotRecItemCell withHotRec:(REIHotDes *)hotDes
{
    REIDesDetailController * desDetailController = [[REIDesDetailController alloc]init];
    desDetailController.idDes = hotDes.ID;
    desDetailController.type = [NSString stringWithFormat:@"%ld",hotDes.type];
    desDetailController.cityName = hotDes.name;
//    REICityDetailModel * cityDetailModel = desDetailController.detailView.section[0];
//    desDetailController.cover = cityDetailModel.photo;
    
    desDetailController.visited_count = hotDes.visited_count;
    desDetailController.wish_to_go_count = hotDes.wish_to_go_count;
    REIMainNavigationController * desDetailNavController = [[REIMainNavigationController alloc]initWithRootViewController:desDetailController];
    [self presentViewController:desDetailNavController animated:YES completion:nil];
}

-(void)dealloc
{
    
}
@end
