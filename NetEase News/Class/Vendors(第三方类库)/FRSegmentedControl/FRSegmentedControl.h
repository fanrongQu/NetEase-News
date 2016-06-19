//
//  FRSegmentedControl.h
//  NetEase News
//
//  Created by 1860 on 16/6/16.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FRSegmentedControl : UIViewController

/**
 *  title整体的视图
 */
@property (nonatomic, strong) UIView *segmentedView;
/**
 正常标题颜色(建议：和选中背景色一致)
 */
@property (nonatomic, strong) UIColor *norColor;
/**
 选中标题颜色(建议：和正常背景色一致)
 */
@property (nonatomic, strong) UIColor *selColor;
/**
 过度标题颜色
 */
@property (nonatomic, strong) UIColor *overColor;
/**
 正常标题背景颜色(建议：和选中标题颜色一致)
 */
@property (nonatomic, strong) UIColor *normalBackColor;
/**
 选中标题背景颜色(建议：和正常标题颜色一致)
 */
@property (nonatomic, strong) UIColor *selectBackColor;
/**
 *  内容视图的frame
 */
@property (nonatomic, assign) CGRect contentFrame;


/**
 *  一次性设置所有属性
 */
- (void)setUpSegmentedEffect:(void(^)(UIColor **norColor,UIColor **selColor,UIColor **overColor,UIColor **normalBackColor,UIColor **selectBackColor))segmentedEffectBlock;

@end
