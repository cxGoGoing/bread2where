//
//  GPrecommandDetailController.m
//  面包旅行
//
//  Created by qianfeng on 15-6-13.
//  Copyright (c) 2015年 李中飞. All rights reserved.
//

#import "GPrecommandDetailController.h"
#import "GPcellDetailModel.h"
#import "GPcellDetailWaypointsM.h"
#import "GPcellDetailCell.h"
#import "GPcellDetailFrameModel.h"
#import "GPrecommandDetailController.h"
#import "REIcellDertailController.h"
#import "SVProgressHUD.h"
@interface GPrecommandDetailController ()<UITableViewDataSource,UITableViewDelegate>
{
    UILabel * _label;
}

@property(nonatomic,strong)UITableView * cellDetailTableView;
/**
 *  存放GPcellDetailModel数据模型
 */
@property(nonatomic,strong)NSMutableArray * cellDetailArray;
/**
 *  存放cell模型
 */
@property(nonatomic,strong)NSMutableArray * cellModelArray;


@end

@implementation GPrecommandDetailController

-(void)setCellDetailArray:(NSMutableArray *)cellDetailArray
{
    _cellDetailArray=cellDetailArray;
    
    [self.cellDetailTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor clearColor];
    //创建tableView
    [self createTableView];
//    NSLog(@"_urlStringn :%@",_urlString);
    //请求数据
    [self requestData:_urlString];
}
/**
 *  创建tableView
 */
-(void)createTableView
{
    UITableView * cellDetailTableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.cellDetailTableView=cellDetailTableView;
    cellDetailTableView.dataSource=self;
    cellDetailTableView.delegate=self;
    cellDetailTableView.backgroundColor = [UIColor colorWithRed:250/255.0 green:246/255.0 blue:232/255.0 alpha:1.0];
    cellDetailTableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
//    cellDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:cellDetailTableView];
    
}
/**
 *  请求网络数据
 */
-(void)requestData:(NSString *)url
{
//    NSLog(@"url :%@",url);
    AFHTTPRequestOperationManager * manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [SVProgressHUD show];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *requestDict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        NSMutableArray * objsSection=[NSMutableArray array];
        
        NSArray * daysArray=requestDict[@"days"];
        
        /**
         *  days中得数据模型： "days": [
         {
         "date": "2015-01-25",
         "day": 1,
         "waypoints": [+]
         },
         {},
         {},
         ],
         */
        
        for(NSDictionary * dic in daysArray)
        {
            //objsRows存储每个section的所有数据
             NSMutableArray * objsRows=[NSMutableArray array];
            for(NSDictionary * wayPointDic in dic[@"waypoints"])
            {
                //算出来每个cell对应的数据的Frame，放入GPcellDetailFrameModel的属性中保存
                GPcellDetailFrameModel * cellDetailF=[GPcellDetailFrameModel cellDetailFrameModel];
                cellDetailF.cellDetailW=[GPcellDetailWaypointsM cellDetailWaypointsMWithDict:wayPointDic];
                //用数组保存每个cell的基本信息（各个控件数据、Frame、cell高度）
                [objsRows addObject:cellDetailF];
            }
            //把封装好的数据Frame模型直接放入到GPcellDetailModel的waypoints数组中并把每个section的头部显示内容放到GPcellDetailModel对应的属性中保存
            GPcellDetailModel * cellDetailM=[[GPcellDetailModel alloc]init];
            cellDetailM.waypoints=objsRows;
            cellDetailM.date=dic[@"date"];
            cellDetailM.day=[dic[@"day"] integerValue];
            
            [objsSection addObject:cellDetailM];
        }
        //cellDetailArray此数组存放的是tableView所有数据的集合（以数组形式），每个section是一个数组，即这个数组存放的是数组
        self.cellDetailArray=objsSection;
        [SVProgressHUD dismiss];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

    }];
}
#pragma mark -tableView的数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cellDetailArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    GPcellDetailModel * cellDetailM=self.cellDetailArray[section];
    return cellDetailM.waypoints.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GPcellDetailCell * cell=[GPcellDetailCell cellDetailCellWithTableView:tableView];
    /**
     *  设置cell中控件数据
     */
    GPcellDetailModel * cellDetailM=self.cellDetailArray[indexPath.section];
    cell.cellDetailF=cellDetailM.waypoints[indexPath.row];
    /**
     *  把有图片的cell存储起来
     */
    if (cell.photoImageView.frame.size.height!=0) {
        [self.cellModelArray addObject:cell];
    }
    
    
    return cell;
}
#pragma mark -tableView的代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GPcellDetailModel * cellDetailM=self.cellDetailArray[indexPath.section];
    GPcellDetailFrameModel * cellDetailF=cellDetailM.waypoints[indexPath.row];
    return cellDetailF.cellHeight;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    GPcellDetailModel * cellDetailM=self.cellDetailArray[section];
    NSString * headerString=[cellDetailM.date stringByAppendingString:[NSString stringWithFormat:@"  第%ld天",(long)cellDetailM.day]];
    
    UIView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
     if(headerView == nil) {
         headerView = [[UIView alloc]init];
         _label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 20)];
     }
                             
    NSString * headerContent = headerString;
    
    headerView = [self makeHeaderViewLabelWithView:headerView andContent:headerContent];

    return headerView;
}



