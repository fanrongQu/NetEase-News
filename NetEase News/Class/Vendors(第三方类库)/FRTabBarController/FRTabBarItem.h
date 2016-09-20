//
//  FRTabBarItem.h
//  爱鲜蜂
//
//  Created by 1860 on 16/4/1.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FRTabBarItem : UIButton

/**  普通状态item的颜色  */
@property (nonatomic, strong) UIColor *normalColor;
/**  选中状态item的颜色  */
@property (nonatomic, strong) UIColor *selectedColor;

@property (nonatomic, strong) UITabBarItem *tabBarItem;

@end
