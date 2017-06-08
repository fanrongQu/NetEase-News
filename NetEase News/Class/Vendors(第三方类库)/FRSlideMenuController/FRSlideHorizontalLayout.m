//
//  FRHorizontalLayout.m
//  NetEase News
//
//  Created by 1860 on 16/6/15.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "FRSlideHorizontalLayout.h"

@implementation FRSlideHorizontalLayout
- (void)prepareLayout
{
    [super prepareLayout];
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    if (self.collectionView.bounds.size.height) {
        
        self.itemSize = self.collectionView.bounds.size;
    }
    
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
}
@end
