//
//  REIcellDertailController.m
//  Bread2Where
//
//  Created by qianfeng on 15-6-14.
//  Copyright (c) 2015年 FEI. All rights reserved.
//
#define LIDateFont [UIFont systemFontOfSize:12]
#import "REIcellDertailController.h"
#import "UIImageView+WebCache.h"
#import "GPcellDetailModel.h"
#import "GPcellDetailFrameModel.h"
#import "GPcellDetailWaypointsM.h"
#import "REIBaseFooter.h"
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
@interface REIcellDertailController ()<UIScrollViewDelegate,UIActionSheetDelegate,UMSocialUIDelegate,SDWebImageManagerDelegate>
{
    UIView *_firstView;
    UIView *_secondView;
    UIView *_thirdView;
    int _count;
    int _currentType;
    BOOL _isDecelerating;
    UIButton *  _shareBtn;
    NSInteger token;

}
@property(nonatomic,strong)UIScrollView * scrollow;
@property(nonatomic,assign) BOOL cachedImage;
@property(nonatomic,strong)UILabel * indexLab;
@property(nonatomic,strong)UIImage * shareImage;
- (void)createIndexView;
- (void)creatFirstView;
- (void)creatLastView;
@end

@implementation REIcellDertailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor blackColor];
    
    SDWebImageManager * webImageManager = [SDWebImageManager sharedManager];
    webImageManager.delegate = self;
    
    //创建createScrollowView
    [self createScrollowView];
//    [self downloadImage];
    
    //创建返回按钮
    [self createTopSubviews];
//    设置scrollow的偏移量
//    [self setScrollowContentOffSet];
    
    [self creatFirstView];
//    if(_index == 0) {
//        _currentType = 0;
//    } else if (_index == self.dataModelArray.count - 1) {
//        _currentType = 1;
//    } else {
//        _currentType = 2;
//    }
    if (_index == self.dataModelArray.count - 2) {
        _index = _index + 1;
        _currentType = 2;
    }
}
/**
 *  设置scrollow的偏移量，即一显示这个界面就跳到单击cell中得那张图片
 */
//-(void)setScrollowContentOffSet
//{
//    //给图片索引指示Lab设置值
//    GPcellDetailWaypointsM * cellDetailWay=self.dataModelArray[_index];
//    self.indexLab.text=[NSString stringWithFormat:@"第%ld天 %ld/%lu",(long)cellDetailWay.dayCount,(long)_index+1,(unsigned long)self.dataModelArray.count];
//    //设置scrollow的偏移量
//    self.scrollow.contentOffset=CGPointMake(_index *MAIN_SCREEN_WIDTH, 0);
//}
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
    UILabel * indexLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 25, 150, 25)];
    indexLab.centerX = MAIN_SCREEN_WIDTH * 0.5;
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
/**
 *  分享按钮实现
 *
 *  @return
 */
-(void)shareBtnTouch
{
    /**
     *  在这里添加友盟分享的代码
     *
     */
    GPcellDetailWaypointsM * dataModel = self.dataModelArray[_index];
    NSString * shareText = dataModel.text;
    #warning 分享图片出现卡顿
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:UMENG_SHARE_APPID
                                      shareText:shareText
                                     shareImage:self.shareImage
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToDouban,UMShareToEmail,UMShareToSms,nil]
                                       delegate:nil];

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
    /**
     先解析出来这个数组中存了多少张图片
     */
    NSMutableArray * objs=[NSMutableArray array];
    for (GPcellDetailModel * cellDetailM in self.cellDetailArray) {
        for (GPcellDetailFrameModel * cellDetailF in cellDetailM.waypoints) {
            
            if (cellDetailF
                .photoF.size.height) {
                //把GPcellDetailModel存储是第几天的变量搞出来放到GPcellDetailWaypointsM的dayCount属性中，以便在下面的数组中存储的GPcellDetailWaypointsM对象中引用
                cellDetailF.cellDetailW.dayCount=cellDetailM.day;
                //把存放数据的模型放到数组中
                [objs addObject:cellDetailF.cellDetailW];
            }
        }
    }
    self.dataModelArray=objs;
    
    UIScrollView * scrollow=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.scrollow=scrollow;
    [self.view addSubview:scrollow];
    scrollow.showsHorizontalScrollIndicator=NO;
    scrollow.showsVerticalScrollIndicator=NO;
    //设置contentSize
    scrollow.contentSize=CGSizeMake(MAIN_SCREEN_WIDTH*3, 0);
    //支持分页
    scrollow.pagingEnabled=YES;
    //设置代理
    scrollow.delegate=self;
    
