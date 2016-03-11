//
//  SelectSpecialView.m
//  STSFreeTime
//
//  Created by dllo on 16/1/12.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "SelectSpecialView.h"
#import "SelectCollectionViewCell.h"
//#import "Filter.h"
#import "GPUImageFilterGroup.h"

@interface SelectSpecialView() <UICollectionViewDelegate, UICollectionViewDataSource>


@property (nonatomic, strong) NSArray *filterArray;
@property (nonatomic, strong) GPUImageFilterGroup *tempGroup;
@property (nonatomic, copy) void(^myBlock)(NSInteger);
@end
@implementation SelectSpecialView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubView];
    }
    return self;
}

- (void)createSubView {
    UICollectionViewFlowLayout *flowL = [[UICollectionViewFlowLayout alloc] init];
    flowL.itemSize = CGSizeMake(WIDTH / 4.5, HEIGHT / 7.0);
    flowL.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowL.minimumLineSpacing = 5;
    self.selectSpecial = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:flowL];
    self.selectSpecial.delegate = self;
    self.selectSpecial.dataSource = self;
    self.selectSpecial.pagingEnabled = NO;
    [self.selectSpecial registerClass:[SelectCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self addSubview:self.selectSpecial];
}

- (void)addFilters:(NSArray *)filters {
    _filterArray = filters;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.filterArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SelectCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    GPUImageFilterGroup *filter = [self.filterArray objectAtIndex:indexPath.row];
    [filter addTarget:cell.smallCameraView];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _myBlock(indexPath.row);
}

- (void)selectIndex:(SelectIndexBlock)BlockName {
    _myBlock = BlockName;
}


@end
