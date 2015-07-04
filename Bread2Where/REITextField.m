//
//  UITextField+REITextField.m
//  REITextViewDemo
//
//  Created by Adil Soomro on 4/14/14.
//  Copyright (c) 2014 Adil Soomro. All rights reserved.
//

#import "REITextField.h"
#define kLeftPadding 10
#define kVerticalPadding 12
#define kHorizontalPadding 10

@interface REITextField (){
    REITextFieldType _type;
}

@end

@implementation REITextField

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

- (void)setupTextFieldWithIconName:(NSString *)name{
    [self setupTextFieldWithType:REITextFieldTypeDefault withIconName:name];
}

- (void)setupTextFieldWithType:(REITextFieldType)type withIconName:(NSString *)name{
    UIEdgeInsets edge = [self edgeInsetsForType:type];
    NSString *imageName = [self backgroundImageNameForType:type];
    CGRect imageViewFrame = [self iconImageViewRectForType:type];
    _type = type;
    
    
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image resizableImageWithCapInsets:edge];
    
    [self setBackground:image];
    [self setBackgroundColor:[UIColor clearColor]];
    
    UIImage *icon = [UIImage imageNamed:name];
    
    //make an imageview to show an icon on the left side of textfield
    UIImageView * iconImage = [[UIImageView alloc] initWithFrame:imageViewFrame];
    [iconImage setImage:icon];
    [iconImage setContentMode:UIViewContentModeScaleAspectFit];
    self.leftView = iconImage;
    self.leftViewMode = UITextFieldViewModeAlways;

    [self setNeedsDisplay]; //force reload for updated editing rect for bound to take effect.
}
- (CGRect)iconImageViewRectForType:(REITextFieldType) type{
    UIEdgeInsets edge = [self edgeInsetsForType:type];
    if (type == REITextFieldTypeRound) {
        return CGRectMake(0, 0, edge.left*2, self.frame.size.height); //to put the icon inside
    }
    /*
     if (type == REITextFieldTypeBlahBlah) {
     return 786; //whatever suits your field
     }
     */
    
    return CGRectMake(0, 0, edge.left, self.frame.size.height); // default
}
- (UIEdgeInsets)edgeInsetsForType:(REITextFieldType) type{
    if (type == REITextFieldTypeRound) {
        return UIEdgeInsetsMake(13, 13, 13, 13);
    }
    /*
     if (type == REITextFieldTypeBlahBlah) {
     return UIEdgeInsetsMake(15, 15, 15, 15); //whatever suits your field
     }
     */
    
    return UIEdgeInsetsMake(10, 43, 10, 19); // default
}
- (NSString *)backgroundImageNameForType:(REITextFieldType) type{
    if (type == REITextFieldTypeRound) {
        return @"round_textfield";
    }
    /*
     if (type == REITextFieldTypeBlahBlah) {
        return @""; // return suitable
     }
     */
    
    return @"text_field"; // default
}

@end