-(UIView *) makeHeaderViewLabelWithView:(UIView *)headerView andContent:(NSString *)content
{
    _label.font = [UIFont boldSystemFontOfSize:14];
    _label.textAlignment = NSTextAlignmentLeft;
    _label.textColor = [UIColor colorWithRed:42/255.0 green:156/255.0 blue:173/255.0 alpha:1];
    _label.text = content;
    [headerView addSubview:_label];
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}



/**
 *  点击cell之后回调到图片轮播器所在的界面，如果这个cell没有图片则跳到轮播器界面之后默认从第一张显示轮播的第一张图片
 *
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger indexCount = 0;
    REIcellDertailController * cellDetailC=[[REIcellDertailController alloc]init];
    /**
     *  此部获取索引
     */
    //判断单击的cell有无图片，没有的话传递索引为0
    GPcellDetailModel * cellDetailM=self.cellDetailArray[indexPath.section];
    GPcellDetailFrameModel * cellDetailFrame=cellDetailM.waypoints[indexPath.row];
    //如果这个cell有图片
    if (cellDetailFrame.photoF.size.height) {
        //算出这个cell是在存放有图片cell数组中得索引
        //第一个for循环是算出这个cell所在的组之前的所有组中有图片的cell的总得个数
        for (int i=0; i<indexPath.section; i++) {
            
            GPcellDetailModel * cellDetailM1=self.cellDetailArray[i];
            for (GPcellDetailFrameModel * cellDetailF in cellDetailM1.waypoints) {
                if (cellDetailF.photoF.size.height!=0) {
                    indexCount++;
                }
            }
            //            indexCount=indexCount+cellDetailM.waypoints.count;
        }
        //这个cell是所在的组的第几个cell
        GPcellDetailModel * cellDetailM2=self.cellDetailArray[indexPath.section];
        for (int j=0; j<indexPath.row; j++) {
            GPcellDetailFrameModel * cellDetailF=cellDetailM2.waypoints[j];
            if (cellDetailF.photoF.size.height!=0) {
                indexCount++;
            }
        }
    }else
    {
        indexCount=0;
    }
    
    //传递所有数据
    cellDetailC.cellDetailArray=self.cellDetailArray;
    
    //传递索引试试
    cellDetailC.index = indexCount;
    [self presentViewController:cellDetailC animated:YES completion:nil];
}


-(void)viewWillAppear:(BOOL)ansimated
{
    [super viewWillAppear:YES];
    REIBaseFooter * footer = [REIBaseFooter baseFooter];
    footer.hidden = YES;
}
/**
 *  这个界面的将要销毁时候显示tabBar
 *
 *  @param animated
 */
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    REIBaseFooter * footer = [REIBaseFooter baseFooter];
    footer.hidden = NO;
    [SVProgressHUD dismiss];
}

-(void)dealloc{
    
}
@end
