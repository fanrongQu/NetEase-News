//
//  FRNavigationController.h
//
//  Created by Mac on 15/9/21.
//  Copyright © 2015年 FR. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface FRNavigationController : UINavigationController

//导航栏颜色(默认白色)
@property (nonatomic, assign) UIColor *navigationBarColor;

//导航栏标题字体颜色(默认黑色)
@property (nonatomic, strong) UIColor *navigationBarTitleColor;

//Item颜色(默认黑色)
@property (nonatomic, assign) UIColor *itemNormalColor;

//Item不可用状态颜色(默认亮灰色)
@property (nonatomic, assign) UIColor *itemDisabledColor;

//NavigationBar图片渲染颜色(默认黑色)
@property (nonatomic, assign) UIColor *tintColor;


/**
 *  一次性设置所有颜色属性
 *
 *  @param navigationBar 颜色block
 */
- (void)setUpNavigationBarColor:(void(^)(UIColor **navigationBarColor,UIColor **navigationBarTitleColor,UIColor **itemNormalColor,UIColor **itemDisabledColor,UIColor **tintColor))navigationBar;


@end
