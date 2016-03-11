//
//  LMSMusicInfo.m
//  Freedom
//
//  Created by dllo on 16/1/15.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import "LMSMusicInfo.h"
#import "LMSAuditionList.h"

@implementation LMSMusicInfo


////只进一次
//-(instancetype)init
//{
//    self = [super init];
//    if (self) {
//        //实例化时间歌词的数组
//        self.timeForLyric = [NSMutableArray new];
//    }
//    return self;
//}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
    if ([key isEqual:@"auditionList"]) {
        self.duration = [[value objectAtIndex:0] objectForKey:@"duration"];
        self.auditionList = [LMSAuditionList baseModelWithArray:value];
    }
    if ([key isEqual:@"llList"]) {
        if (NULL != value) {
            for (NSMutableDictionary *dic in value) {
                LMSAuditionList *audition = [LMSAuditionList baseModelWithDictionary:dic];
                [self.auditionList addObject:audition];
            }
        }
    }
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
//    NSLog(<#NSString * _Nonnull format, ...#>)

}



@end
