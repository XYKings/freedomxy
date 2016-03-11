//
//  LMS_PlayerView.m
//  Freedom
//
//  Created by dllo on 16/1/13.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import "LMS_PlayerView.h"

@implementation LMS_PlayerView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

// 把PlayerView默认的CALayer转变成AVPlayerLayer
+ (Class)layerClass {
    
    return [AVPlayerLayer class];
}

// 重写初始化方法
- (AVPlayer *)player {
    
    return [(AVPlayerLayer *)[self layer] player];
}

// 重写set方法
- (void)setPlayer:(AVPlayer *)player {
    
    [(AVPlayerLayer *)[self layer] setPlayer:player];
}

@end

