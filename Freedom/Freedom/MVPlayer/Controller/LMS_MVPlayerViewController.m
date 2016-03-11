//
//  LMS_MVPlayerViewController.m
//  Freedom
//
//  Created by dllo on 16/1/13.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import "LMS_MVPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Masonry.h>
#import "LMSAFNetTool.h"
#import "LMS_MVModel.h"
#import "LMS_VideoModel.h"
#import "LMS_PlayerView.h"
#import "LMS_MVTableViewCell.h"
#import <UIImageView+WebCache.h>

// 播放器高度
#define PLAYER_HEIGHT 214
#define customColor [UIColor colorWithRed:1.000 green:0.534 blue:0.723 alpha:1.000]

@interface LMS_MVPlayerViewController () <UITableViewDataSource, UITableViewDelegate> {
    
    BOOL _full;
    BOOL _temp;
    BOOL _played;
    NSDateFormatter *_dateFormatter;
}

@property (nonatomic, copy) NSString *direction;
@property (nonatomic, retain) AVPlayer *player;
@property (nonatomic, retain) UITableView *tableV;
@property (nonatomic, retain) LMS_VideoModel *videoModel;
@property (nonatomic, retain) NSMutableArray *similarityArr;
@property (nonatomic, retain) LMS_PlayerView *playerView;
@property (nonatomic, retain) AVPlayerItem *playerItem;
@property (nonatomic, retain) id playbackTimeObserver;
@property (nonatomic, retain) UILabel *timeLabel;
@property (nonatomic, retain) UISlider *videoSlider;
@property (nonatomic, copy) NSString *totalTime;
@property (nonatomic, retain) UIProgressView *videoProgress;
@property (nonatomic, retain) UIView *workView;
@property (nonatomic, retain) UIButton *stateButton;
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain) UIButton *backButton;
@property (nonatomic, retain) UIView *tapView;

@end

@implementation LMS_MVPlayerViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _full = NO;
    _temp = NO;

    // 添加屏幕旋转通知
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleDeviceOrientationDidChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];

    [self createPlayView];
    [self createTableView];

    [self getSimilarityData];
    [self getMVData];
}

