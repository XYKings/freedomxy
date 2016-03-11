//
//  SelectSpecialView.h
//  STSFreeTime
//
//  Created by dllo on 16/1/12.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GPUImageFilterGroup;

typedef void(^SelectIndexBlock)(NSInteger index);
@interface SelectSpecialView : UIView
@property (nonatomic, strong) UIImage *filterImage;
@property (nonatomic, strong) UICollectionView *selectSpecial;
- (void)selectIndex:(SelectIndexBlock)BlockName;

- (void)addFilters:(NSArray *)filters;

@end
