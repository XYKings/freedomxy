//
//  LMS_MusicList_TableViewCell.m
//  Freedom
//
//  Created by dllo on 16/1/21.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import "LMS_MusicList_TableViewCell.h"
#import "LMSMusicInfo.h"


@interface LMS_MusicList_TableViewCell ()


@end


@implementation LMS_MusicList_TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    self.musicPic = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 70, 70)];
    self.musicPic.layer.masksToBounds = YES;
    self.musicPic.layer.cornerRadius = 35;
    self.musicName = [[UILabel alloc] initWithFrame:CGRectMake(85, 5, 150, 30)];
    self.singerName = [[UILabel alloc] initWithFrame:CGRectMake(85, 40, 150, 30)];
    
    [self.contentView addSubview:self.musicName];
    [self.contentView addSubview:self.musicPic];
    [self.contentView addSubview:self.singerName];
    
//    //音乐名称Lable赋值
//    self.musicName.text = musicInfo.name;
//    //歌手名称Lable赋值
//    self.singerName.text = musicInfo.singer;
//    //使用第三方加载图片
//    [self.musicPic sd_setImageWithURL:[NSURL URLWithString:musicInfo.picUrl]placeholderImage:[UIImage imageNamed:@"musicpic"]];
//    self.musicPic.layer.cornerRadius = self.musicPic.frame.size.width / 2;
//    self.musicPic.clipsToBounds = YES;

}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