#pragma 获取MV数据
- (void)getMVData {
    
    [LMSAFNetTool getNetWithURL:[NSString stringWithFormat:@"http://api.dongting.com/song/video/%@", self.videoId] body:nil headFile:nil responseStyle:LMSJSON success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSMutableDictionary *dic = responseObject[@"data"];
        self.videoModel = [[LMS_VideoModel alloc] initWithDictionary:dic];
        self.videoModel.mvList = [NSMutableArray array];
        for (NSMutableDictionary *mvDic in dic[@"mvList"]) {
            
            LMS_MVModel *mvModel = [[LMS_MVModel alloc] initWithDictionary:mvDic];
            [self.videoModel.mvList addObject:mvModel];
        }
        
        LMS_MVModel *mvModel = [self.videoModel.mvList firstObject];
        [self createPlayer:mvModel.url];
        [self.tableV.tableHeaderView removeFromSuperview];
        [self createHeaderView];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

#pragma 获取相关MV数据
- (void)getSimilarityData {
    
    [LMSAFNetTool getNetWithURL:[NSString stringWithFormat:@"http://api.dongting.com/sim/mv/%@/similarity", self.videoId] body:nil headFile:nil responseStyle:LMSJSON success:^(NSURLSessionDataTask *task, id responseObject) {
        
        self.similarityArr = [NSMutableArray array];
        NSMutableArray *arr = responseObject[@"data"];
        for (NSMutableDictionary *dic in arr) {
            
            LMS_VideoModel *videoModel = [[LMS_VideoModel alloc] initWithDictionary:dic];
            videoModel.mvList = [NSMutableArray array];
            for (NSMutableDictionary *mvDic in dic[@"mvList"]) {
                
                LMS_MVModel *mvModel = [[LMS_MVModel alloc] initWithDictionary:mvDic];
                [videoModel.mvList addObject:mvModel];
            }
            [self.similarityArr addObject:videoModel];
        }
        [self.tableV reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma 创建播放器
- (void)createPlayer:(NSString *)mvUrl {

    NSURL *url = [NSURL URLWithString:mvUrl];
    self.playerItem = [AVPlayerItem playerItemWithURL:url];
    
    // 监听status属性
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    // 监听loadedTimeRanges属性
    [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    _temp = YES;
    
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.playerView.player = self.player;
    
    // 视频播放结束通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
}

#pragma 创建播放界面
- (void)createPlayView {
    
    self.playerView = [LMS_PlayerView new];
    self.playerView.backgroundColor = [UIColor blackColor];
    self.playerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, PLAYER_HEIGHT);
    [self.view addSubview:self.playerView];
    
    self.workView = [UIView new];
    [self.playerView addSubview:self.workView];
    self.workView.frame = CGRectMake(0, self.playerView.frame.size.height - 45, self.playerView.frame.size.width, 45);
    self.workView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    
    self.tapView = [UIView new];
    [self.playerView addSubview:self.tapView];
    [self.tapView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.playerView);
        make.bottom.equalTo(self.playerView).offset(-45);
        make.left.equalTo(self.playerView);
        make.right.equalTo(self.playerView);
    }];
    
    // 点击屏幕隐藏操作栏
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(turnWorkAction)];
    [self.tapView addGestureRecognizer:tap];
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton.frame = CGRectMake(5, 10, 40, 40);
    [self.backButton setImage:[UIImage imageNamed:@"mc_back"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.playerView addSubview:self.backButton];
    
    self.stateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.stateButton.frame = CGRectMake(0, 0, 35, 35);
    self.stateButton.center = CGPointMake(30, 21);
    [self.stateButton setImage:[UIImage imageNamed:@"mv_pause"] forState:UIControlStateNormal];
    [self.workView addSubview:self.stateButton];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(turnSizeAction) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"mv_turnSize"] forState:UIControlStateNormal];
    [self.workView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.stateButton.mas_centerY).offset(2);
        make.centerX.equalTo(self.workView.mas_right).offset(-30);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    self.videoSlider = [[UISlider alloc] init];
    [self.workView addSubview:self.videoSlider];
    [self.videoSlider  mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.stateButton.mas_right).offset(8);
        make.top.equalTo(self.workView).offset(7);
        make.right.equalTo(button.mas_left).offset(-15);
        make.height.mas_equalTo(10);
    }];
    self.videoSlider.minimumTrackTintColor = [UIColor colorWithRed:0.169 green:0.403 blue:1.000 alpha:1.000];
    [self.videoSlider setThumbImage:[UIImage imageNamed:@"mv_slider_thumb"] forState:UIControlStateNormal];
    
    self.videoProgress = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, self.videoSlider.frame.size.width, 2)];
    self.videoProgress.center = self.videoSlider.center;
    [self.workView addSubview:self.videoSlider];
    
    self.timeLabel = [[UILabel alloc] init];
    [self.workView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.videoSlider).offset(2);
        make.top.equalTo(self.videoSlider.mas_bottom).offset(3);
        make.width.equalTo(self.videoSlider);
        make.height.mas_equalTo(20);
    }];
    self.timeLabel.textColor = [UIColor whiteColor];
    self.timeLabel.text = @"00:00 / ??:??";
    self.timeLabel.font = [UIFont systemFontOfSize:12];
}

