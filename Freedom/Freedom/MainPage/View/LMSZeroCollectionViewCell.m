//
//  LMSZeroCollectionViewCell.m
//  Freedom
//
//  Created by dllo on 16/1/19.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import "LMSZeroCollectionViewCell.h"

@implementation LMSZeroCollectionViewCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.image = [UIImage imageNamed:@"musicpic"];
    [self.contentView addSubview:self.imageView];
    
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor lightGrayColor];
    self.titleLabel.text = @"排行榜";
    
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(WIDTH / 8 - 1 - WIDTH / 16, WIDTH / 32, WIDTH / 8, WIDTH / 8);
      self.titleLabel.frame = CGRectMake(WIDTH / 8 - 1 - WIDTH / 8, WIDTH * 5 / 32, WIDTH / 4, WIDTH / 16);
    
}


@end
