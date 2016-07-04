//
//  ADCollectionViewCell.h
//  NetEase News
//
//  Created by 1860 on 16/6/29.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADCollectionViewCell : UICollectionViewCell

/**
 *  设置轮播图片和标题
 *
 *  @param image 图片名
 *  @param title 标题
 */
- (void)setADImage:(NSString *)image ADtitle:(NSString *)title;

@end