#pragma 监听status / loadedTimeRanges属性 - KVO方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    
    // 监听视频状态
    if ([keyPath isEqualToString:@"status"]) {
        
        // 视频已准备好
        if ([playerItem status] == AVPlayerStatusReadyToPlay) {
            
            // 暂停 / 播放
            [self.stateButton addTarget:self action:@selector(stateButtonAction) forControlEvents:UIControlEventTouchUpInside];
            // 快进 / 快退
            [self.videoSlider addTarget:self action:@selector(videoSliderAction) forControlEvents:UIControlEventValueChanged];
            [self.videoSlider addTarget:self action:@selector(apperWorkAction) forControlEvents:UIControlEventTouchDown];
            [self.videoSlider addTarget:self action:@selector(createHideTime) forControlEvents:UIControlEventTouchUpInside];

            // 隐藏操作栏计时器
            self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(hideWorkAction) userInfo:nil repeats:NO];
            
            // 获取视频总时长
            CMTime duration = playerItem.duration;
            self.videoSlider.maximumValue = CMTimeGetSeconds(duration);
            // 转换成秒
            CGFloat totalSecond = playerItem.duration.value / playerItem.duration.timescale;
            // 转换成播放的时间格式
            self.totalTime = [self convertTime:totalSecond];
            // 监听播放状态
            [self monitoringPlayback:self.playerItem];
            [self.playerView.player play];
        }
        else if ([playerItem status] == AVPlayerStatusFailed) {
            
            NSLog(@"视频播放失败");
        }
    }
    // 监听视频缓冲进度
    else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        
        // 缓冲总进度
        NSTimeInterval timeInterval = [self availableDuration];
//        NSLog(@"缓冲总进度:%f",timeInterval);
        // 视频总时长
        CMTime duration = playerItem.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        // 设置进度条显示缓冲的进度
        [self.videoProgress setProgress:timeInterval / totalDuration animated:YES];
    }
}

#pragma 释放KVO
- (void)dealloc {
    
    [self.playerItem removeObserver:self forKeyPath:@"status" context:nil];
    [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges" context:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
    [self.playerView.player removeTimeObserver:self.playbackTimeObserver];
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

#pragma 计算缓冲进度
- (NSTimeInterval)availableDuration {
    
    NSArray *loadedTimeRanges = [[self.playerView.player currentItem] loadedTimeRanges];
    // 获取缓冲区域
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    // 缓冲总进度
    NSTimeInterval result = startSeconds + durationSeconds;
    return result;
}

#pragma 监听视频每秒的状态
/**
 *  监听每秒的状态
 *
 *  interval 响应的时间间隔
 *  queue    队列
 */
- (void)monitoringPlayback:(AVPlayerItem *)playerItem {
    
    // 避免循环引用 代替self
    __weak typeof(self) weakSelf = self;
    
    self.playbackTimeObserver = [self.playerView.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {
        
        // 计算当前的时间
        CGFloat currentSecond = playerItem.currentTime.value / playerItem.currentTime.timescale;
        // 更新进度条
        [weakSelf.videoSlider setValue:currentSecond animated:YES];
        /**
         *  更新时间
         *  timeStr - 当前时间
         *  self.totalTime - 视频总时长
         */
        NSString *timeStr = [weakSelf convertTime:currentSecond];
        weakSelf.timeLabel.text = [NSString stringWithFormat:@"%@ / %@", timeStr, weakSelf.totalTime];
    }];
}

#pragma 视屏结束
- (void)playEnd {
    
    [self.playerView.player seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
        
        [self.videoSlider setValue:0 animated:YES];
        [self.stateButton setImage:[UIImage imageNamed:@"mv_play"] forState:UIControlStateNormal];
        _played = YES;
    }];
    [self.timer invalidate];
    self.timer = nil;
    self.backButton.hidden = NO;
    self.workView.hidden = NO;
}

#pragma 暂停 / 播放
- (void)stateButtonAction {
    
    if (!_played) {
        
         [self.playerView.player pause];
        [self.stateButton setImage:[UIImage imageNamed:@"mv_play"] forState:UIControlStateNormal];
    }
    else if (_played) {

        [self.playerView.player play];
        [self.stateButton setImage:[UIImage imageNamed:@"mv_pause"] forState:UIControlStateNormal];
    }
    
    _played = !_played;
}

#pragma 快进 / 快退
- (void)videoSliderAction {
    
    CMTime changeTime = CMTimeMakeWithSeconds(self.videoSlider.value, 1);
    [self.playerView.player seekToTime:changeTime completionHandler:^(BOOL finished) {

    }];
}

#pragma 隐藏 / 显示操作栏
- (void)turnWorkAction {
    
    [self.timer invalidate];
    self.timer = nil;
    if (YES == self.workView.hidden) {
        
        self.backButton.hidden = NO;
        self.workView.hidden = NO;
        [self createHideTime];
    }
    else {
        
        self.backButton.hidden = YES;
        self.workView.hidden = YES;
        [self.timer invalidate];
        self.timer = nil;
    }
}

#pragma 计时隐藏操作栏
- (void)hideWorkAction {
    
    self.backButton.hidden = YES;
    self.workView.hidden = YES;
}

#pragma 显示操作栏
- (void)apperWorkAction {
    
    [self.timer invalidate];
    self.timer = nil;
    self.workView.hidden = NO;
}

#pragma 隐藏计时器
- (void)createHideTime {

    self.workView.hidden = NO;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.5 target:self selector:@selector(hideWorkAction) userInfo:nil repeats:NO];
}

