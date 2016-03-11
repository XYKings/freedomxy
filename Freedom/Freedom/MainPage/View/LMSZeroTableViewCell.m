//
//  LMSZeroTableViewCell.m
//  Freedom
//
//  Created by dllo on 16/1/19.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import "LMSZeroTableViewCell.h"
#import "LMSZeroCollectionViewCell.h"

@interface LMSZeroTableViewCell ()<UICollectionViewDataSource,UICollectionViewDelegate>

//    collectionView
@property (nonatomic, retain) UICollectionView *collectionView;

@end

@implementation LMSZeroTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    
    UICollectionViewFlowLayout *flowL = [[UICollectionViewFlowLayout alloc] init];
    flowL.minimumInteritemSpacing = 1;
    flowL.minimumLineSpacing = 1;
    flowL.itemSize = CGSizeMake((WIDTH - 9) / 4, (WIDTH - 9) / 4);
    flowL.sectionInset = UIEdgeInsetsMake(2, 2, 2, 2);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowL];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[LMSZeroCollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
    [self.contentView addSubview:self.collectionView];
    
}

#pragma mark collection方法
#pragma 选中跳转
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

        NSLog(@"点击第%ld 区第 %ld个cell", indexPath.section, indexPath.row);
}
#pragma item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}
#pragma collectionCell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LMSZeroCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    
    
    return cell;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