//    [self createScrollowSubviews];
    
}


//计算文字尺寸
-(CGSize)setNameFontSize:(NSString *)text andFont:(UIFont *)font andMaxSize:(CGSize)maxSize
{
    NSDictionary * atts=@{NSFontAttributeName:font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:atts context:nil].size;
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat pageWidth = scrollView.frame.size.width;
    int pageIndex = floor((scrollView.contentOffset.x - pageWidth/2)/pageWidth) + 1;
    
    switch (_currentType) {
        case 0:
        {
            _index = _index + pageIndex;
            if (pageIndex == 1) {
                [self createIndexView];
            }
            break;
        }
        case 1:
        {
            _index = _index + pageIndex - 1;
            if (pageIndex == 0) {
                [self createIndexView];
            }
            break;
        }
        case 2:
        {
            _index = _index + pageIndex - 1;
            if (_index == 0) {
                [self creatFirstView];
            }else if (_index == self.dataModelArray.count - 1){
                [self creatLastView];
            }else{
                [self createIndexView];
            }
            break;
        }
        default:
            break;
    }

    scrollView.userInteractionEnabled = YES;
}

/**
 *  创建scrollow里面的imageView显示图片
 */
//-(void)createScrollowSubviews
//{
//    CGFloat imageW = MAIN_SCREEN_WIDTH;
//    
//    for (int i = 0; i<self.dataModelArray.count; i++) {
//        UIImageView *imageView = [[UIImageView alloc] init];
//
//        GPcellDetailWaypointsM * cellDetailWay=self.dataModelArray[i];
//        CGFloat imageH = cellDetailWay.photo_H;
//        CGFloat imageY = (self.view.bounds.size.height-imageH)*0.5;
//        // 设置frame
//        CGFloat imageX = i * imageW;
//        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
//        imageView.userInteractionEnabled=YES;
//        
//        [imageView sd_setImageWithURL:[NSURL URLWithString:cellDetailWay.photo]];
//
//        [self.scrollow addSubview:imageView];
//        
//        //创建UIUITextView
//        UITextView * textView=[[UITextView alloc]initWithFrame:CGRectMake(imageX, self.scrollow.frame.size.height-130, MAIN_SCREEN_WIDTH, 80)];
//        textView.editable = NO;
//        [self.scrollow addSubview:textView];
//        textView.backgroundColor=[UIColor clearColor];
//        textView.text=cellDetailWay.text;
//        textView.textColor=[UIColor whiteColor];
//        textView.font=[UIFont systemFontOfSize:12];
//        
//        //创建下面的时钟图标
//        UIImageView * clockView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"clock_gray"]];
//        clockView.frame=CGRectMake(textView.frame.origin.x, CGRectGetMaxY(textView.frame), 13, 13);
//        [self.scrollow addSubview:clockView];
//        //创建日期Lab
//        CGSize  dateSize=[self setNameFontSize:cellDetailWay.local_time andFont:LIDateFont andMaxSize:CGSizeMake(MAIN_SCREEN_WIDTH-13, 13)];
//        UILabel * dateLab=[[UILabel alloc]initWithFrame:CGRectMake(imageX+13, CGRectGetMaxY(textView.frame),dateSize.width, 13)];
//        dateLab.textColor=[UIColor whiteColor];
//        dateLab.text=cellDetailWay.local_time;
//        dateLab.font=LIDateFont;
//        [self.scrollow addSubview:dateLab];
////        创建索引提示信息  (最开始在这创建的)
////        UILabel * indexLab=[[UILabel alloc]initWithFrame:CGRectMake((MAIN_SCREEN_WIDTH*i)+(MAIN_SCREEN_WIDTH-150)*0.5, 25, 150, 25)];
////        self.indexLab=indexLab;
////        [self.scrollow addSubview:indexLab];
////        indexLab.text=[NSString stringWithFormat:@"第%ld天 %d/%lu",(long)cellDetailWay.dayCount,i+1,(unsigned long)self.dataModelArray.count];
////        indexLab.textColor=[UIColor whiteColor];
////        indexLab.textAlignment=NSTextAlignmentCenter;
////        indexLab.font=[UIFont systemFontOfSize:15];
//        
//    }
//    
//
//}