#pragma 创建tableView
- (void)createTableView {
    
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, PLAYER_HEIGHT, [UIScreen mainScreen].bounds.size.width, self.view.frame.size.height - PLAYER_HEIGHT) style:UITableViewStylePlain];
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.view addSubview:self.tableV];
}

#pragma 创建tableView头视图
- (void)createHeaderView {
    
    CGRect fram =  [self.videoModel.videoName boundingRectWithSize:CGSizeMake(195, 30000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:17] forKey:NSFontAttributeName] context:nil];
    
    [self.tableV.tableHeaderView removeFromSuperview];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50 + fram.size.height)];
    
    UILabel *mvName = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 195, fram.size.height)];
    mvName.font = [UIFont systemFontOfSize:17];
    mvName.numberOfLines = 0;
    mvName.textColor = [UIColor colorWithRed:1.000 green:0.252 blue:0.542 alpha:1.000];
    mvName.text = self.videoModel.videoName;
    [view addSubview:mvName];
    
    UILabel *singerName = [[UILabel alloc] initWithFrame:CGRectMake(mvName.frame.origin.x, mvName.frame.origin.y + mvName.frame.size.height + 6, 198, 20)];
    singerName.font = [UIFont systemFontOfSize:13];
    singerName.text = self.videoModel.singerName;
    singerName.textColor = [UIColor grayColor];
    [view addSubview:singerName];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 30)];
    view1.center = CGPointMake(255, 35);
    view1.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:view1];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 30)];
    view2.center = CGPointMake(315, 35);
    view2.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:view2];
    
    UIImageView *LikeV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 21, 21)];
    LikeV.center = CGPointMake(226, view1.center.y);
    LikeV.image = [UIImage imageNamed:@"iconfont-xin"];
    [view addSubview:LikeV];
    
    UIImageView *downloadV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    downloadV.center = CGPointMake(285, view1.center.y);
    downloadV.image = [UIImage imageNamed:@"iconfont-xiazai-2"];
    [view addSubview:downloadV];
    
    UIImageView *shareV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    shareV.center = CGPointMake(344, view1.center.y);
    shareV.image = [UIImage imageNamed:@"iconfont-pinglun"];
    [view addSubview:shareV];
    
    self.tableV.tableHeaderView = view;
}

#pragma tableView高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120;
}

#pragma tableView行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.similarityArr.count;
}

#pragma tableView区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

#pragma 创建tableView区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    view.backgroundColor = customColor;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.textColor = [UIColor whiteColor];
    label.center = CGPointMake(65, 15);
    label.text = @"相关MV";
    label.font = [UIFont boldSystemFontOfSize:16];
    [view addSubview:label];
    
    return view;
}

