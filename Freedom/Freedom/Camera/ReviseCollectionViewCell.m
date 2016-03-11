//
//  ReviseCollectionViewCell.m
//  SYCaremaDemo
//
//  Created by dllo on 16/1/16.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ReviseCollectionViewCell.h"

@implementation ReviseCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubview];
    }
    return self;
}

- (void)createSubview {
    self.photo = [[UIImageView alloc] initWithFrame:self.frame];
    [self.contentView addSubview:self.photo];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.photo.frame.size.height - 15, self.photo.frame.size.width, 15)];
    [self.photo addSubview:self.label];
}
@end
