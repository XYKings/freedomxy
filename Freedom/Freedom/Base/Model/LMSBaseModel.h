//
//  LMSBaseModel.h
//  Freedom
//
//  Created by dllo on 16/1/12.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMSBaseModel : NSObject

@property (nonatomic, copy) NSString *mId;

- (instancetype)initWithDictionary:(NSMutableDictionary *)dic;

+ (instancetype)baseModelWithDictionary:(NSMutableDictionary *)dic;

+ (NSMutableArray *)baseModelWithArray:(NSMutableArray *)arr;

@end
