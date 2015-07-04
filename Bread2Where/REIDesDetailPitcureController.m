//
//  REIDesDetailPitcureController.m
//  Bread2Where
//
//  Created by qianfeng on 15-6-15.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIDesDetailPitcureController.h"
#import "REICityDetailModel.h"
#import "UMSocial.h"
@interface REIDesDetailPitcureController ()<UIScrollViewDelegate, SDWebImageManagerDelegate>
{
    UIButton * _shareBtn;
}
@property(nonatomic,strong)UIScrollView * scrollow;

@property(nonatomic,strong)UILabel * indexLab;

@property(nonatomic,strong) UIImage * shareImage;
@property(nonatomic,assign) NSInteger imageIndex;
@property(nonatomic,assign) BOOL isok;

@end

@implementation REIDesDetailPitcureController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor blackColor];
    
    //创建createScrollowView
    [self createScrollowView];
    _imageIndex = _itemIndex;
    [self downloadImage];
    
    SDWebImageManager * webImageManager = [SDWebImageManager sharedManager];
    webImageManager.delegate = self;
    
    //创建返回按钮
    [self createTopSubviews];
    //设置scrollow的偏移量
    [self setScrollowContentOffSet];
}



/**
 *  设置scrollow的偏移量，即一显示这个界面就跳到单击cell中得那张图片
 */
-(void)setScrollowContentOffSet
{
    _imageIndex = _itemIndex;
    //给图片索引指示Lab设置值
    self.indexLab.text=[NSString stringWithFormat:@"%ld/%lu",(long)_itemIndex+1,(unsigned long)self.desDetailPitcureArray.count];
    //设置scrollow的偏移量
    self.scrollow.contentOffset=CGPointMake(self.itemIndex *MAIN_SCREEN_WIDTH, 0);
}

/**
 *  创建返回按钮和图片索引指示Lab、分享按钮
 */
-(void)createTopSubviews
{
    //创建返回按钮
    UIButton * backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(25, 25, 25, 25);
    [self.view addSubview:backBtn];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"icon_nav_back_button"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"nav-bar-lovingzone-back-btn"] forState:UIControlStateSelected];
    [backBtn addTarget:self action:@selector(backBtnTouch) forControlEvents:UIControlEventTouchUpInside];
    //图片索引指示Lab
    UILabel * indexLab=[[UILabel alloc]initWithFrame:CGRectMake((MAIN_SCREEN_WIDTH-150)*0.5, 25, 150, 25)];
    self.indexLab=indexLab;
    [self.view addSubview:indexLab];
    indexLab.textColor=[UIColor whiteColor];
    indexLab.textAlignment=NSTextAlignmentCenter;
    indexLab.font=[UIFont systemFontOfSize:15];
    
    //创建分享按钮
    _shareBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _shareBtn.frame=CGRectMake(MAIN_SCREEN_WIDTH-65, 25,40,25);
    [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [_shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_shareBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    _shareBtn.titleLabel.font = [UIFont fontWithName:Arial_BoldItalicMT size:15];
    _shareBtn.hidden = NO;
    
    [_shareBtn addTarget:self action:@selector(shareBtnTouch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_shareBtn];


}

-(void)shareBtnTouch
{
    /**
     *  在这里添加友盟分享的代码
     *
     */

    REICityDetailModel * cityDetailM=self.desDetailPitcureArray[_imageIndex];
    NSString * shareText = cityDetailM.name;
  
 

//    if (self.isok) {
//       
//        [_shareBtn setNeedsDisplay];
//    }

    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:UMENG_SHARE_APPID
                                      shareText:shareText
                                     shareImage:_shareImage
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToDouban,UMShareToEmail,UMShareToSms,nil]
                                       delegate:nil];
    
}


 //   GCD在后台加载数据。在刷新 UI 界面
