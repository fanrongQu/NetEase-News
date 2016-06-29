//
//  FRSlideMenuCollectionViewCell.h
//  NetEase News
//
//  Created by 1860 on 16/6/26.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FRSlideMenuCellDelegate <NSObject>

- (void)choseDeleteButton:(UIButton *)button;

- (void)longPressButton;

- (void)moveCollectionViewCell:(UILongPressGestureRecognizer *)longGesture
;

@end


@interface FRSlideMenuCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) UILabel *titleL;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, weak) UIButton *deleteBtn;

@property (nonatomic, assign) BOOL LongPressGesture;

@property (nonatomic, assign) id<FRSlideMenuCellDelegate> delegate;

@end
