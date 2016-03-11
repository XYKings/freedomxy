//
//  LMSMusicListModel.h
//  Freedom
//
//  Created by dllo on 16/1/21.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import "LMSBaseModel.h"

@interface LMSMusicListModel : LMSBaseModel

@property (nonatomic, copy) NSString *pic_url;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *quan_id;
@property (nonatomic, copy) NSString *listen_count;
@property (nonatomic, copy) NSString *desc;

@property(nonatomic,assign)NSInteger number;

@end
