//
//  LMSDiscoverView.m
//  Freedom
//
//  Created by dllo on 16/1/19.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import "LMSDiscoverView.h"

#define LEN 40
#define DISTANCE 45//间距
#define xLen (self.frame.size.width - 4 * LEN - 3 * DISTANCE)/2

@implementation LMSDiscoverView


-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    self. findTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
    
    //_findTableView.backgroundColor = [UIColor clearColor];
    //取消分割线
    self. findTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self addSubview:self. findTableView];
    //把轮播图和快捷分类放到一个View上，再把View放到_findTableView的header
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self. findTableView.frame.size.width, 230)];
    self. cycleView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, self. findTableView.frame.size.width, 150)];
    [headerView addSubview:self. cycleView];
    self. sortView = [[UIView alloc]initWithFrame:CGRectMake(0, self. cycleView.frame.size.height, self. findTableView.frame.size.width, headerView.frame.size.height - self. cycleView.frame.size.height)];
    //排行榜
    self. rankImageView = [[UIImageView alloc]initWithFrame:CGRectMake(xLen, 10, LEN, LEN)];
    self. rankImageView.userInteractionEnabled = YES;
    [self. sortView addSubview:self. rankImageView];
    
    self. rangLabel = [[UILabel alloc]initWithFrame:CGRectMake(xLen, LEN, LEN + 10, LEN)];
    self. rangLabel.font = [UIFont systemFontOfSize:14];
    [self. sortView addSubview:self. rangLabel];
    //歌单
    self. listImageView = [[UIImageView alloc]initWithFrame:CGRectMake(xLen + LEN + DISTANCE, 10, LEN, LEN)];
    self. listImageView.userInteractionEnabled = YES;
    [self. sortView addSubview:self. listImageView];
    
    self. listLabel = [[UILabel alloc]initWithFrame:CGRectMake(xLen + LEN + DISTANCE, LEN, LEN, LEN)];
    self. listLabel.textAlignment = NSTextAlignmentCenter;
    self. listLabel.font = [UIFont systemFontOfSize:14];
    [self. sortView addSubview:self. listLabel];
    //电台
    self. radioImageView = [[UIImageView alloc]initWithFrame:CGRectMake(xLen + (LEN + DISTANCE) * 2, 10, LEN, LEN)];
    self. radioImageView.userInteractionEnabled = YES;
    [self. sortView addSubview:self. radioImageView];
    
    self. radioLabel = [[UILabel alloc]initWithFrame:CGRectMake(xLen + (LEN + DISTANCE) * 2, LEN, LEN, LEN)];
    self. radioLabel.textAlignment = NSTextAlignmentCenter;
    self. radioLabel.font = [UIFont systemFontOfSize:14];
    [self. sortView addSubview:self. radioLabel];
    //歌手
    self. singerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(xLen + (LEN + DISTANCE) * 3, 10, LEN, LEN)];
    [self. sortView addSubview:self. singerImageView];
    
    self. singerLabel = [[UILabel alloc]initWithFrame:CGRectMake(xLen + (LEN + DISTANCE) * 3, LEN, LEN, LEN)];
    self. singerLabel.textAlignment = NSTextAlignmentCenter;
    self. singerLabel.font = [UIFont systemFontOfSize:14];
    self. singerImageView.userInteractionEnabled = YES;
    [self. sortView addSubview:self. singerLabel];
    
    [headerView addSubview:self. sortView];
    [self. findTableView setTableHeaderView:headerView];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
