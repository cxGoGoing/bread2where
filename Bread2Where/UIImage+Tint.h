//
//  UIImage+Tint.h
//  ForALongTimeWithU
//
//  Created by FEI on 15/5/25.
//  Copyright (c) 2015年 FEI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Tint)

- (UIImage *) imageWithTintColor:(UIColor *)tintColor;
- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor;
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;
@end