/*失效
- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image
{
    self.shareImage = image;
    //此处加上你的代码；
}
*/

#pragma mark -UIScrollViewDelegate的代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _shareBtn.hidden = YES;
    
    GPcellDetailWaypointsM * cellDetailWay=self.dataModelArray[_index];

    SDWebImageManager * manager = [SDWebImageManager sharedManager];
    BOOL cachedImage = [manager cachedImageExistsForURL:[NSURL URLWithString:cellDetailWay.photo]];
    if (cachedImage) {
        _shareBtn.hidden = NO;
        
        [self.view setNeedsDisplay];
    }
        
    if (_index>0 && _index<self.dataModelArray.count) {
        self.indexLab.text=[NSString stringWithFormat:@"第%ld天 %ld/%lu",(long)cellDetailWay.dayCount,(long)_index+1,(unsigned long)self.dataModelArray.count];
    }else if (_index==0)
    {
        self.indexLab.text=[NSString stringWithFormat:@"第%ld天 %d/%lu",(long)cellDetailWay.dayCount,1,(unsigned long)self.dataModelArray.count];
        
    }
    self.indexLab.font = [UIFont fontWithName:Arial_BoldItalicMT size:17];
}

/*
- (void) threadForShare {
    //获取图片是属于第几天的
    GPcellDetailWaypointsM * cellDetailWay=self.dataModelArray[_index];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        //  异步
        SDWebImageManager * manager = [SDWebImageManager sharedManager];
        BOOL cachedImage = [manager cachedImageExistsForURL:[NSURL URLWithString:cellDetailWay.photo]];
        
        // 刷新ui
        dispatch_async(dispatch_get_main_queue(), ^{
            self.cachedImage = cachedImage;

                _shareBtn.hidden = NO;
                
                [self.view setNeedsDisplay];

        });
    });
}
*/
 
/**
 *  将进入这个界面的时候隐藏tabBar
 *
 *  @param animated
 */
-(void)viewWillAppear:(BOOL)animated
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

- (void)createIndexView{
    [_firstView removeFromSuperview];
    [_secondView removeFromSuperview];
    [_thirdView removeFromSuperview];
    
    _firstView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)];
    [_scrollow addSubview:_firstView];
    token = _index - 1;
    [self setFrameWithModel:self.dataModelArray[token] forView:_firstView];
    
    token = _index;
    _secondView = [[UIView alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)];
    [_scrollow addSubview:_secondView];
    [self setFrameWithModel:self.dataModelArray[token] forView:_secondView];
    
    token = _index + 1;
    _thirdView = [[UIView alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH*2, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)];
    [_scrollow addSubview:_thirdView];
    [self setFrameWithModel:self.dataModelArray[token] forView:_thirdView];
    
    [_scrollow scrollRectToVisible:CGRectMake(MAIN_SCREEN_WIDTH, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT) animated:NO];
    _scrollow.contentSize = CGSizeMake(MAIN_SCREEN_WIDTH*3, MAIN_SCREEN_HEIGHT);
    _currentType = 2;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    scrollView.userInteractionEnabled = NO;
}

