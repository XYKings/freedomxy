//
//  CameraFIlters.h
//  SYCaremaDemo
//
//  Created by dllo on 16/1/14.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <GPUImage.h>

@interface CameraFIlters : NSObject
+ (GPUImageFilterGroup *)normal;

+ (GPUImageFilterGroup *)saturation;

+ (GPUImageFilterGroup *)exposure;

+ (GPUImageFilterGroup *)contrast;

+ (GPUImageFilterGroup *)testGroup;

+ (GPUImageFilterGroup *)dianyatexiao;

+ (GPUImageFilterGroup *)shuangbianmohu;

+ (GPUImageFilterGroup *)fudiaotexiao;

+ (GPUImageFilterGroup *)sumiaotexiao;

+ (GPUImageFilterGroup *)ruihuatexiao;

+ (GPUImageFilterGroup *)shenhesetexiao;


@end
