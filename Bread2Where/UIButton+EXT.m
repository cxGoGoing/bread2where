//
//  UIButton+EXT.m
//  Rei
//
//  Created by FEI on 15/5/9.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import "UIButton+EXT.h"
#import "UIImage+Tint.h"
@implementation UIButton (EXT)

-(void)setTitle:(NSString *)title andImage:(NSString *)image andSelectedImage:(NSString *)selectedImage
{
    [self setTitle:title forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:image]forState:UIControlStateNormal];
    [self setImage:[[UIImage imageNamed:selectedImage] imageWithTintColor:[UIColor colorWithRed:0.22 green:0.72 blue:0.68 alpha:1.0]] forState:UIControlStateSelected];
}

@end
