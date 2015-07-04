//
//  REIThemeDetailFrameCell.m
//  Bread2Where
//
//  Created by qianfeng on 15-6-15.
//  Copyright (c) 2015年 FEI. All rights reserved.
//



#import "REIThemeDetailFrameCell.h"
#import "REIThemeArticleModel.h"
@implementation REIThemeDetailFrameCell
/**
  计算文字尺寸
 */


- (void)setArticleModel:(REIThemeArticleModel *)articleModel
{
    _articleModel = articleModel;
    //子控件之间的距离
    CGFloat padding = 10;
    //1.图片
    CGFloat imgX = 10;
    CGFloat imgY = 0;
    CGFloat imgW = MAIN_SCREEN_WIDTH-20;
    CGFloat imgH = 200;
    _imageF = CGRectMake(imgX, imgY, imgW, imgH);
    CGFloat wordW = MAIN_SCREEN_WIDTH-20;
    CGFloat desX = imgX;
    CGSize textSize = [self sizeWithText:self.articleModel.desc font:DescFont maxSize:CGSizeMake(wordW, MAXFLOAT)];

    if (self.articleModel.image_url.length >0)
    {//有配图
        //2.描述
        CGFloat desY = imgY + imgH+padding;
        _descripF = CGRectMake(desX, desY, textSize.width, textSize.height);
    }else
    {//没有配图
        _descripF = CGRectMake(desX, padding, textSize.width,  textSize.height);
    }
    _cellHeight = CGRectGetMaxY(_descripF)+padding;
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
@end
