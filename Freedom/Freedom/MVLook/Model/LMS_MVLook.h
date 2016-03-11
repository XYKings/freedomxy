//
//  LMS_MVLook.h
//  Freedom
//
//  Created by dllo on 16/1/21.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import "LMSBaseModel.h"

@interface LMS_MVLook : LMSBaseModel

@property (nonatomic, copy) NSString *channelId;
@property (nonatomic, copy) NSString *videoName;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *bigPicUrl;
@property (nonatomic, copy) NSString *singerName;
@property (nonatomic, copy) NSString *singId;
@property (nonatomic, copy) NSString *songId;
@property (nonatomic, copy) NSString *songName;
@property (nonatomic, copy) NSString *praiseCount;
@property (nonatomic, copy) NSString *stepCount;
@property (nonatomic, copy) NSString *pickCount;
@property (nonatomic, copy) NSString *bulletCount;
@property (nonatomic, copy) NSString *shareCount;
@property (nonatomic, copy) NSString *operatorType;
@property (nonatomic, retain) NSMutableArray *mvList;

@end
