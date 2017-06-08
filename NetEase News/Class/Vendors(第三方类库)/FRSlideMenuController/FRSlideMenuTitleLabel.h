//
//  FRSlideMenuTitleLabel.h
//  NetEase News
//
//  Created by 1860 on 16/6/15.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FRSlideMenuTitleLabel : UILabel
//设置文字渐变效果
@property (nonatomic, assign) CGFloat progress;
//文字渐变的颜色
@property (nonatomic, strong) UIColor *fillColor;

@end
