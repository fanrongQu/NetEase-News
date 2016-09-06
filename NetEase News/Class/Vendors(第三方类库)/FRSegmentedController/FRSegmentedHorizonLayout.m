//
//  FRSegmentedHorizonLayout.m
//  NetEase News
//
//  Created by 1860 on 16/6/18.
//  Copyright © 2016年 FanrongQu. All rights reserved.
//

#import "FRSegmentedHorizonLayout.h"

@implementation FRSegmentedHorizonLayout

- (void)prepareLayout
{
    [super prepareLayout];
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    self.sectionInset = UIEdgeInsetsMake(-15, 0, 0, 0);
    self.headerReferenceSize = CGSizeMake(0, 0);
    if (self.collectionView.bounds.size.height) {
        
        self.itemSize = self.collectionView.bounds.size;
    }
    
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
}

@end
