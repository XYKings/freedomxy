//
//  LMSMusicListViewController.h
//  Freedom
//
//  Created by dllo on 16/1/21.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import "LMSBaseViewController.h"
@class LMSDiscoverModel;
@class LMSRankListModel;

@class LMSMusicListView;
@class LMSMusicListModel;

@interface LMSMusicListViewController : LMSBaseViewController

@property (nonatomic, retain) LMSDiscoverModel *songListModel;//发现页面
@property (nonatomic, retain) LMSRankListModel *rankModel;//榜单页面
@property (nonatomic, retain) LMSMusicListModel *listModel;
@property (nonatomic, retain) LMSMusicListView *titleView;

@end
