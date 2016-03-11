//
//  ReviseVIewCell.m
//  SYCaremaDemo
//
//  Created by dllo on 16/1/18.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ReviseVIewCell.h"

@implementation ReviseVIewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createCell];
    }
    return self;
}

- (void)createCell {
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 15);
    [self addSubview:self.button];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 15, self.frame.size.width, 15)];
    self.label.font = [UIFont systemFontOfSize:14.0];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.textColor = COLORSTYLE;
    [self addSubview:self.label];
}
@end
