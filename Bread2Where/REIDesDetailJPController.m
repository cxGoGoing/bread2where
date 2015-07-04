//
//  REIDesDetailJPController.m
//  Bread2Where
//
//  Created by qianfeng on 15-6-16.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIDesDetailJPController.h"
#import "HttpRequestBlock.h"
#import "REIDestDetailJPModel.h"
#import "REIDesDetailJPView.h"
#import "GPrecommandDetailController.h"


@interface REIDesDetailJPController ()<REIDesDetailJPViewDelegate>
@property (nonatomic, strong) REIDesDetailJPView *tableView;
@end

@implementation REIDesDetailJPController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建VIWE
    [self createView];
    self.view.backgroundColor =  [UIColor colorWithRed:0.98 green:0.97 blue:0.93 alpha:1];
    self.navigationItem.title = @"精品游记";
    //请求数据
    [self sendRequestWithPage:0 andPageNumber:20];
    
//    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
//    button.backgroundColor = [UIColor redColor];
//    [button addTarget:self action:@selector(btn) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
//    [self.view addSubview:button];
  
    //创建返回按钮
    [self createBackButton];
}

-(void)createBackButton
{
    UIButton * backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(0, 0, 25, 25);
    [self.view addSubview:backBtn];
    [backBtn setImage:[UIImage imageNamed:@"icon_nav_back_button"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"nav-bar-lovingzone-back-btn"] forState:UIControlStateSelected];
    [backBtn addTarget:self action:@selector(backBtnTcouch) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:backBtn];
    
    UIView * barView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [barView addSubview:backBtn];
    
    UIBarButtonItem * item=[[UIBarButtonItem alloc]initWithCustomView:barView];
    self.navigationItem.leftBarButtonItem=item;
}

-(void)backBtnTcouch
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//- (void)btn
//{
//    [self.navigationController popViewControllerAnimated:YES];
////    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//}
- ( void)createView
{
    REIDesDetailJPView * JPView = [REIDesDetailJPView desDetailJPView];
    self.tableView = JPView;
    JPView.delegate = self;
    [self.view addSubview:JPView];

}

- (void)sendRequestWithPage:(int)status andPageNumber:(int)pageNumber
{
    NSString *path =[NSString stringWithFormat:TRAVEL_DAILY,_type,_idDes,pageNumber];
    
   /*
    HttpRequestBlock * block = [[HttpRequestBlock alloc]initWithUrlPath:path Block:^(BOOL isOK, HttpRequestBlock * http) {
        if (isOK) {

        NSMutableArray * itemMutableArray = [NSMutableArray array];
        for (NSDictionary * dict in itemArray)
        {

            REIDestDetailJPModel * JPModle = [REIDestDetailJPModel  DestDetailJPModelWithDict:dict];
            [itemMutableArray addObject:JPModle];
        }
        self.tableView.sectionArray = itemMutableArray;
        }
    }];
    */
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *requestDict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        
        
        //取出数据对应的数组
        NSArray * itemArray = requestDict[@"items"];
        
        NSMutableArray * itemMutableArray = [NSMutableArray array];
        for (NSDictionary * dict in itemArray)
        {
            
            REIDestDetailJPModel * JPModle = [REIDestDetailJPModel  DestDetailJPModelWithDict:dict];
            [itemMutableArray addObject:JPModle];
        }
        self.tableView.sectionArray = itemMutableArray;
    
        

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"出错: %@",error);
        
    }];

}

#pragma mark 刷新数据代理实现
- (void)themeviewRefresh:(REIThemeViewRefresh)status andPage:(int)page
{
    [self sendRequestWithPage:status andPageNumber:page];
}

#warning 需要接口
#pragma mark 点击cell代理
- (void)themeViewDidSelect:(REIDesDetailJPView *)themeView andObj:(id)obj
{
    
    GPrecommandDetailController * recommandDetail = [[GPrecommandDetailController alloc]init];
    REIDestDetailJPModel * model = obj;
    recommandDetail.urlString = [NSString stringWithFormat:SHOUYECELLDETAIL,model.idDes];
    recommandDetail.navigationItem.title = model.name;
    [self.navigationController pushViewController:recommandDetail animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
