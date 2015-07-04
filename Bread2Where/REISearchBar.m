//
//  REISearchBar.m
//  StarWardrobe
//
//  Created by FEI on 15/6/8.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REISearchBar.h"
@implementation REISearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tintColor = [UIColor clearColor];
    }
    return self;
}

-(void) layoutSubviews
{
    [super layoutSubviews];
    
    UITextField *searchField;
    NSArray *subviewArr = self.subviews;
    for(int i = 0; i < subviewArr.count ; i++) {
        UIView *viewSub = [subviewArr objectAtIndex:i];
        NSArray *arrSub = viewSub.subviews;
        for (int j = 0; j < arrSub.count ; j ++) {
            id tempId = [arrSub objectAtIndex:j];
            if([tempId isKindOfClass:[UITextField class]]) {
                searchField = (UITextField *)tempId;
            }
        }
    }
    
    //自定义UISearchBar
    if(searchField) {
        searchField.placeholder = @"点击选择热门目的地...";
        
        searchField.textAlignment = NSTextAlignmentLeft;
        searchField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 20)];
        searchField.tintColor = [UIColor colorWithRed:11/255.0 green:96/255.0 blue:254/255.0 alpha:1];
        searchField.width =  MAIN_SCREEN_WIDTH - 60;
        [searchField setBorderStyle:UITextBorderStyleRoundedRect];
        [searchField setBackgroundColor:[UIColor colorWithRed:0.03 green:0.67 blue:0.60 alpha:1.00f]];
        [searchField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        [searchField setTextColor:[UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.00f]];
        
        searchField.centerX = self.centerX;
        
    }
    
    //外部背景
    UIView * outView = [[UIView alloc] initWithFrame:self.bounds];
    [outView setBackgroundColor:[UIColor clearColor]];
    [self insertSubview:outView atIndex:1];
}


@end
