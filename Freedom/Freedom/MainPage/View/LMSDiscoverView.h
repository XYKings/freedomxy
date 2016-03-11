//
//  LMSDiscoverView.h
//  Freedom
//
//  Created by dllo on 16/1/19.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import "LMSBaseView.h"
#import <SDCycleScrollView.h>

@interface LMSDiscoverView : LMSBaseView

@property(nonatomic,retain)UITableView *findTableView;
@property(nonatomic,retain)SDCycleScrollView *cycleView;
@property(nonatomic,retain)UIView *sortView;//快捷分类
@property(nonatomic,retain)UIImageView *rankImageView;
@property(nonatomic,retain)UIImageView *listImageView;
@property(nonatomic,retain)UIImageView *radioImageView;
@property(nonatomic,retain)UIImageView *singerImageView;
@property(nonatomic,retain)UILabel *rangLabel;
@property(nonatomic,retain)UILabel *listLabel;
@property(nonatomic,retain)UILabel *radioLabel;
@property(nonatomic,retain)UILabel *singerLabel;


@end
