//
//  LMSMusicListView.m
//  Freedom
//
//  Created by dllo on 16/1/21.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import "LMSMusicListView.h"

@implementation LMSMusicListView


-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    //标题
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 80, 200, 30)];
    _titleLabel.font = [UIFont systemFontOfSize:18];
    _titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:_titleLabel];
    //简介
    _descLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 110, 300, 20)];
    _descLabel.font = [UIFont systemFontOfSize:13];
    _descLabel.textColor = [UIColor lightTextColor];
    [self addSubview:_descLabel];
    
    UIImageView *headsetImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 130, 25, 25)];
    headsetImageView.image = [UIImage imageNamed:@"erji.png"];
    [self addSubview:headsetImageView];
    
    _listenCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(45, 130, 80, 20)];
    _listenCountLabel.textColor = [UIColor lightTextColor];
    [self addSubview:_listenCountLabel];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
