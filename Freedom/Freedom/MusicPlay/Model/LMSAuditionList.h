//
//  LMSAuditionList.h
//  Freedom
//
//  Created by dllo on 16/1/15.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import "LMSBaseModel.h"

@interface LMSAuditionList : LMSBaseModel
//    位
@property (nonatomic, retain) NSNumber *bitRate;
//    大小
@property (nonatomic, retain) NSNumber *size;
//    类型
@property (nonatomic, retain) NSString *suffix;
//    url
@property (nonatomic, retain) NSString *url;
//    音乐品质类型
@property (nonatomic, retain) NSString *typeDescription;


@end
