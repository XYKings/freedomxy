//
//  LMS_MVLookTableViewCell.m
//  Freedom
//
//  Created by dllo on 16/1/21.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import "LMS_MVLookTableViewCell.h"

@implementation LMS_MVLookTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self createCell];
    }
    return self;
}

- (void)createCell {
    
    self.monthL = [[UILabel alloc] initWithFrame:CGRectMake(15, 3, 35, 30)];
    self.monthL.font = [UIFont boldSystemFontOfSize:25];
    self.monthL.textColor = [UIColor colorWithRed:1.000 green:0.267 blue:0.559 alpha:1.000];
    [self addSubview:self.monthL];
    
    UIView *grayV = [[UIView alloc] initWithFrame:CGRectMake(15, 34, 30, 1)];
    grayV.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:grayV];
    
    self.dayL = [[UILabel alloc] initWithFrame:CGRectMake(20, 36, 20, 20)];
    self.dayL.font = [UIFont systemFontOfSize:15];
    self.dayL.textAlignment = NSTextAlignmentCenter;
    self.dayL.textColor = [UIColor lightGrayColor];
    [self addSubview:self.dayL];
    
    self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 60, WIDTH - 20, 170)];
    [self addSubview:self.imageV];
    self.titleL = [[UILabel alloc] initWithFrame:CGRectMake(54, 7, WIDTH - 60, 50)];
    self.titleL.font = [UIFont systemFontOfSize:16];
    self.titleL.numberOfLines = 2;
    self.titleL.textColor = [UIColor grayColor];
    [self addSubview:self.titleL];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 74, 74)];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 37;
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.4;
    view.center = self.imageV.center;
    [self addSubview:view];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    imageV.center = CGPointMake(self.imageV.center.x + 4, self.imageV.center.y);
    imageV.image = [UIImage imageNamed:@"大播放"];
    [self addSubview:imageV];
}

@end
