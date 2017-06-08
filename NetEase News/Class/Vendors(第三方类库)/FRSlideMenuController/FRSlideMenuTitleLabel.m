//
//  FRSlideMenuTitleLabel.m
//  NetEase News
//
//  Created by 1860 on 16/6/15.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "FRSlideMenuTitleLabel.h"

@implementation FRSlideMenuTitleLabel

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    
    [_fillColor set];
    
    rect.size.width = rect.size.width * _progress;
    
    UIRectFillUsingBlendMode(rect, kCGBlendModeSourceIn);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}


- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    //setNeedsDisplay会调用自动调用drawRect方法，这样可以拿到  UIGraphicsGetCurrentContext，就可以画画了
    [self setNeedsDisplay];
}


@end
