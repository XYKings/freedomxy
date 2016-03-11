//
//  LMS_MusicPlay_ViewController.h
//  Freedom
//
//  Created by dllo on 16/1/12.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import "LMSBaseViewController.h"

typedef enum : NSUInteger {
    LMSAudioPlayTypeCircle,  //循环播放
    LMSAudioPlayTypeRandom,  //随机播放
    LMSAudioPlayTypeOneMusic,//单曲循环
//    LMSAudioPlayTypeNoNext,  //播完就不播了
} LMSAudioPlayType;

@interface LMS_MusicPlay_ViewController : LMSBaseViewController

@property (nonatomic, retain) NSNumber *songID;

@property (nonatomic, assign) NSInteger musicIndex;

+ (instancetype)musicPlay;

@end
