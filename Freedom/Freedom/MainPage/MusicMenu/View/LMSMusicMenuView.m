//
//  LMSMusicMenuView.m
//  Freedom
//
//  Created by dllo on 16/1/21.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import "LMSMusicMenuView.h"
#import "LMSMusicMenuCollectionViewCell.h"
#define XLEN self.frame.size.width/375


@implementation LMSMusicMenuView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createSubviews];
        
    }
    return self;
}

- (void)createSubviews {
    
    self.hotButton = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width - 100, 10, 40, 25)];
    [self.hotButton setTitle:@"最热" forState:UIControlStateNormal];
    [self.hotButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [self.hotButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.hotButton];
    
    self.newestButton = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width - 50, 10, 40, 25)];
    [self.newestButton setTitle:@"最新" forState:UIControlStateNormal];
    [self.newestButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [self.newestButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.newestButton];
    
    
    //瀑布流
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //item 的大小 每一个小方块的大小
    [layout setItemSize:CGSizeMake(160 * XLEN, 200 * XLEN )];
    [layout setMinimumInteritemSpacing:10 * XLEN];
    [layout setMinimumInteritemSpacing:10 * XLEN];
    
    //创建collectionView
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 40 * XLEN, self.frame.size.width, self.frame.size.height - 40 * XLEN) collectionViewLayout:layout];
    //_collectionView.backgroundColor = [UIColor colorWithRed:28/255. green:49/255. blue:58/255. alpha:0.6];
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView setContentInset:UIEdgeInsetsMake(10 * XLEN, 20 * XLEN, 0, 20 * XLEN)];
    [self addSubview:self.collectionView];
    
    //collectionViewCell在使用之前 必须先注册重用池
    [self.collectionView registerClass:[LMSMusicMenuCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