- (void)creatFirstView{
    [_firstView removeFromSuperview];
    [_secondView removeFromSuperview];
    [_thirdView removeFromSuperview];
    
    _firstView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)];
    [_scrollow addSubview:_firstView];
    
    token = _index;
    [self setFrameWithModel:self.dataModelArray[token]  forView:_firstView];
    
    _secondView = [[UIView alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)];
    [_scrollow addSubview:_secondView];
    token = _index + 1;
    [self setFrameWithModel:self.dataModelArray[token] forView:_secondView];

    _scrollow.contentSize = CGSizeMake(MAIN_SCREEN_WIDTH*2, MAIN_SCREEN_HEIGHT);
    [_scrollow scrollRectToVisible:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT) animated:NO];
    _currentType = 0;
}


- (void)creatLastView{
    [_firstView removeFromSuperview];
    [_secondView removeFromSuperview];
    [_thirdView removeFromSuperview];
    
    _firstView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)];
    [_scrollow addSubview:_firstView];
    
    token = _index - 1;
    [self setFrameWithModel:self.dataModelArray[token] forView:_firstView];
    
    _secondView = [[UIView alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)];
    [_scrollow addSubview:_secondView];
    
    token = _index;
    [self setFrameWithModel:self.dataModelArray[token] forView:_secondView];
    _scrollow.contentSize = CGSizeMake(MAIN_SCREEN_WIDTH*2, MAIN_SCREEN_HEIGHT);
    [_scrollow scrollRectToVisible:CGRectMake(MAIN_SCREEN_WIDTH, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT) animated:NO];
    _currentType = 1;
}


-(void) setFrameWithModel:(GPcellDetailWaypointsM *
)cellDetailWay forView:(UIView *)view
{

    CGFloat imageH = cellDetailWay.photo_H;
    CGFloat imageY = (MAIN_SCREEN_HEIGHT-imageH)*0.5;
    // 设置frame
    CGFloat imageX = 0;
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(imageX, imageY, MAIN_SCREEN_WIDTH, imageH);
    imageView.userInteractionEnabled=YES;
    [imageView sd_setImageWithURL:[NSURL URLWithString:cellDetailWay.photo] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (_index == token) {
            self.shareImage = image;
        }
        
    } usingProgressView:nil];
    
    [view addSubview:imageView];

    //创建UIUITextView
    UITextView * textView=[[UITextView alloc]initWithFrame:CGRectMake(imageX, self.scrollow.frame.size.height-130, MAIN_SCREEN_WIDTH, 80)];
    textView.editable = NO;
    [view addSubview:textView];
    textView.backgroundColor=[UIColor clearColor];
    textView.text=cellDetailWay.text;
    textView.textColor=[UIColor whiteColor];
    textView.font=[UIFont systemFontOfSize:12];

    
    //创建下面的时钟图标
    UIImageView * clockView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"clock_gray"]];
    clockView.frame=CGRectMake(textView.frame.origin.x + 8, CGRectGetMaxY(textView.frame), 13, 13);
    [view addSubview:clockView];
    //创建日期Lab
    CGSize  dateSize=[self setNameFontSize:cellDetailWay.local_time andFont:LIDateFont andMaxSize:CGSizeMake(MAIN_SCREEN_WIDTH-13, 13)];
    UILabel * dateLab=[[UILabel alloc]initWithFrame:CGRectMake(imageX+25, CGRectGetMaxY(textView.frame),dateSize.width, 13)];
    dateLab.textColor=[UIColor whiteColor];
    dateLab.text=cellDetailWay.local_time;
    dateLab.font=LIDateFont;
    [view addSubview:dateLab];
    
    //创建索引提示信息  (最开始在这创建的)
    
    _indexLab.text=[NSString stringWithFormat:@"第%ld天 %ld/%lu",(long)cellDetailWay.dayCount,_index+1 ,(unsigned long)self.dataModelArray.count];
    _indexLab.font = [UIFont fontWithName:Arial_BoldItalicMT size:17];

}


@end
