//
//  GPspecialController.m
//  面包旅行
//
//  Created by qianfeng on 15-6-9.
//  Copyright (c) 2015年 李中飞. All rights reserved.
//

#import "GPspecialController.h"
#import "GPspecialViewCell.h"
#import "GPspecialProductModel.h"
#import "GPimageViewTouchController.h"
#import "DOPDropDownMenu.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"

typedef enum specialRefresh
{
    specialRefreshTypeHeaderView,
    specialRefreshTypeFooterView
    
}specialRefreshType;
@interface GPspecialController ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate,DOPDropDownMenuDataSource,DOPDropDownMenuDelegate>


@property(nonatomic,strong)NSMutableArray * cellDataArray;

@property(nonatomic,strong)MJRefreshHeaderView * headerView;

@property(nonatomic,strong)MJRefreshFooterView * footerView;

@property(nonatomic,strong)UITableView * tableView;

/**
 *  添加特价上面的那个条
 */
@property (nonatomic, strong) NSArray *classifys;
@property (nonatomic, strong) NSArray *cates;
@property (nonatomic, strong) NSArray *movices;
@property (nonatomic, strong) NSArray *hostels;
@property (nonatomic, strong) NSArray *areas;

@property (nonatomic, strong) NSArray *sorts;

@end

@implementation GPspecialController

-(void)setCellDataArray:(NSMutableArray *)cellDataArray
{
    _cellDataArray=cellDataArray;
    
    //使正在加载数据和菊花消失
    [_footerView endRefreshing];
    [_headerView endRefreshing];
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //添加特价上面的选择条
//    [self createTopBar];
    
    //创建tableView
    [self createTableView];
    //创建刷新
    [self createTableViewRefresh];
    self.navigationItem.title = @"特价";
    //请求网络数据
    [self requestData:[NSString stringWithFormat:SPECIALPRICE,1] andspecialRefreshType:specialRefreshTypeHeaderView];
    
}
/**
 *  添加TopBar
 */
-(void)createTopBar
{
    // 数据
    self.classifys = @[@"美食",@"今日新单",@"电影",@"酒店"];
    self.cates = @[@"自助餐",@"快餐",@"火锅",@"日韩料理",@"西餐",@"烧烤小吃"];
    self.movices = @[@"内地剧",@"港台剧",@"英美剧"];
    self.hostels = @[@"经济酒店",@"商务酒店",@"连锁酒店",@"度假酒店",@"公寓酒店"];
    self.areas = @[@"全城",@"芙蓉区",@"雨花区",@"天心区",@"开福区",@"岳麓区"];
    self.sorts = @[@"默认排序",@"离我最近",@"好评优先",@"人气优先",@"最新发布"];
    
    // 添加下拉菜单
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:44];
    
    menu.delegate = self;
    menu.dataSource = self;
    [self.view addSubview:menu];
}
/**
 请求网络数据
 */
-(void)requestData:(NSString *)url andspecialRefreshType:(specialRefreshType)specialRefresh
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [SVProgressHUD show];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *requestDict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:nil error:nil];
        

        //取出数据对应的数组
        NSArray * productsArray = requestDict[@"products"];
        
        if (specialRefresh==specialRefreshTypeFooterView) {
            

            //先把之前的数据保存起来，然后再把新加载的数据拼接上
            NSMutableArray * tempArray=[NSMutableArray arrayWithArray:self.cellDataArray];
            [tempArray addObjectsFromArray:[GPspecialProductModel objectArrayWithKeyValuesArray:productsArray]];
            self.cellDataArray=tempArray;
            
        }
        else
        {
            self.cellDataArray=[GPspecialProductModel objectArrayWithKeyValuesArray:productsArray];
        }

        [SVProgressHUD dismiss];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        NSLog(@"出错: %@",error);
        
    }];
}
/**
 *  创建tableView
 */
