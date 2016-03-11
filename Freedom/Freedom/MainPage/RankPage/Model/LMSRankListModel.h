//
//  LMSRankListModel.h
//  Freedom
//
//  Created by dllo on 16/1/21.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import "LMSBaseModel.h"

@interface LMSRankListModel : LMSBaseModel

@property(nonatomic,copy)NSString *ranklist_id;//榜单详情id
@property(nonatomic,copy)NSString *rankName;//榜单名(单独赋值)
@property(nonatomic,copy)NSString *title;//标题
@property(nonatomic,copy)NSString *sub_title;//副标题
@property(nonatomic,copy)NSString *song_count;
@property(nonatomic,copy)NSString *name;//歌曲名
@property(nonatomic,copy)NSString *singerName;
@property(nonatomic,copy)NSString *pic;
@property(nonatomic,copy)NSString *desc;

@end
