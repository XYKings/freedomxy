//
//  SYInformationPageView.h
//  SY_OL
//
//  Created by dllo on 15/12/15.
//  Copyright © 2015年 dllo. All rights reserved.
//

#import "LMSBaseView.h"

@protocol TitleImageDelegate <NSObject>

- (void)sendImageIndex:(NSInteger)index;

@end
@interface SYInformationPageView : LMSBaseView
- (instancetype)initWithFrame:(CGRect)frame withArray:(NSMutableArray *)imageArray;
@property (nonatomic, retain) UICollectionView *imagePlay;
@property (nonatomic, assign) id<TitleImageDelegate> delegate;
@end
