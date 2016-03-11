//
//  CameraManager.h
//  SYCaremaDemo
//
//  Created by dllo on 16/1/14.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GPUImageFilterGroup;

//摄像头方向枚举
typedef NS_ENUM(NSUInteger, SYCameraDevicePosition) {
    SYDevicePositionBack,
    SYDevicePositionFront
};
//闪光灯状态枚举
typedef NS_ENUM(NSUInteger, SYCameraDeviceFlashModel) {
    SYCameraManagerFlashModeAuto,
    SYCameraManagerFlashModeOff,
    SYCameraManagerFlashModeOn
};

@interface CameraManager : NSObject

@property (nonatomic, assign) SYCameraDevicePosition syposition;
@property (nonatomic, assign) SYCameraDeviceFlashModel syflashModel;

- (id)initWithFrame:(CGRect)frame superview:(UIView *)superview;

// 设置对焦的图片
- (void)setFocusImage:(UIImage *)focusImage;

- (void)startCamera;

- (void)stopCamera;

- (void)takePhotoSuccess:(void(^)(UIImage *image))success
                 failure:(void(^)(void))failure;

- (void)addFilters:(NSArray *)filters;

- (void)setFilterAtIndex:(NSInteger)index;

@end
