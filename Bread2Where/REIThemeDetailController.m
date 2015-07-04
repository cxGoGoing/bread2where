//
//  REIThemeDetailController.m
//  Bread2Where
//
//  Created by qianfeng on 15-6-14.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIThemeDetailController.h"
#import "MMProgressHUD.h"
#import "HttpDownLoadBlock.h"
#import "REIThemeModel.h"
#import "REIThemeDetailFrameCell.h"
#import "MJExtension.h"
#import "REIThemeDetailModel.h"
#import "REIThemeDetailView.h"
#import "REIThemeArticleModel.h"

@interface REIThemeDetailController ()
@property(nonatomic, strong)REIThemeDetailView * tableView;
@end

@implementation REIThemeDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //创建页面
    [self createView];
    //请求数据
    [self sendRequestWithPage];
}

- (void)createView
{
    REIThemeDetailView * themeView = [REIThemeDetailView themeDetailViewCreate];
    [self.view addSubview:themeView];
    self.tableView = themeView;
    
}
- (void)sendRequestWithPage
{
    //开始转菊花
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleNone];
    [MMProgressHUD setOverlayMode:MMProgressHUDWindowOverlayModeNone];

    
    NSString * urlString = [NSString stringWithFormat:THEME_URL,_model.idDes];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dictTemp = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:dictTemp];
        if (dict[@"destination_id"] == [NSNull null]) {
            [dict setObject:[NSNumber numberWithInt:0] forKey:@"destination_id"];
        }
        //通过字典来创建模型
        REIThemeDetailModel * detailModel = [REIThemeDetailModel modelWithDict:dict];
        self.tableView.detailModel = detailModel;
        
        NSArray * articleArray = dict[@"article_sections"];
        NSMutableArray * mutableArray = [NSMutableArray array];
        
        NSMutableArray * titleArray = [NSMutableArray array];
        //通过字典数组来创建一个模型数组
        for (NSDictionary * dict in articleArray)
        {
            
            REIThemeArticleModel * mode  = [REIThemeArticleModel modelWithDict:dict];
            [titleArray addObject:mode];
            REIThemeDetailFrameCell * cellModel = [[REIThemeDetailFrameCell alloc]init];
            cellModel.articleModel = mode;
            [mutableArray addObject:cellModel];
        }
        
        self.tableView.titleArray = titleArray;
        self.tableView.mutableArray = mutableArray;
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"出错: %@",error);
        
    }];

    
    /*
    HttpDownLoadBlock * block = [[HttpDownLoadBlock alloc]initWithStrUrl:urlString Block:^(BOOL isOK, HttpDownLoadBlock * http) {
        if (isOK)
        {
            NSDictionary * dict = http.dataDic;
            if (dict[@"destination_id"] == [NSNull null]) {
                [dict setValue:0 forKey:@"destination_id"];
            }
            //通过字典来创建模型
            REIThemeDetailModel * detailModel = [REIThemeDetailModel modelWithDict:dict];
            self.tableView.detailModel = detailModel;
            
            NSArray * articleArray = dict[@"article_sections"];
            NSMutableArray * mutableArray = [NSMutableArray array];
            
            NSMutableArray * titleArray = [NSMutableArray array];
            //通过字典数组来创建一个模型数组
            for (NSDictionary * dict in articleArray)
            {
                
                REIThemeArticleModel * mode  = [REIThemeArticleModel modelWithDict:dict];
                [titleArray addObject:mode];
                REIThemeDetailFrameCell * cellModel = [[REIThemeDetailFrameCell alloc]init];
                cellModel.articleModel = mode;
                [mutableArray addObject:cellModel];
            }
          
            self.tableView.titleArray = titleArray;
            self.tableView.mutableArray = mutableArray;
       
        }
    }];
    */
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
}
@end
