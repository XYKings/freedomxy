//
//  LMS_VideoModel.h
//  Freedom
//
//  Created by dllo on 16/1/13.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import "LMSBaseModel.h"

@interface LMS_VideoModel : LMSBaseModel

@property (nonatomic, copy) NSString *songId;
@property (nonatomic, copy) NSString *singerId;
@property (nonatomic, copy) NSString *singerName;
@property (nonatomic, copy) NSString *videoName;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *songName;
@property (nonatomic, copy) NSString *contributor;
@property (nonatomic, copy) NSString *sourceId;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *praiseCount;
@property (nonatomic, copy) NSString *stepCount;
@property (nonatomic, copy) NSString *pickCount;
@property (nonatomic, copy) NSString *bulletCount;
@property (nonatomic, copy) NSString *releaseAt;
@property (nonatomic, copy) NSString *operatorType;
@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, retain) NSMutableArray *mvList;
@property (nonatomic, copy) NSString *commentCount;
@property (nonatomic, copy) NSString *pageCount;
@property (nonatomic, copy) NSString *totalCount;
@property (nonatomic, copy) NSString *page;
@property (nonatomic, copy) NSString *size;

@end
