//
//  LMSDiscoverTableViewCell.h
//  Freedom
//
//  Created by dllo on 16/1/21.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LMSDiscoverModel;

@interface LMSDiscoverTableViewCell : UITableViewCell

@property(nonatomic,retain)UIImageView *findImageView;
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)UILabel *briefLabel;

-(void)findDataInfo:(LMSDiscoverModel *)model;
//-(void)radioDataInfo:(RadioModel *)model;

@end
