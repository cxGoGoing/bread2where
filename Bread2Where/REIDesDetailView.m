//
//  REIDesDetailView.m
//  Bread2Where
//
//  Created by qianfeng on 15-6-13.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIDesDetailView.h"
#import "REIDesDetailCellView.h"
#import "REIDesDetailPitcureController.h"
#define imageHeight 300
@interface REIDesDetailView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic, weak)UICollectionView * collectionView;
@property(nonatomic, weak)UIImageView * imageView;
@property(nonatomic, weak)UILabel * cityNameLabel;
@property(nonatomic, weak)UILabel * visitLabel;
@property(nonatomic, weak)UILabel * wishGoLabel;
@end
@implementation REIDesDetailView
+ (instancetype)desDetailViewSetUp
{
    return [[self alloc]initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -imageHeight, MAIN_SCREEN_WIDTH, imageHeight)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = [UIImage imageNamed:@"trip_edit_cover_default-1"];
        imageView.userInteractionEnabled = YES;
        
        
        //城市的名字
        UILabel * cityName = [[UILabel alloc]initWithFrame:CGRectMake(10, 200, 300, 40)];
        self.cityNameLabel = cityName;
        self.cityNameLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        self.cityNameLabel.textColor = [UIColor whiteColor];
        self.cityNameLabel.font = [UIFont fontWithName:Arial_BoldItalicMT size:30];
        [imageView addSubview:cityName];
        
        //访问量
        UILabel * visitLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(cityName.frame), 100, 20)];
        self.visitLabel = visitLabel;
        visitLabel.textColor = [UIColor whiteColor];
        visitLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [imageView addSubview:visitLabel];
        visitLabel.font = [UIFont boldSystemFontOfSize:13];
        self.wishGoLabel = visitLabel;
        
        //喜欢的人数
        UILabel * wishGoTo = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(visitLabel.frame), CGRectGetMaxY(cityName.frame), 300, 20)];
        self.wishGoLabel = wishGoTo;
        self.wishGoLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        self.wishGoLabel.textColor = [UIColor whiteColor];
        self.wishGoLabel.font = [UIFont boldSystemFontOfSize:13];
        [imageView addSubview:wishGoTo];
        
        
        
        
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT) collectionViewLayout:flowLayout];
        
        
        collectionView.contentInset = UIEdgeInsetsMake(imageHeight, 0, 30, 0);
        self.collectionView = collectionView;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;

        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
        self.collectionView.backgroundColor =[UIColor colorWithRed:0.98 green:0.97 blue:0.93 alpha:1];
        
        self.imageView = imageView;
        [self.collectionView insertSubview:imageView atIndex:0];
        [self addSubview:collectionView];
        
        //推荐城市
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0,185, MAIN_SCREEN_WIDTH, 20)];
        label.text = @"相册集";
        
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:15];
        label.textColor = [UIColor grayColor];
        [self.collectionView addSubview:label];
        
        UIView * dot1 = [[UIView alloc]initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH * 0.5 - 60 , 0, 6, 6)];
        [dot1 makeCorner:3];
        dot1.backgroundColor = [UIColor lightGrayColor];
        dot1.centerY = label.centerY;
        [collectionView addSubview:dot1];
        
        UIView * dot2 = [[UIView alloc]initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH * 0.5 - 75 , 0, 6, 6)];
        [dot2 makeCorner:3];
        dot2.backgroundColor = [UIColor lightGrayColor];
        dot2.centerY = label.centerY;
        [collectionView addSubview:dot2];
        
        UIView * dot3 = [[UIView alloc]initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH * 0.5 -  90, 0, 6, 6)];
        [dot3 makeCorner:3];
        dot3.backgroundColor = [UIColor lightGrayColor];
        dot3.centerY = label.centerY;
        [collectionView addSubview:dot3];
        
        UIView * dot4 = [[UIView alloc]initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH * 0.5 + 60 , 0, 6, 6)];
        [dot4 makeCorner:3];
        dot4.backgroundColor = [UIColor lightGrayColor];
        dot4.centerY = label.centerY;
        [collectionView addSubview:dot4];
        
        UIView * dot5 = [[UIView alloc]initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH * 0.5 + 75 , 0, 6, 6)];
        [dot5 makeCorner:3];
        dot5.backgroundColor = [UIColor lightGrayColor];
        dot5.centerY = label.centerY;
        [collectionView addSubview:dot5];
        
        UIView * dot6 = [[UIView alloc]initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH * 0.5 + 90  , 0, 6, 6)];
        [dot6 makeCorner:3];
        dot6.backgroundColor = [UIColor lightGrayColor];
        dot6.centerY = label.centerY;
        [collectionView addSubview:dot6];
        
        
        
        CGFloat imageH = 154 / 166.0 * (MAIN_SCREEN_WIDTH * 0.25);
        
        
        
        UIView * items = [[UIView alloc]initWithFrame:CGRectMake(0, -5, MAIN_SCREEN_WIDTH, imageH + 120)];
        [items makeCorner:5];
        items.backgroundColor = [UIColor colorWithRed:250/255.0 green:246/255.0 blue:232/255.0 alpha:1];
        [collectionView insertSubview:items belowSubview:label];
        
        UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(0, 0, MAIN_SCREEN_WIDTH * 0.25, imageH);
        btn1.contentMode = UIViewContentModeScaleAspectFit;
        [btn1 setBackgroundImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
        [btn1 setBackgroundImage:[UIImage imageNamed:@"1"] forState:UIControlStateHighlighted];
        btn1.layer.borderWidth = 1;
        btn1.layer.borderColor = [UIColor colorWithRed:250/255.0 green:246/255.0 blue:232/255.0 alpha:1].CGColor;
        [btn1 addTarget:self action:@selector(bkcgBtnTouch) forControlEvents:UIControlEventTouchUpInside];
        [items addSubview:btn1];
        
        UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake(CGRectGetMaxX(btn1.frame), 0, MAIN_SCREEN_WIDTH * 0.25, imageH);
        btn2.contentMode = UIViewContentModeScaleAspectFit;
        [btn2 setBackgroundImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
        [btn2 setBackgroundImage:[UIImage imageNamed:@"2"] forState:UIControlStateHighlighted];
        btn2.layer.borderWidth = 1;
        btn2.layer.borderColor = [UIColor colorWithRed:250/255.0 green:246/255.0 blue:232/255.0 alpha:1].CGColor;
        [btn2 addTarget:self action:@selector(tristPlaceBtnTcouch) forControlEvents:UIControlEventTouchUpInside];
        [items addSubview:btn2];
        
        UIButton * btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn3.frame = CGRectMake(CGRectGetMaxX(btn1.frame)*2, 0, MAIN_SCREEN_WIDTH * 0.25, imageH);
        btn3.contentMode = UIViewContentModeScaleAspectFit;
        [btn3 setBackgroundImage:[UIImage imageNamed:@"3"] forState:UIControlStateNormal];
        [btn3 setBackgroundImage:[UIImage imageNamed:@"3"] forState:UIControlStateHighlighted];
        btn3.layer.borderWidth = 1;
        btn3.layer.borderColor = [UIColor colorWithRed:250/255.0 green:246/255.0 blue:232/255.0 alpha:1].CGColor;
        [btn3 addTarget:self action:@selector(jpBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
        btn3.tag = 102;
        [items addSubview:btn3];
        
        UIButton * btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn4.frame = CGRectMake(CGRectGetMaxX(btn1.frame)*3, 0, MAIN_SCREEN_WIDTH * 0.25, imageH);
        btn4.contentMode = UIViewContentModeScaleAspectFit;
        [btn4 setBackgroundImage:[UIImage imageNamed:@"5"] forState:UIControlStateNormal];
        [btn4 setBackgroundImage:[UIImage imageNamed:@"5"] forState:UIControlStateHighlighted];
        btn4.layer.borderWidth = 1;
        btn4.layer.borderColor = [UIColor colorWithRed:250/255.0 green:246/255.0 blue:232/255.0 alpha:1].CGColor;
        [btn4 addTarget:self action:@selector(specialProductBtnTouch) forControlEvents:UIControlEventTouchUpInside];
        [items addSubview:btn4];
        
        
        UIButton * btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn5.frame = CGRectMake(0, CGRectGetMaxX(btn1.frame), MAIN_SCREEN_WIDTH * 0.25, imageH);
        btn5.contentMode = UIViewContentModeScaleAspectFit;
        [btn5 setBackgroundImage:[UIImage imageNamed:@"6"] forState:UIControlStateNormal];
        [btn5 setBackgroundImage:[UIImage imageNamed:@"6"] forState:UIControlStateHighlighted];
        btn5.layer.borderWidth = 1;
        btn5.layer.borderColor = [UIColor colorWithRed:250/255.0 green:246/255.0 blue:232/255.0 alpha:1].CGColor;
        [btn5 addTarget:self action:@selector(shouldKnowBtnTouch) forControlEvents:UIControlEventTouchUpInside];
        [items addSubview:btn5];
        
        
        //返回按钮
        UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(5, 10, 50, 50);
        
        [backBtn setImage:[UIImage imageNamed:@"add_new_poi_back_btn"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backupFront) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backBtn];
    }
    return self;
}

#pragma mark 菜单项按钮事件
-(void) bkcgBtnTouch {
    [_delegate skipToIntro:[NSString stringWithFormat:BKCG_URL, self.type,_idDes]];
}
-(void)tristPlaceBtnTcouch
{
    [_delegate desDetailViewTristPlaceBtnTcouch];
}

-(void)specialProductBtnTouch
{
    [_delegate desDetailViewsSpecialProductBtnTouch];
}

-(void)shouldKnowBtnTouch
{
    [_delegate deDetailViewsShouldKnowBtnTouch:[NSString stringWithFormat:SHOULD_KNOW, self.type,_idDes]];
}

//精品游记按钮
- (void)jpBtnTouch:(UIButton *)btn
{
    [_delegate skipTointro:btn.tag];
    //    [_delegate skipToIntro:[NSString stringWithFormat:<#(NSString *), ...#>]];
}

#pragma mark 返回按钮
- (void) backupFront {
    [_delegate btnClick:self];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    self.frame = newSuperview.bounds;
    self.collectionView .frame = CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT);
}

- (void)setSection:(NSMutableArray *)section
{
    _section = section;
    [self.collectionView reloadData];
}

- (void)setCover:(NSString *)cover
{   _cover = cover;
    NSURL * url =[NSURL URLWithString:_cover];
    [self.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"trip_edit_cover_default-1"] usingProgressView:UIProgressViewStyleDefault];
    
}