#pragma tableView区头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 30;
}

#pragma 创建cell

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LMS_VideoModel *video = [self.similarityArr objectAtIndex:indexPath.row];
    LMS_MVModel *mvModel = [video.mvList firstObject];

    static NSString *cellStr = @"cell";
    LMS_MVTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (nil == cell) {
        
        cell = [[LMS_MVTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:mvModel.picUrl] placeholderImage:[UIImage imageNamed:@"图片载入失败icon"]];
    cell.mvName.text = video.videoName;
    cell.singerName.text = video.singerName;
    cell.bulletCount.text = [NSString stringWithFormat:@"%@", video.bulletCount];
    cell.pickCount.text = [NSString stringWithFormat:@"%@", video.pickCount];
    cell.timeLabel.text = [self convertTime:[mvModel.duration floatValue] / 1000];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma 点击换MV
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LMS_VideoModel *video = [self.similarityArr objectAtIndex:indexPath.row];
    LMS_MVModel *mvModel = [video.mvList firstObject];
    
    if (_temp == YES) {
        
        [self.playerItem removeObserver:self forKeyPath:@"status" context:nil];
        [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges" context:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
        self.playbackTimeObserver = nil;
        _temp = NO;
    }
    
    [self.playerView removeFromSuperview];
    [self createPlayView];
    
    [self.timer invalidate];
    self.timer = nil;
    self.workView.hidden = YES;
    self.backButton.hidden = YES;
    
    self.videoId = mvModel.videoId;
    [self getMVData];
    [self getSimilarityData];
}

#pragma 点击全屏
- (void)turnSizeAction {
    
    self.playerView.transform = CGAffineTransformMakeRotation(0 *M_PI / 180.0);
    self.view.transform = CGAffineTransformMakeRotation(0 *M_PI / 180.0);
    if (_full == NO) {
        
        if ([self.direction isEqualToString:@"left"]) {

            self.view.frame = [UIScreen mainScreen].bounds;
            self.playerView.frame = [UIScreen mainScreen].bounds;
            self.workView.frame = CGRectMake(0, self.playerView.frame.size.height - 45, self.playerView.frame.size.width, 45);
            [self.backButton addTarget:self action:@selector(turnSizeAction) forControlEvents:UIControlEventTouchUpInside];
        }
        else if ([self.direction isEqualToString:@"right"]) {
            
            self.view.frame = [UIScreen mainScreen].bounds;
            self.playerView.frame = [UIScreen mainScreen].bounds;
            self.workView.frame = CGRectMake(0, self.playerView.frame.size.height - 45, self.playerView.frame.size.width, 45);
            [self.backButton addTarget:self action:@selector(turnSizeAction) forControlEvents:UIControlEventTouchUpInside];
        }
        else {
            
            self.playerView.transform = CGAffineTransformMakeRotation(90 *M_PI / 180.0);
            self.playerView.frame = self.view.frame;
            self.workView.frame = CGRectMake(0, self.view.frame.size.width - 45, self.view.frame.size.height, 45);
            [self.backButton addTarget:self action:@selector(turnSizeAction) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [self.view bringSubviewToFront:self.playerView];
        _full = YES;
    }
    else {
        
        if ([self.direction isEqualToString:@"left"]) {

            self.playerView.frame = CGRectMake(0, 0, 375, PLAYER_HEIGHT);
            self.view.transform = CGAffineTransformMakeRotation(-90 *M_PI / 180.0);
            self.view.frame = [UIScreen mainScreen].bounds;
            self.workView.frame = CGRectMake(0, self.playerView.frame.size.height - 45, self.playerView.frame.size.width, 45);
            [self.backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        }
        else if ([self.direction isEqualToString:@"right"]) {
            
            [self.backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
            self.playerView.frame = CGRectMake(0, 0, 375, PLAYER_HEIGHT);
            self.view.transform = CGAffineTransformMakeRotation(90 *M_PI / 180.0);
            self.view.frame = [UIScreen mainScreen].bounds;
            self.workView.frame = CGRectMake(0, self.playerView.frame.size.height - 45, self.playerView.frame.size.width, 45);
        }
        else {
            
            self.playerView.frame = CGRectMake(0, 0, 375, PLAYER_HEIGHT);
            self.workView.frame = CGRectMake(0, self.playerView.frame.size.height - 45, self.playerView.frame.size.width, 45);
            [self.backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        }
        _full = NO;
    }
}


#pragma 屏幕旋转
- (void)handleDeviceOrientationDidChange:(UIInterfaceOrientation)interfaceOrientation {
    
    UIDevice *device = [UIDevice currentDevice];
    
    switch (device.orientation) {
            
        // 屏幕朝上平躺
        case UIDeviceOrientationFaceUp:
            break;
            
        // 屏幕朝下平躺
        case UIDeviceOrientationFaceDown:
            break;
            
        //系統無法判斷目前Device的方向，有可能是斜置
        case UIDeviceOrientationUnknown:
            break;
        
        // 屏幕向左横置
        case UIDeviceOrientationLandscapeLeft:
            
            self.playerView.transform = CGAffineTransformMakeRotation(0 *M_PI / 180.0);
            self.view.transform = CGAffineTransformMakeRotation(0 *M_PI / 180.0);
            self.view.frame = [UIScreen mainScreen].bounds;
            self.playerView.frame = CGRectMake(0, 0, 667, 375);
                [self.view bringSubviewToFront:self.playerView];
            self.workView.frame = CGRectMake(0, self.playerView.frame.size.height - 45, self.playerView.frame.size.width, 45);
            self.direction = @"left";
            _full = YES;
            [self.backButton addTarget:self action:@selector(turnSizeAction) forControlEvents:UIControlEventTouchUpInside];
            break;
         
        // 屏幕向右橫置
        case UIDeviceOrientationLandscapeRight:

            self.playerView.transform = CGAffineTransformMakeRotation(0 *M_PI / 180.0);
            self.view.transform = CGAffineTransformMakeRotation(0 *M_PI / 180.0);
            self.view.frame = [UIScreen mainScreen].bounds;
            self.playerView.transform = CGAffineTransformMakeRotation(0 *M_PI / 180.0);
            self.playerView.frame = CGRectMake(0, 0, 667, 375);
            [self.view bringSubviewToFront:self.playerView];
            self.workView.frame = CGRectMake(0, self.playerView.frame.size.height - 45, self.playerView.frame.size.width, 45);
            self.direction = @"right";
            _full = YES;
            [self.backButton addTarget:self action:@selector(turnSizeAction) forControlEvents:UIControlEventTouchUpInside];
            break;
        
        // 屏幕直立
        case UIDeviceOrientationPortrait:

            self.playerView.transform = CGAffineTransformMakeRotation(0 *M_PI / 180.0);
            self.view.transform = CGAffineTransformMakeRotation(0 *M_PI / 180.0);            self.view.frame = [UIScreen mainScreen].bounds;
            self.playerView.transform = CGAffineTransformMakeRotation(0 *M_PI / 180.0);
            self.playerView.frame = CGRectMake(0, 0, 375, PLAYER_HEIGHT);
            self.workView.frame = CGRectMake(0, self.playerView.frame.size.height - 45, self.playerView.frame.size.width, 45);
            self.direction = @"on";
            _full = NO;
            [self.backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
            break;
         
        // 屏幕直立，上下顛倒
        case UIDeviceOrientationPortraitUpsideDown:
            break;
            
        default:
            break;
    }
}

- (void)backAction {
    
    [self.player replaceCurrentItemWithPlayerItem:nil];
    [self dismissViewControllerAnimated:YES completion:^{
        
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
