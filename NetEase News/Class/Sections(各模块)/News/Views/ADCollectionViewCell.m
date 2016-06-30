//
//  ADCollectionViewCell.m
//  NetEase News
//
//  Created by 1860 on 16/6/29.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "ADCollectionViewCell.h"

@interface ADCollectionViewCell ()

@property (nonatomic, strong) UIImageView *ADImageView;

@property (nonatomic, strong) UILabel *describeLabel;

@property (nonatomic, strong) UIView *bottomView;


@end

@implementation ADCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self ADImageView];
        [self bottomView];
        [self describeLabel];
    }
    return self;
}

- (UIImageView *)ADImageView {
    if (!_ADImageView) {
        _ADImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_ADImageView];
        [_ADImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _ADImageView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = kUIColor_RGB(100, 100, 100, 0.5);
        [self.contentView addSubview:_bottomView];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(35);
        }];
    }
    return _bottomView;
}

- (UILabel *)describeLabel {
    if (!_describeLabel) {
        _describeLabel = [[UILabel alloc]init];
        _describeLabel.font = kFontSize(14);
        _describeLabel.textColor = [UIColor whiteColor];
        _describeLabel.text = @"是你的接口";
        [self.bottomView addSubview:_describeLabel];
        [_describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(5);
            make.top.bottom.mas_equalTo(0);
            make.right.mas_equalTo(70);
        }];
    }
    return _describeLabel;
}

@end
