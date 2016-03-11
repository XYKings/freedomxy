//
//  LMSBaseModel.m
//  Freedom
//
//  Created by dllo on 16/1/12.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import "LMSBaseModel.h"

@implementation LMSBaseModel

//    通过字典自定义初始化
- (instancetype)initWithDictionary:(NSMutableDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
//    通过字典取值传回Model(便利构造器)
+ (instancetype)baseModelWithDictionary:(NSMutableDictionary *)dic
{
    id model = [[[self class] alloc] initWithDictionary:dic];
    return model;
}
//    通过数组取值传到新的数组并传回(便利构造器)
+ (NSMutableArray *)baseModelWithArray:(NSMutableArray *)arr
{
    NSMutableArray *array = [NSMutableArray array];
    //    数组中获取字典并赋值给Model
    for (NSMutableDictionary *dic in arr) {
        @autoreleasepool {
            // 通过便利构造器方式创建对象.
            id model = [[self class] baseModelWithDictionary:dic];
            // 把对象添加到数组中
            [array addObject:model];
        }
    }
    return array;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
//    [super setValue:value forUndefinedKey:key];
    if ([key isEqualToString:@"id"]) {
        
        self.mId = value;
    }
    
}

@end