- (void)setCityName:(NSString *)cityName
{
    _cityName = cityName;
    self.cityNameLabel.text = cityName;
    
}

- (void)setVisited_count:(NSInteger)visited_count
{
    _visited_count = visited_count;
    NSString * visitCount = [NSString stringWithFormat:@"%ld",visited_count];
    self.visitLabel.text = [NSString stringWithFormat:@"%@%@",visitCount,@" 去过"];
}

- (void)setWish_to_go_count:(NSInteger)wish_to_go_count
{
    _wish_to_go_count = wish_to_go_count;
    float wishNumber = 0;
    if (wish_to_go_count/10000.0>1)
    {
         wishNumber = wish_to_go_count/10000.0;
        NSString * wishCount = [NSString stringWithFormat:@"%0.1f",wishNumber];
        self.wishGoLabel.text = [NSString stringWithFormat:@"%@%@",wishCount,@" 万喜欢"];
    }else
    {
        wishNumber = wish_to_go_count;
        NSString * wishCount = [NSString stringWithFormat:@"%0.f",wishNumber];
        self.wishGoLabel.text = [NSString stringWithFormat:@"%@%@",wishCount,@" 喜欢"];
    }
   
}
#pragma mark 数据源方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.section.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    REIDesDetailCellView * cell = [REIDesDetailCellView desDetailCellViewWith:collectionView andIndexPath:indexPath andObj:self.section[indexPath.item]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (MAIN_SCREEN_WIDTH - 15 * 2 - 15) * 0.5;
    CGFloat height = width;
    return CGSizeMake(width,height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(220, 15, 5, 15);
}

#pragma mark 添加头部h和尾部

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        UICollectionReusableView * footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        footerView.frame =CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 100);
        return footerView;
    }
    return nil;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yOffset = _collectionView.contentOffset.y;
    if (yOffset < -imageHeight) {
        //向下滚动
        CGRect frame = _imageView.frame;
        frame.origin.y = yOffset;
        frame.size.height = -yOffset;
        _imageView.frame = frame;
    } 
}

/**
 *  选中了某个item
 *
 *  @param collectionView 
 *  @param indexPath
 */
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    REIDesDetailPitcureController * desDetailPitcureController=[[REIDesDetailPitcureController alloc]init];
    /**
     *  把存储带有图片信息的模型数组传递给REIDesDetailPitcureController的图片信息数组
     */
    desDetailPitcureController.desDetailPitcureArray=self.section;
    desDetailPitcureController.itemIndex=indexPath.item;
    //调用代理方法
    [_delegate presentDesDetailPitcureController:desDetailPitcureController];
}
@end
