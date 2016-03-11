//
//  LMSMusicInfo.h
//  Freedom
//
//  Created by dllo on 16/1/15.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import "LMSBaseModel.h"
@class LMSAuditionList;

@interface LMSMusicInfo : LMSBaseModel
//    歌曲ID
@property (nonatomic, retain) NSNumber *songId;
//    歌曲名字
@property (nonatomic, retain) NSString *name;
//    singerID
@property (nonatomic, retain) NSNumber *singerId;
//    歌手名字
@property (nonatomic, retain) NSString *singerName;
//     专辑ID
@property (nonatomic, retain) NSNumber *albumId;
//    专辑名字
@property (nonatomic, retain) NSString *albumName;
//    专辑图片
@property (nonatomic, retain) NSString *picUrl;
//    歌曲时间
@property (nonatomic, retain) NSNumber *duration;
//    歌曲列表
@property (nonatomic, retain) NSMutableArray *auditionList;


@property (nonatomic, strong) NSString * mp3Url;       // 歌曲的Url
@property (nonatomic, strong) NSString * ID;           // 歌曲的id
//@property (nonatomic, strong) NSString * name;         // 歌曲的名称
//@property (nonatomic, strong) NSString * picUrl;       // 歌曲的图片Url
@property (nonatomic, strong) NSString * blurPicUrl;   // 歌曲的模糊图片Url
@property (nonatomic, strong) NSString * album;        // 歌曲的专辑
@property (nonatomic, strong) NSString * singer;       // 歌曲的歌手
//@property (nonatomic, strong) NSString * duration;     // 歌曲的时长
@property (nonatomic, strong) NSString * artists_name; // 歌曲的作者
@property (nonatomic, strong) NSMutableArray * timeForLyric;  // 时间对应的歌词


@end
