//
//  LMSMusicMenuCollectionViewCell.m
//  Freedom
//
//  Created by dllo on 16/1/21.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import "LMSMusicMenuCollectionViewCell.h"

@implementation LMSMusicMenuCollectionViewCell

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    self.imageView = [[UIImageView alloc]init];
    self.imageView.layer.cornerRadius = 10;
    self.imageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.imageView];
    
    _label = [[UILabel alloc]init];
    _label.font = [UIFont systemFontOfSize:16];
    _label.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_label];
}

//布局frame
-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    _imageView.frame = CGRectMake(0, 0, layoutAttributes.size.width, layoutAttributes.size.height - 40);
    
    _label.frame = CGRectMake(0, _imageView.frame.size.width + 5, layoutAttributes.size.width, 30);
}


@end
