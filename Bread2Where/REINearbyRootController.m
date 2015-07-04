//
//  REINearbyRootController.m
//  Bread2Where
//
//  Created by FEI on 15/6/11.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REINearbyRootController.h"
#import "SVProgressHUD.h"
#import "REINearbyItem.h"
#import "REINearbyView.h"
#import "MJRefresh.h"
#import "REILocationUtil.h"
#import "REIDesDetailController.h"
@interface REINearbyRootController ()<REINearbyViewDelegate>
{
    NSInteger _offset;
    MJRefreshHeaderView * _header;
    MJRefreshFooterView * _footer;
    REINearbyView * _nearbyView;
}

@property(nonatomic, strong) REINearbyView * nearbyView;
@property(nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation REINearbyRootController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setupMainView
{
    _nearbyView = [REINearbyView nearbyView];
    _nearbyView.delegate = self;
    
}

-(NSMutableArray *)dataArray
{
    if(_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}






- (void)setupRequest
{
    
    [SVProgressHUD show];
    
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];

    //此处设置后返回的默认是NSData数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:[NSString stringWithFormat:self.urlStr, _offset, [REILocationUtil sharedLocationUtil].latitude, [REILocationUtil sharedLocationUtil].longitude] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError * error;
        if (error ) NSLog(@"%@",error);
        //将网络上传递的数据json数据转成数组
        NSLog(@"%@",[NSString stringWithFormat:self.urlStr, _offset, [REILocationUtil sharedLocationUtil].latitude, [REILocationUtil sharedLocationUtil].longitude]);
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        
        NSArray * array = dict[@"items"];
        for (NSDictionary * dict in array)
        {
            REINearbyItem * model = [REINearbyItem modelWithDict:dict];
            [self.dataArray addObject:model];
        }
        self.nearbyView.dataArray = self.dataArray;
        //结束菊花
        [SVProgressHUD dismiss];
        if (_offset == 0) {
            [_header endRefreshing];
        }else{
            [_footer endRefreshing];
        }
        [self.view addSubview:_nearbyView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@",error);
    }];
}

-(void) setupRefresh {
    _header = [MJRefreshHeaderView header];
    __block REINearbyRootController * controller = self;
    _header.scrollView = _nearbyView.tableView;
    _header.beginRefreshingBlock = ^(MJRefreshBaseView *view){
        _offset = 0;
        [controller setupRequest];
    };
    _footer = [MJRefreshFooterView footer];
    _footer.scrollView = _nearbyView.tableView;
    _footer.beginRefreshingBlock = ^(MJRefreshBaseView*view){
        _offset += 20;
        [controller setupRequest];
    };
}

#pragma mark 附近的代理方法实现

- (void)nearByView:(REINearbyView *)nearByView andDidSelectRowObj:(REINearbyItem *)obj
{
    REINearbyItem * item = obj;
    
    REIDesDetailController * detail = [[REIDesDetailController alloc]init];
    detail.idDes = item.idDes;
    
    NSString * path = [NSString stringWithFormat:@"%ld",item.type];
    detail.type  = path;
    detail.cover = item.cover;
    detail.cityName = item.name;
    detail.visited_count = item.visited_count;
    detail.wish_to_go_count = item.wish_to_go_count;
    REIMainNavigationController * detailNavControler = [[REIMainNavigationController alloc]initWithRootViewController:detail];
    [self presentViewController:detailNavControler animated:YES completion:nil];
    //_idDes	__NSCFNumber *	(long)2388363934	0xb0000008e5b8a9e3_cover	__NSCFString *	@"http://photos.breadtrip.com/photo_2013_04_14_af1a435d0b5a9e78c9172f3a2920c5dc.jpg?imageView/2/w/960/q/85"	0x00000001740f8680_idDes	__NSCFNumber *	(long)2388336615	0xb0000008e5b1fe73
}
@end
