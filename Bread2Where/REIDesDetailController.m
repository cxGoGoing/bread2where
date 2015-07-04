//
//  REIDesDetailController.m
//  Bread2Where
//
//  Created by qianfeng on 15-6-13.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIDesDetailController.h"
#import "MMProgressHUD.h"
#import "AFNetworking.h"
#import "REICityDetailModel.h"
#import "REIDesDetailView.h"
#import "REIDesBKCGWebViewController.h"
#import "REIWebViewController.h"
#import "REINearbyController.h"
#import "REIdesDetailSpecialController.h"
#import "REIDesDetailPitcureController.h"
#import "REISYXZWebViewController.h"
#import "REIDesDetailJPController.h"
@interface REIDesDetailController()<REIDesDetailDelegate>

@property (nonatomic,weak)UIScrollView * scrollView;

//@property (nonatomic,strong)CWDestDetailHeader * header;
@end
@implementation REIDesDetailController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // 创建页面
    self.view.backgroundColor = [UIColor clearColor];
    
    //请求数据
    [self setUpView];
    [self requestDetailData];
    self.navigationItem.title = @"不可错过";
        
}


- (void)setUpView
{
    REIDesDetailView * detailView = [REIDesDetailView desDetailViewSetUp];
    self.detailView = detailView;
    detailView.delegate = self;
    [self.view addSubview:detailView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)requestDetailData
{
//    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
//    [MMProgressHUD showWithTitle:nil status:@"正在加载数据"];
    
    NSString * path = [NSString stringWithFormat:DES_DETAIL_URL,_type, _idDes];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *requestDict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        NSArray * hottest_places = requestDict[@"hottest_places"];
        NSMutableArray *items = [NSMutableArray array];
        for (NSDictionary * dict in hottest_places)
        {
            REICityDetailModel * placesModel =[REICityDetailModel cityDetailModelWithDict:dict];
            [items addObject:placesModel];
        }
        self.detailView.section = items;
        if (_cover == nil) {
            REICityDetailModel * model = self.detailView.section[0];
            _cover = [model photo];
        }
        self.detailView.cover = _cover;
        self.detailView.cityName = _cityName;
        self.detailView.visited_count = _visited_count;
        self.detailView.wish_to_go_count = _wish_to_go_count;
        self.detailView.idDes = _idDes;
        self.detailView.type = _type;
        self.detailView.delegate = self;
//        [MMProgressHUD dismissWithSuccess:@"收工了"];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

    }];
}

#pragma mark 实现代理
- (void)btnClick:(REIDesDetailView *)detailView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)desDetailViewTristPlaceBtnTcouch
{
    REINearbyController * nearbyController = [[REINearbyController alloc]init];
    REIMainNavigationController *nearByDetailNav=[[REIMainNavigationController alloc]initWithRootViewController:nearbyController];
    nearbyController.navigationItem.title = @"旅行地点";
    [self presentViewController:nearByDetailNav animated:YES completion:nil];
}
-(void)desDetailViewsSpecialProductBtnTouch
{
    REIdesDetailSpecialController * specialC=[[REIdesDetailSpecialController alloc]init];
    REIMainNavigationController * desDetailSpecialNav=[[REIMainNavigationController alloc]initWithRootViewController:specialC];
    [self presentViewController:desDetailSpecialNav animated:YES completion:nil];
}

-(void)skipToIntro:(NSString *)url
{
    if ([url hasPrefix:@"http://breadtrip.com/mobile/destination/5/"]) {
        REIWebViewController * webController = [[REIWebViewController alloc]init];
        webController.navigationItem.title = @"不可错过";
        webController.url = url;
        [self.navigationController pushViewController:webController animated:YES];
    } else {
        REIDesBKCGWebViewController * webViewController = [[REIDesBKCGWebViewController alloc]init];
        webViewController.url = url;
        [self.navigationController pushViewController:webViewController animated:YES];
//        [self presentViewController:webViewController animated:YES completion:nil];
    }
}

/**
 *  代理方法，点击collectionView的图片之后进入图片轮播界面
 *
 *  @param desDetailPitcureController
 */
-(void)presentDesDetailPitcureController:(REIDesDetailPitcureController *)desDetailPitcureController
{
    [self presentViewController:desDetailPitcureController animated:YES completion:nil];
}

-(void)deDetailViewsShouldKnowBtnTouch:(NSString *)url
{
    REISYXZWebViewController * webController = [[REISYXZWebViewController alloc]init];
    webController.url = url;
    [self.navigationController pushViewController:webController animated:YES];
}

- (void)skipTointro:(NSInteger)btn
{
    switch (btn) {
        case 100: //不可以错过
            
            break;
        case 101: //旅行地点
            break;
        case 102: //精品游记
        {
            REIDesDetailJPController * jpController = [[REIDesDetailJPController  alloc]init];
            jpController.idDes = _idDes;
            jpController.type = _type;
            REIMainNavigationController * naviagationController = [[REIMainNavigationController alloc]initWithRootViewController:jpController];
            [self presentViewController:naviagationController animated:YES completion:nil];
            
        }
            break;
        case 103: //推荐路线
            break;
        case 104: //特价产品
            break;
        default:
            break;
    }
}


@end
