//
//  SelectCollectionViewCell.m
//  STSFreeTime
//
//  Created by dllo on 16/1/12.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "SelectCollectionViewCell.h"
#import <GPUImage.h>

@implementation SelectCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubView];
    }
    return self;
}

- (void)createSubView {
    self.smallCameraView = [[GPUImageView alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width - 10, self.frame.size.height - 10)];
    self.smallCameraView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill;
    [self.contentView addSubview:self.smallCameraView];
}

@end
