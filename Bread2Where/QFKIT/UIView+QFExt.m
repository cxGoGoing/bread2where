//
//  UIView+QFExt.m
//  MyFreeLimit
//
//  Created by mac on 14-1-3.
//  Copyright (c) 2014年 张健. All rights reserved.
//

#import "UIView+QFExt.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (QFExt)
- (void) makeCorner:(float)r {
    if (r < 0) r = 0;
    self.layer.cornerRadius = r;
    self.layer.masksToBounds = YES;
}

- (float) width {
    return self.bounds.size.width;
}

- (float) height {
    return self.bounds.size.height;
}
@end
