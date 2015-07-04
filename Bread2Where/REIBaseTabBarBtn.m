
//
//  REIBaseTabBarBtn.m
//  Rei
//
//  Created by FEI on 15/5/8.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "REIBaseTabBarBtn.h"

@implementation REIBaseTabBarBtn

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        
    }
    return self;
}


-(void)layoutSubviews {
    [super layoutSubviews];
    
    // Center image
    CGPoint center = self.imageView.center;
    center.x = self.frame.size.width/2;
    center.y = self.imageView.frame.size.height/2 + 6;
    self.imageView.center = center;
    
    //Center text
    CGRect newFrame = [self titleLabel].frame;
    newFrame.origin.x = 0;
    newFrame.origin.y = self.imageView.frame.size.height + 13;
    newFrame.size.width = self.frame.size.width;
    
    self.titleLabel.frame = newFrame;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor colorWithRed:0.22 green:0.72 blue:0.68 alpha:1.0] forState:UIControlStateSelected];
}

@end
