//
//  LMS_MusicList_TableViewCell.h
//  Freedom
//
//  Created by dllo on 16/1/21.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LMSMusicInfo;


@interface LMS_MusicList_TableViewCell : UITableViewCell

@property (nonatomic, retain) UIImageView *musicPic;
@property (nonatomic, retain) UILabel *musicName;
@property (nonatomic, retain) UILabel *singerName;

-(void)setCellWithMusicInfo:(LMSMusicInfo *)musicInfo;

@end
