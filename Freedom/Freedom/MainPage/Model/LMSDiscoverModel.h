//
//  LMSDiscoverModel.h
//  Freedom
//
//  Created by dllo on 16/1/19.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import "LMSBaseModel.h"

@interface LMSDiscoverModel : LMSBaseModel


@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, copy) NSString *reason;
@property (nonatomic, copy) NSString *sectionName;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *listenCount;
@property (nonatomic, copy) NSString *singerName;
@property (nonatomic, copy) NSString *url;//歌曲url
@property (nonatomic, retain) NSArray *auditionList;


@end
