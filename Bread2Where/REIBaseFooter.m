
//
//  REIBaseFooter.m
//  Rei
//
//  Created by FEI on 15/5/9.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIBaseFooter.h"
#import "REIBaseTabBar.h"
#import "REIBaseTabBarBtn.h"
#import "UIButton+EXT.h"

@interface REIBaseFooter()
@end

@implementation REIBaseFooter

+(instancetype) baseFooter
{
    static REIBaseFooter * baseFooter;
    if(baseFooter == nil) {
        baseFooter =  [[self alloc]init];
    }
    return baseFooter;
}

-(instancetype)init
{
    if(self = [super init]) {
        //根据按钮初始化 tabBar
        self.btnItems = [self createTabBtns];
    }
    return self;
}

//初始化 tabBar 按钮
-(NSArray *)createTabBtns
{
    /**创建和设置底部自定义 tabbar 按钮属性值*/
    REIBaseTabBarBtn * btnRec = [REIBaseTabBarBtn buttonWithType:UIButtonTypeCustom];
    REIBaseTabBarBtn * btnDes = [REIBaseTabBarBtn buttonWithType:UIButtonTypeCustom];
    REIBaseTabBarBtn * btnPlu = [REIBaseTabBarBtn buttonWithType:UIButtonTypeCustom];
    REIBaseTabBarBtn * btnSp = [REIBaseTabBarBtn buttonWithType:UIButtonTypeCustom];
    REIBaseTabBarBtn * btnMe = [REIBaseTabBarBtn buttonWithType:UIButtonTypeCustom];
    
    //设置按钮背景图片
    
    [btnRec setTitle:@"推荐" andImage:@"tabicon_zhuye" andSelectedImage:@"tabicon_zhuye_2"];
    [btnDes setTitle:@"目的地" andImage:@"tabicon_mudidi" andSelectedImage:@"tabicon_mudidi_2"];
    [btnSp setTitle:@"特价" andImage:@"tabicon_temai" andSelectedImage:@"tabicon_temai_2"];
    [btnPlu setTitle:@"主题" andImage:@"tabicon_sale_gray" andSelectedImage:@"tabicon_sale_green"];
    [btnMe setTitle:@"我的" andImage:@"tabicon_wode" andSelectedImage:@"tabicon_wode_2"];
    
    //修改文字大小,以及显示位置
    [self changeTitleSizeWith:btnRec];
    [self changeTitleSizeWith:btnDes];
    [self changeTitleSizeWith:btnSp];
    [self changeTitleSizeWith:btnMe];
    [self changeTitleSizeWith:btnPlu];
    NSArray * btnItems = [NSArray arrayWithObjects:btnRec,btnDes,btnPlu,btnSp,btnMe,nil];
    return btnItems;
}

- (void)changeTitleSizeWith:(REIBaseTabBarBtn *)btn
{
    //改变文字大小
    btn.titleLabel.font = [UIFont systemFontOfSize:11];
    //改变文字显示位置
    [btn setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:0.16 green:0.75 blue:0.36 alpha:1.0] forState:UIControlStateSelected];

}
@end
