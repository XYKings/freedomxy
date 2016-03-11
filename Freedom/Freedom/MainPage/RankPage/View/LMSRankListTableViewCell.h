//
//  LMSRankListTableViewCell.h
//  Freedom
//
//  Created by dllo on 16/1/21.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LMSRankListModel;

@interface LMSRankListTableViewCell : UITableViewCell

@property(nonatomic,retain)UIImageView *rankListImageView;
@property(nonatomic,retain)UILabel *rankListLabel;
@property(nonatomic,retain)UILabel *songLabel1;
@property(nonatomic,retain)UILabel *songLabel2;
@property(nonatomic,retain)UILabel *songLabel3;

-(void)rankListInfo:(LMSRankListModel *)model;

@end
