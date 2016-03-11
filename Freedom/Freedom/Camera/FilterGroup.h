//
//  FilterGroup.h
//  SYCaremaDemo
//
//  Created by dllo on 16/1/14.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <GPUImageFilterGroup.h>

@interface GPUImageFilterGroup(addTitleColor)
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIColor *color;

@end
