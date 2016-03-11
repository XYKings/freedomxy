//
//  CameraFIlters.m
//  SYCaremaDemo
//
//  Created by dllo on 16/1/14.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "CameraFIlters.h"
#import "FilterGroup.h"

@implementation CameraFIlters

+ (GPUImageFilterGroup *)normal {
    GPUImageFilter *filter = [[GPUImageFilter alloc] init];
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [(GPUImageFilterGroup *)group setInitialFilters:[NSArray arrayWithObject:filter]];
    [(GPUImageFilterGroup *)group setTerminalFilter:filter];
    group.title = @"普通";
    group.color = [UIColor blackColor];
    return group;
}
+ (GPUImageFilterGroup *)saturation {
    GPUImageSaturationFilter *filter = [[GPUImageSaturationFilter alloc] init]; //饱和度
    filter.saturation = 2.0f;
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [(GPUImageFilterGroup *) group setInitialFilters:[NSArray arrayWithObject: filter]];
    [(GPUImageFilterGroup *) group setTerminalFilter:filter];
    group.title = @"古典";
    group.color = [UIColor blueColor];
    return group;
}


+ (GPUImageFilterGroup *)exposure {
    GPUImageExposureFilter *filter = [[GPUImageExposureFilter alloc] init]; //曝光
    filter.exposure = 1.0f;
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [(GPUImageFilterGroup *) group setInitialFilters:[NSArray arrayWithObject: filter]];
    [(GPUImageFilterGroup *) group setTerminalFilter:filter];
    group.title = @"强光";
    group.color = [UIColor greenColor];
    return group;
}

+ (GPUImageFilterGroup *)contrast {
    GPUImageContrastFilter *filter = [[GPUImageContrastFilter alloc] init]; //对比度
    filter.contrast = 2.0f;
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [(GPUImageFilterGroup *) group setInitialFilters:[NSArray arrayWithObject: filter]];
    [(GPUImageFilterGroup *) group setTerminalFilter:filter];
    group.title = @"对比度";
    group.color = [UIColor redColor];
    return group;
}

+ (GPUImageFilterGroup *)testGroup {
    GPUImageFilterGroup *filters = [[GPUImageFilterGroup alloc] init];
    
    GPUImageExposureFilter *filter1 = [[GPUImageExposureFilter alloc] init]; //曝光
    filter1.exposure = 0.0f;
    GPUImageSaturationFilter *filter2 = [[GPUImageSaturationFilter alloc] init]; //饱和度
    filter2.saturation = 2.0f;
    GPUImageContrastFilter *filter3 = [[GPUImageContrastFilter alloc] init]; //对比度
    filter3.contrast = 2.0f;
    
    [filter1 addTarget:filter2];
    [filter2 addTarget:filter3];
    
    [(GPUImageFilterGroup *) filters setInitialFilters:[NSArray arrayWithObject: filter1]];
    [(GPUImageFilterGroup *) filters setTerminalFilter:filter3];
    filters.title = @"组合";
    filters.color = [UIColor yellowColor];
    return filters;
}

/******************************************************************************************************/

+ (GPUImageFilterGroup *)dianyatexiao {
    GPUImageSoftEleganceFilter *dianya = [[GPUImageSoftEleganceFilter alloc] init];
    dianya.title = @"典雅";
    return dianya;
}

+ (GPUImageFilterGroup *)shuangbianmohu {
    GPUImageBilateralFilter *bilate = [[GPUImageBilateralFilter alloc] init];
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [group addFilter:bilate];
    return group;
}

+ (GPUImageFilterGroup *)fudiaotexiao {
    GPUImageEmbossFilter *fudiao = [[GPUImageEmbossFilter alloc] init];
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [group addFilter:fudiao];
    return group;

}

+ (GPUImageFilterGroup *)sumiaotexiao {
    GPUImageSketchFilter *sumiao = [[GPUImageSketchFilter alloc] init];
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [group addFilter:sumiao];
    return group;
}

+ (GPUImageFilterGroup *)ruihuatexiao {
    GPUImageSharpenFilter *ruihua = [[GPUImageSharpenFilter alloc] init];
    ruihua.sharpness = 0.5;
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [group addFilter:ruihua];
    return group;
}

+ (GPUImageFilterGroup *)shenhesetexiao {
    GPUImageSepiaFilter *shenhese = [[GPUImageSepiaFilter alloc] init];
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [group addFilter:shenhese];
    return group;
}
@end
