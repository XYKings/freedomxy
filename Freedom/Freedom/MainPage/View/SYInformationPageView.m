//
//  SYInformationPageView.m
//  SY_OL
//
//  Created by dllo on 15/12/15.
//  Copyright © 2015年 dllo. All rights reserved.
//

#import "SYInformationPageView.h"
#import "UIImageView+WebCache.h"
//#import "SYInformationPageTableViewCell.h"
#import "UIImageView+WebCache.h"
//#import "SYInformationPageForTitleImageCollectionViewCell.h"
//#import "SYTitleImageModel.h"

@interface SYInformationPageView() <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, retain) NSMutableArray *imageArray;
@property (nonatomic, retain) UIPageControl *page;
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, assign) NSInteger index;
@end
@implementation SYInformationPageView

- (instancetype)initWithFrame:(CGRect)frame withArray:(NSMutableArray *)imageArray
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createCollectionView:imageArray];
        [self createPageController];
        [self createTimer];
    }
    return self;
}

- (void)createCollectionView:(NSMutableArray *)imageArray {
    
//    SYTitleImageModel *first = [imageArray firstObject];
//    SYTitleImageModel *last = [imageArray lastObject];
//    self.imageArray = [NSMutableArray array];
//    [self.imageArray addObject:last];
//    for (NSInteger i = 0; i < imageArray.count; i++) {
//        SYTitleImageModel *model = [imageArray objectAtIndex:i];
//        [self.imageArray addObject:model];
//    }
//    [self.imageArray addObject:first];
    
    UICollectionViewFlowLayout *flowV = [[UICollectionViewFlowLayout alloc] init];
    flowV.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowV.itemSize = CGSizeMake(WIDTH ,self.frame.size.height);
    flowV.minimumInteritemSpacing = 0;
    flowV.minimumLineSpacing = 0;
    
    self.imagePlay = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, self.frame.size.height) collectionViewLayout:flowV];
    self.imagePlay.backgroundColor = [UIColor whiteColor];
    self.imagePlay.delegate = self;
    self.imagePlay.dataSource = self;
    self.imagePlay.pagingEnabled = YES;
    self.imagePlay.showsHorizontalScrollIndicator = NO;
    self.imagePlay.contentOffset = CGPointMake(WIDTH, 0);
    
//    [self.imagePlay registerClass:[SYInformationPageForTitleImageCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self addSubview:self.imagePlay];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageArray.count;
}

//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    SYInformationPageForTitleImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    SYTitleImageModel *model = [self.imageArray objectAtIndex:indexPath.row];
//    
//    [cell.titleImage sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:[UIImage imageNamed:@"占位图"]];
//    cell.titleLabel.text = model.stitle;
//    cell.indexLabel.text = [NSString stringWithFormat:@"%ld/%ld", indexPath.row + 1, (unsigned long)self.imageArray.count];
//    return cell;
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row - 1;
    [self.delegate sendImageIndex:index];
}

- (void)createTimer {
    self.index = 1;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(playImage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)playImage {
    if (1 == self.index / (self.imageArray.count - 1)) {
        self.index = 1;
    } else {
        self.index ++;
    }
    [self.imagePlay setContentOffset:CGPointMake(WIDTH * self.index, 0) animated:YES];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer setFireDate:[NSDate distantFuture]];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:2]];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index =  self.imagePlay.contentOffset.x / self.imagePlay.frame.size.width;
    if (index == self.imageArray.count - 1) {
        self.imagePlay.contentOffset = CGPointMake(WIDTH, 0);
    }
    if (index == 0) {
        self.imagePlay.contentOffset = CGPointMake(WIDTH * (self.imageArray.count - 1), 0);
    }
}

#pragma mark - 创建pageControl
- (void)createPageController {
    self.page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 50, WIDTH, 30)];
    self.page.numberOfPages = self.imageArray.count - 2;
    self.page.pageIndicatorTintColor = [UIColor redColor];
    [self addSubview:self.page];
    [self bringSubviewToFront:self.page];
}

@end
