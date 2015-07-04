//
//  UITextField+REITextField.h
//  REITextViewDemo
//
//  Created by Adil Soomro on 4/14/14.
//  Copyright (c) 2014 Adil Soomro. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    REITextFieldTypeDefault,
    REITextFieldTypeRound
}REITextFieldType;

@interface REITextField : UITextField

@end


@interface UITextField ()
- (void)setupTextFieldWithIconName:(NSString *)name;
- (void)setupTextFieldWithType:(REITextFieldType)type withIconName:(NSString *)name;
@end
