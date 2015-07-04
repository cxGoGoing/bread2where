//
//  REIMeController.m
//  Bread2Where
//
//  Created by FEI on 15/6/9.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIMeController.h"
#import "ZCControl.h"
#import "MBProgressHUD.h"
#import "UMSocial.h"
#import "UMFeedback.h"
#import "YHXYViewController.h"
#import "GYViewController.h"
#import "UIImage+Tint.h"
@interface REIMeController ()<UIAlertViewDelegate>
@property(nonatomic, weak)MBProgressHUD * hud;
@property(nonatomic, copy)NSString * filePath;
@property(nonatomic, strong)NSMutableArray * array;
@end

@implementation REIMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    self.view.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.00f];
    [self createUI];
}

//- (NSMutableArray *)array
//
//{
//    if (_array == nil) {
//        
//        
//    }
//    return _array;
//}

- (void)createUI
{
    NSArray *titleArray = @[@"相关声明",@"我的分享",@"我的反馈",@"软件版本",@"清除缓存"];
    NSArray *imageArray = @[@"文章字号.png",@"分享设置.png",@"用户反馈.png",@"关于我们.png",@"清除缓存.png"];
    //头像
    UIButton * header = [UIButton buttonWithType:UIButtonTypeCustom];
    header.frame = CGRectMake(0, 0, MAIN_SCREEN_WIDTH * 0.16, MAIN_SCREEN_WIDTH * 0.16);
    [header makeCorner:header.frame.size.width * 0.5];
    header.centerX = MAIN_SCREEN_WIDTH * 0.5;
    header.centerY = MAIN_SCREEN_HEIGHT * 0.15;
    [header setBackgroundImage:[UIImage imageNamed:@"Icon-76"] forState:UIControlStateNormal];
    [self.view addSubview:header];
    
    //按钮
    for (int i = 0; i<titleArray.count; i++)
    {
        //按钮
        UIButton *button = [ZCControl createButtonWithFrame:CGRectMake(20, CGRectGetMaxY(header.frame) + 20 +i*MAIN_SCREEN_HEIGHT * 0.08, MAIN_SCREEN_WIDTH* 0.85, MAIN_SCREEN_HEIGHT * 0.08 - 1) title:titleArray[i] imageName:nil bgImageName:nil target:self method:@selector(buttonClick:)];
        button.centerX = MAIN_SCREEN_WIDTH * 0.5;
        
        button.titleLabel.font = [UIFont fontWithName:Arial_BoldItalicMT size:16];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.tag = 100 + i;
        
        if (i == 0)
        {
            [button setBackgroundImage:[[UIImage imageNamed:@"上底_1.png"] imageWithTintColor:[UIColor colorWithRed:0.00f green:0.76f blue:0.68f alpha:1.00f]]  forState:UIControlStateNormal];
            
            [button setBackgroundImage:[UIImage imageNamed:@"上底_2.png"] forState:UIControlStateHighlighted];
        }else if (i == 4) {
            [button setBackgroundImage:[[UIImage imageNamed:@"下底_1.png"] imageWithTintColor:[UIColor colorWithRed:0.00f green:0.76f blue:0.68f alpha:1.00f]] forState:UIControlStateNormal];
            
            [button setBackgroundImage:[UIImage imageNamed:@"下底_2.png"] forState:UIControlStateHighlighted];
        }else{
            [button setBackgroundImage:[[UIImage imageNamed:@"中底_1.png"] imageWithTintColor:[UIColor colorWithRed:0.00f green:0.76f blue:0.68f alpha:1.00f]] forState:UIControlStateNormal];
            
            [button setBackgroundImage:[UIImage imageNamed:@"中底_2.png"] forState:UIControlStateHighlighted];
        }
        [self.view addSubview:button];

        //
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 30, 30)];
        imageView.image = [[UIImage imageNamed:imageArray[i]] imageWithTintColor:[UIColor whiteColor]];
        imageView.userInteractionEnabled = NO;
        [button addSubview:imageView];
        
        
    }
}

//按钮点击效果
- (void)buttonClick:(UIButton *)button
{
    
    switch (button.tag) {
        case 100: //免费声明
        {
            YHXYViewController*vc=[[YHXYViewController alloc]init];
            vc.navigationItem.title = @"相关声明";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 101://分享
        {
            
            [UMSocialSnsService presentSnsIconSheetView:self appKey:UMENG_SHARE_APPID shareText:@"献给爱旅行的您.@小晴将陪您来一场不一样的旅行.技术支持 QQ:1497332442"  shareImage:nil shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToDouban,UMShareToEmail,UMShareToSms,nil] delegate:nil];
        }
            break;
        case 102:
        {
            //反馈
            [UMFeedback showFeedback:self withAppkey:UMENG_SHARE_APPID];
        }
            break;
        case 103:
        {//关于我们
             GYViewController*vc = [[GYViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 104: //清除缓存
        {
            [self start];
        }
        default:
            break;
    }
   }





//清除缓存
- (void)start{
//    NSArray * paths =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//    self.filePath = [paths lastObject];
//    unsigned long long size = [self fileSizeAtPath:[paths lastObject]];
    CGFloat size = [[SDImageCache sharedImageCache] checkTmpSize];
    NSString *contents = [NSString stringWithFormat:@"%@ %.2fM，%@",@"当前缓存大小为",size,@"是否清除？"];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"清除缓存" message:contents delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertViewStyle = UIAlertViewStyleDefault;
    
    for(UIView *subview in alert.subviews)
    {
        if([[subview class] isSubclassOfClass:[UILabel class]])
        {
            UILabel *label = (UILabel*)subview;

                label.textAlignment = NSTextAlignmentLeft;
        }
    }
    
    [alert show];
}

#pragma mark- UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithView:self.view];
        self.hud = HUD;
        [self.view addSubview:HUD];
        HUD.center = self.view.center;
        HUD.minSize = CGSizeMake(110.0f, 70.0f);
        HUD.centerY = MAIN_SCREEN_HEIGHT * 0.5 - 50;
        HUD.mode = MBProgressHUDModeIndeterminate;
        HUD.labelText = @"正在帮您清理";
        [HUD showWhileExecuting:@selector(clear) onTarget:self withObject:nil animated:YES];
    }
}


//清除缓存
- (void)clear
{
//    NSLog(@"%lu",size);
    
//    NSFileManager *manager = [NSFileManager defaultManager];
//        NSArray*array=[manager contentsOfDirectoryAtPath:self.filePath error:nil];
//    
//    for (NSString*str in array)
//    {
//        NSString*newPath=[NSString stringWithFormat:@"%@/%@",self.filePath,str];
//        [manager removeItemAtPath:newPath error:nil];
//    }
    
//    [[SDImageCache sharedImageCache] clearMemory];
//    [[SDImageCache sharedImageCache] cleanDisk];
    sleep(1);
    
    [[SDImageCache sharedImageCache] clearDisk];
    self.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"black_tips_ok.png"]];
    self.hud.mode = MBProgressHUDModeCustomView;
    self.hud.labelText = @"清除成功";
    sleep(1);
}
@end
