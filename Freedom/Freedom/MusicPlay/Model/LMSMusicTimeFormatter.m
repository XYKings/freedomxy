//
//  LMSMusicTimeFormatter.m
//  Freedom
//
//  Created by dllo on 16/1/15.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import "LMSMusicTimeFormatter.h"

@implementation LMSMusicTimeFormatter

// 格式化后的字符串
+ (NSString *)getStringFormatBySeconds:(float)seconds{
    // 格式化时间 从浮点类型转换成"00:00"字符串
    NSString *formatTime = [NSString stringWithFormat:@"%02ld:%02ld",(NSInteger)seconds / 60,(NSInteger)seconds % 60];
    return formatTime;
}

+ (float)getSecondsFormatByString:(NSString *)string{
    NSArray *tempArr = [string componentsSeparatedByString:@":"];
    return [[tempArr firstObject]integerValue] * 60.0 + [[tempArr lastObject]integerValue];
}

@end
