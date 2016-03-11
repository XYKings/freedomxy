//
//  LMS_SearchPageCollectionViewCell.m
//  Freedom
//
//  Created by dllo on 16/1/18.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import "LMS_SearchPageCollectionViewCell.h"
#import "LMS_MVTableViewCell.h"
#import "LMS_MVModel.h"
#import "LMS_VideoModel.h"
#import <UIImageView+WebCache.h>

@interface LMS_SearchPageCollectionViewCell() <UITableViewDataSource, UITableViewDelegate> {
    
    NSDateFormatter *_dateFormatter;
}

@property (nonatomic, retain) UITableView *tableV;

@end

@implementation LMS_SearchPageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createCell];
    }
    return self;
}

- (void)createCell {
    
    self.backgroundColor = [UIColor whiteColor];
    [self createTableView];
}

#pragma 创建tableView
- (void)createTableView {
    
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.frame.size.height - 64)];
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self addSubview:self.tableV];
}

#pragma 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.row == 0) {
        
        return [self.dic[@"song"] count];
    }
    else if (self.row == 1) {
        
        return [self.dic[@"singer"] count];
    }
    else if (self.row == 2) {
        
        return [self.dic[@"album"] count];
    }
    else {
        
        return [self.dic[@"mv"] count];
    }
}

#pragma 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120;
}

#pragma cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 单曲
    if (self.row == 0) {
        
        static NSString *cellStr = @"songCell";
        UITableViewCell *mvCell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        if (mvCell == nil) {
            
            mvCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        }
        
        return mvCell;
 
    }
    // 歌手
    else if (self.row == 1) {
        
        static NSString *cellStr = @"singerCell";
        UITableViewCell *mvCell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        if (mvCell == nil) {
            
            mvCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        }
        
        return mvCell;
    }
    // 专辑
    else if (self.row == 2) {
        
        static NSString *cellStr = @"albumCell";
        UITableViewCell *mvCell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        if (mvCell == nil) {
            
            mvCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        }
        
        return mvCell;
    }
    // MV
    else {
        LMS_VideoModel *video = [self.dic[@"mv"] objectAtIndex:indexPath.row];
        LMS_MVModel *mv = [video.mvList firstObject];
        static NSString *cellStr = @"mvCell";
        LMS_MVTableViewCell *mvCell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        if (mvCell == nil) {
            
            mvCell = [[LMS_MVTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        }
        [mvCell.imageV sd_setImageWithURL:[NSURL URLWithString:mv.picUrl] placeholderImage:[UIImage imageNamed:@"图片载入失败icon"]];
        mvCell.mvName.text = video.videoName;
        mvCell.singerName.text = video.singerName;
        mvCell.bulletCount.text = [NSString stringWithFormat:@"%@", video.bulletCount];
        mvCell.pickCount.text = [NSString stringWithFormat:@"%@", video.pickCount];
        mvCell.timeLabel.text = [self convertTime:[mv.duration floatValue] / 1000];
        mvCell.selectionStyle = UITableViewCellSelectionStyleNone;

        return mvCell;
    }
}

#pragma 转换成播放的时间格式
- (NSString *)convertTime:(CGFloat)second{
    
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    if (second / 3600 >= 1) {
        
        [[self dateFormatter] setDateFormat:@"HH:mm:ss"];
    } else {
        
        [[self dateFormatter] setDateFormat:@"mm:ss"];
    }
    NSString *showtimeNew = [[self dateFormatter] stringFromDate:d];
    return showtimeNew;
}

- (NSDateFormatter *)dateFormatter {
    
    if (!_dateFormatter) {
        
        _dateFormatter = [[NSDateFormatter alloc] init];
    }
    return _dateFormatter;
}

#pragma 跳转播放
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LMS_VideoModel *video = [self.dic[@"mv"] objectAtIndex:indexPath.row];
    [self.delegate playMV:video.mId];
}

#pragma 重写set方法
- (void)setRow:(NSInteger)row {
    
    if (_row != row) {

        _row = row;
    }
    [self.tableV reloadData];
}

- (void)setDic:(NSMutableDictionary *)dic {
    
    if (_dic != dic) {
        
        _dic = dic;
    }
    [self.tableV reloadData];
}


@end
