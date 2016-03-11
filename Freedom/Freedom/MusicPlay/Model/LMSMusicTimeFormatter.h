//
//  LMSMusicTimeFormatter.h
//  Freedom
//
//  Created by dllo on 16/1/15.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMSMusicTimeFormatter : NSObject

// 这是一个工具类 专门将时间秒数转化为字符串 和 将字符串转化为时间秒数
/*
 将时间秒数转换为格式化后的字符串
 */
+ (NSString *)getStringFormatBySeconds:(float)seconds;
/*
 将格式化后的字符串转化为时间秒数
 */
+ (float)getSecondsFormatByString:(NSString *)string;

@end