-(void) downloadImage {
#warning 分享图片出现卡顿
    
    _shareBtn.hidden = YES;
    REICityDetailModel * cityDetailM=self.desDetailPitcureArray[_imageIndex];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        //  异步
        UIImage * shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:cityDetailM.photo]]];
        // 刷新ui
        dispatch_async(dispatch_get_main_queue(), ^{
            //            NSLog(@"数据＝%@",dic );
            self.shareImage = shareImage;
            //            self.isok = YES;
            _shareBtn.hidden = NO;
            [self.view setNeedsDisplay];
        });
    });

}



/**
 *  返回按钮
 */
-(void)backBtnTouch
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  创建createScrollowView
 */
-(void)createScrollowView
{
//    /**
//     先解析出来这个数组中存了多少张图片
//     */
//    NSMutableArray * objs=[NSMutableArray array];
//    for (GPcellDetailModel * cellDetailM in self.cellDetailArray) {
//        for (GPcellDetailFrameModel * cellDetailF in cellDetailM.waypoints) {
//            
//            if (cellDetailF
//                .photoF.size.height) {
//                //把GPcellDetailModel存储是第几天的变量搞出来放到GPcellDetailWaypointsM的dayCount属性中，以便在下面的数组中存储的GPcellDetailWaypointsM对象中引用
//                cellDetailF.cellDetailW.dayCount=cellDetailM.day;
//                //把存放数据的模型放到数组中
//                [objs addObject:cellDetailF.cellDetailW];
//            }
//        }
//    }
//    self.dataModelArray=objs;
    
    UIScrollView * scrollow=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.scrollow=scrollow;
    [self.view addSubview:scrollow];
    scrollow.showsHorizontalScrollIndicator=NO;
    scrollow.showsVerticalScrollIndicator=NO;
    //设置contentSize
    scrollow.contentSize=CGSizeMake(MAIN_SCREEN_WIDTH*(self.desDetailPitcureArray.count), 0);
    //支持分页
    scrollow.pagingEnabled=YES;
    //设置代理
    scrollow.delegate=self;
    
    [self createScrollowSubviews];
    
}
/**
 *  创建scrollow里面的imageView显示图片
 */
-(void)createScrollowSubviews
{
    CGFloat imageW =MAIN_SCREEN_WIDTH;
    
    for (int i = 0; i<self.desDetailPitcureArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        
        REICityDetailModel * cityDetailM=self.desDetailPitcureArray[i];
        CGFloat imageH = 200;
        CGFloat imageY = (self.view.bounds.size.height-imageH)*0.5;
        // 设置frame
        CGFloat imageX = i * imageW;
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
        imageView.userInteractionEnabled=YES;
        imageView.tag=i+1;
        [imageView sd_setImageWithURL:[NSURL URLWithString:cityDetailM.photo] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        } usingProgressView:nil];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.scrollow addSubview:imageView];

    }
    
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self downloadImage];
}

#pragma mark -UIScrollViewDelegate的代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    

    //获得scrollow的偏移量
    CGFloat scrollowOffSetX=scrollView.contentOffset.x;
    _imageIndex=(scrollowOffSetX+MAIN_SCREEN_WIDTH*0.5)/MAIN_SCREEN_WIDTH;
//    REICityDetailModel * model = self.desDetailPitcureArray[_imageIndex - 1];
/*
    SDWebImageManager * manager = [SDWebImageManager sharedManager];
    BOOL cachedImage = [manager cachedImageExistsForURL:[NSURL URLWithString:model.photo]]; 
    // 刷新ui

    if (cachedImage) {
        _shareBtn.hidden = NO;

        [self.view setNeedsDisplay];
    }
*/

    
    //给图片索引指示Lab设置值
    if (_imageIndex>0 && _imageIndex<self.desDetailPitcureArray.count) {
        self.indexLab.text=[NSString stringWithFormat:@"%ld/%lu",(long)_imageIndex+1,(unsigned long)self.desDetailPitcureArray.count];
    }else if (_imageIndex==0)
    {
        self.indexLab.text=[NSString stringWithFormat:@"%d/%lu",1,(unsigned long)self.desDetailPitcureArray.count];
    }
}


@end