-(void)createTableView
{
    UITableView * tableView=[[UITableView alloc]initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, MAIN_SCREEN_WIDTH, self.view.bounds.size.height) style:UITableViewStylePlain];
    self.tableView=tableView;
    tableView.contentInset=UIEdgeInsetsMake(0, 0, 80, 0);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.view addSubview:tableView];
    
    tableView.dataSource=self;
    tableView.delegate=self;
}

-(void)createTableViewRefresh
{
    //上拉
    MJRefreshHeaderView * headerView=[MJRefreshHeaderView header];
    headerView.scrollView=_tableView;
    headerView.delegate=self;
    self.headerView=headerView;
    
    //下拉
    MJRefreshFooterView * footerView=[MJRefreshFooterView footer];
    footerView.scrollView=_tableView;
    footerView.delegate=self;
    self.footerView=footerView;
}

#pragma mark -tableView的数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //每页9个
    return self.cellDataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GPspecialViewCell * cell=[GPspecialViewCell specialViewCell:tableView];
    
    cell.specialProductM=self.cellDataArray[indexPath.row];
    
    return cell;
}
#pragma mark -代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 137;
}
#pragma mark -MJRefreshBaseViewDelegate的代理方法
/**
 *  上下拉刷新调用
 */
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([refreshView isKindOfClass:[MJRefreshHeaderView class]]) {
        NSLog(@"上拉刷新！");
        //执行操作
        [self requestData:[NSString stringWithFormat:SPECIALPRICE,1] andspecialRefreshType:specialRefreshTypeHeaderView];
    }
    else
    {
        NSLog(@"下拉刷新！");
        //执行操作
        NSInteger currentPage=self.cellDataArray.count/9;
        [self requestData:[NSString stringWithFormat:SPECIALPRICE,(int)currentPage+1] andspecialRefreshType:specialRefreshTypeFooterView];
    }
}
-(void)dealloc
{
    [_footerView free];
    [_headerView free];
}
/**
 *  单击cell的详情
 *
 *  @param tableView
 *  @param indexPath
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GPspecialProductModel * specialProductM=self.cellDataArray[indexPath.row];
    GPimageViewTouchController * specialCellDetail=[[GPimageViewTouchController alloc]init];
    specialCellDetail.navTitle = specialProductM.title;
    specialCellDetail.url = specialProductM.url;
    
    [self.navigationController pushViewController:specialCellDetail animated:YES];
}
#pragma mark -DOPDropDownMenuDataSource和DOPDropDownMenuDelegate方法
/**
 *  多少列
 */
- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu
{
    return 3;
}
/**
 *  每列有多少行
 */
- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
    if (column == 0) {
        return self.classifys.count;
    }else if (column == 1){
        return self.areas.count;
    }else {
        return self.sorts.count;
    }
}
/**
 *  每行显示的内容
 */
- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        return self.classifys[indexPath.row];
    } else if (indexPath.column == 1){
        return self.areas[indexPath.row];
    } else {
        return self.sorts[indexPath.row];
    }
}
/**
 *  每列中每行下的子条目数量
 */
- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfItemsInRow:(NSInteger)row column:(NSInteger)column
{
    if (column == 0) {
        if (row == 0) {
            return self.cates.count;
        } else if (row == 2){
            return self.movices.count;
        } else if (row == 3){
            return self.hostels.count;
        }
    }
    return 0;
}
/**
 *  每列中每行下的子条目内容（汉字）
 */
- (NSString *)menu:(DOPDropDownMenu *)menu titleForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        if (indexPath.row == 0) {
            return self.cates[indexPath.item];
        } else if (indexPath.row == 2){
            return self.movices[indexPath.item];
        } else if (indexPath.row == 3){
            return self.hostels[indexPath.item];
        }
    }
    return nil;
}
/**
 *  单击某项并打印出来索引
 */
- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.item >= 0) {
        NSLog(@"点击了 %ld - %ld - %ld 项目",indexPath.column,indexPath.row,indexPath.item);
    }else {
        NSLog(@"点击了 %ld - %ld 项目",indexPath.column,indexPath.row);
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [SVProgressHUD dismiss];
}

@end
