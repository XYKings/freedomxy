//
//  LMS_MVTableViewCell.m
//  Freedom
//
//  Created by dllo on 16/1/15.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import "LMS_MVTableViewCell.h"
#import <Masonry.h>

@implementation LMS_MVTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self createCell];
    }
    return self;
}

- (void)createCell {
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.imageV = [[UIImageView alloc] init];
    self.imageV.frame = CGRectMake(0, 0, 180, 110);
    self.imageV.center = CGPointMake(95, 60);
    [self addSubview:self.imageV];
    
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(self.imageV.frame.size.width - 50, self.imageV.frame.size.height - 17, 48, 15)];
    grayView.backgroundColor = [UIColor blackColor];
    grayView.alpha = 0.3;
    [self.imageV addSubview:grayView];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, grayView.frame.size.width, 15)];
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.textColor = [UIColor whiteColor];
    self.timeLabel.center = grayView.center;
    [self.imageV addSubview:self.timeLabel];
    
    self.mvName = [[UILabel alloc] initWithFrame:CGRectMake(self.imageV.frame.origin.x + self.imageV.frame.size.width + 8, 10, 166, 30)];
    self.mvName.textColor = [UIColor colorWithRed:1.000 green:0.252 blue:0.542 alpha:1.000];
    self.mvName.font = [UIFont systemFontOfSize:17];
    [self addSubview:self.mvName];
    
    self.singerName = [[UILabel alloc] initWithFrame:CGRectMake(self.mvName.frame.origin.x, self.mvName.frame.origin.y + self.mvName.frame.size.height + 7, self.mvName.frame.size.width, self.mvName.frame.size.height)];
    self.singerName.font = [UIFont systemFontOfSize:15];
    self.singerName.textColor = [UIColor grayColor];
    [self addSubview:self.singerName];
    
    UIImageView *pickView = [[UIImageView alloc] init];
    pickView.frame = CGRectMake(self.mvName.frame.origin.x + 12, 92, 20, 20);
    pickView.image = [UIImage imageNamed:@"iconfont-shipin-3"];
    [self addSubview:pickView];
    
    self.pickCount = [[UILabel alloc] initWithFrame:CGRectMake(pickView.frame.origin.x + pickView.frame.size.width + 7, pickView.frame.origin.y, 50, 22)];
    self.pickCount.textColor = [UIColor colorWithRed:1.000 green:0.252 blue:0.542 alpha:1.000];
    self.pickCount.font = [UIFont systemFontOfSize:13];
    [self addSubview:self.pickCount];
    
    UIImageView *bulletView = [[UIImageView alloc] init];
    bulletView.frame = CGRectMake(self.pickCount.frame.origin.x + self.pickCount.frame.size.width + 3, 92, 22, 22);
    bulletView.image = [UIImage imageNamed:@"iconfont-pinglun-2"];
    [self addSubview:bulletView];
    
    self.bulletCount = [[UILabel alloc] initWithFrame:CGRectMake(bulletView.frame.origin.x + bulletView.frame.size.width + 7, pickView.frame.origin.y, 50, 22)];
    self.bulletCount.textColor = [UIColor colorWithRed:1.000 green:0.252 blue:0.542 alpha:1.000];
    self.bulletCount.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.bulletCount];
}

@end
