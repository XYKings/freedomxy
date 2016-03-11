//
//  LMS_MusicPlay_ViewController.m
//  Freedom
//
//  Created by dllo on 16/1/12.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import "LMS_MusicPlay_ViewController.h"
#define PAD 30
#import "LMSMusicInfo.h"
#import "LMSAuditionList.h"
#import "LMSPlayerManager.h"
#define Khttp [NSString stringWithFormat:@"http://api.dongting.com/song/song/%@", @"27874319"]
#import "LMSMusicTimeFormatter.h"
#import "LMS_MusicList_ViewController.h"

@interface LMS_MusicPlay_ViewController ()<playerManagerDelegate>
//    音乐信息
@property (nonatomic, retain) LMSMusicInfo *musicInfo;

//    背景图片
@property (nonatomic, retain) UIImageView *backgroundImage;
//    背景毛玻璃
@property (nonatomic, retain) UIVisualEffectView *effectView;
//    歌名&歌手名
@property (nonatomic, retain) UILabel *songName;
@property (nonatomic, retain) UILabel *singerName;
//    歌曲图片
@property (nonatomic, retain) UIImageView *musicPicture;
//    歌曲进度条以及时间label
@property (nonatomic, retain) UISlider *timeSlider;
@property (nonatomic, retain) UILabel *progressLabel;
@property (nonatomic, retain) UILabel *durationLabel;

//    本页button
@property (nonatomic, retain) UIButton *returnButton;  //    返回
@property (nonatomic, retain) UIButton *likeButton;  //    收藏

@property (nonatomic, retain) UIButton *lastMusicButton;  //    上一曲
@property (nonatomic, retain) UIButton *playAndPauseButton;  //    开始暂停button
@property (nonatomic, retain) UIButton *nextMusicButton;  //    下一曲

@property (nonatomic, retain) UIButton *playModeButton; //    播放模式
@property (nonatomic, retain) UIButton *shareButton;  //    分享音乐
@property (nonatomic, retain) UIButton *downloadButton;  //    下载音乐
@property (nonatomic, retain) UIButton *musicListButton;  //    音乐列表

//@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain)  LMSPlayerManager *musicPlayer;

@end

@implementation LMS_MusicPlay_ViewController

+ (instancetype)musicPlay {
    static LMS_MusicPlay_ViewController *music = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        music = [[LMS_MusicPlay_ViewController alloc] init];
    });
    return music;
}

- (void)setSongID:(NSNumber *)songID {
    if (_songID != songID) {
        _songID = songID;
        [self createData];
    }
}
//- (void)setMusicIndex:(NSInteger)musicIndex{
//    _musicIndex = musicIndex;
//    [self.musicPlayer prepareMusic:self.musicIndex];
//                self.musicInfo = [[LMSPlayerManager playerManager] getmusicInfoWithIndext:self.musicIndex];
//    [self createPlayer:self.musicInfo];
//    
//}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    修改电池条颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.musicIndex = [[[NSUserDefaults standardUserDefaults] objectForKey:@"musicIndex"] integerValue];
    [self.navigationController.navigationBar setHidden:YES];
     [self.musicPlayer prepareMusic:self.musicIndex];
            self.musicInfo = [[LMSPlayerManager playerManager] getmusicInfoWithIndext:self.musicIndex];
    [self createPlayer:self.musicInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createView];
//    [self createData];

//    [self createPlayer:self.musicInfo];
    self.musicPlayer = [LMSPlayerManager playerManager];
    self.musicPlayer.delegate = self;
//        self.musicPlayer.isPlaying = NO;
//    [[LMSPlayerManager playerManager]musicPlay];
}

#pragma mark - 铺设界面
- (void)createView {
    
    [self createBackgroundView];
    [self createTopLabel];
    [self createControls];
    [self createSongPicture];
    [self createSliderAndTimeLabels];
    [self setControlConstraint];
    
}

#pragma mark - 创建背景(图片及毛玻璃)
- (void)createBackgroundView {
    //    背景图片
    self.backgroundImage = [UIImageView new];
    self.backgroundImage.image = [UIImage imageNamed:@"musicpic"];
    [self.view addSubview:self.backgroundImage];

    //    模糊背景
    self.effectView = [UIVisualEffectView new];
    [self.effectView setEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    self.effectView.alpha = 1.0;
    [self.view addSubview:self.effectView];

}

#pragma mark - 初始化播放器
- (void)createPlayer:(LMSMusicInfo *)musicInfo {

//    LMSAuditionList *audition = [[self.musicInfo auditionList] objectAtIndex:0];
//    NSURL *url = [NSURL URLWithString:audition.url];
//    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
//    self.musicPlayer = [LMSPlayerManager playerManager];
//    self.musicPlayer.delegate = self;
//    self.musicPlayer.isPlaying = YES;
    [self.backgroundImage sd_setImageWithURL:[NSURL URLWithString:musicInfo.picUrl]];
    [self.musicPicture sd_setImageWithURL:[NSURL URLWithString:musicInfo.picUrl]];
    self.progressLabel.text = @"00:00";
    self.durationLabel.text = [LMSMusicTimeFormatter getStringFormatBySeconds:([musicInfo.duration intValue] / 1000)];
    self.songName.text = musicInfo.name;
//    self.singerName.text = self.musicInfo.singerName;

    self.timeSlider.maximumValue = [musicInfo.duration intValue] / 1000;
//      [self.musicPlayer prepareToPlay];
    
}

#pragma mark - 创建Label以及button(歌名以及歌手名)
- (void)createTopLabel {
    
    //    歌曲名字
    self.songName = [UILabel new];
    self.songName.text = @"Lollipop";
    self.songName.font = [UIFont systemFontOfSize:20.0];
    self.songName.textColor = [UIColor whiteColor];
    self.songName.textAlignment = NSTextAlignmentCenter;
    [self.effectView addSubview:self.songName];
    
    //    歌手名字
    self.singerName = [UILabel new];
    self.singerName.text = @"\\(≧▽≦)  Mika  (≧▽≦)/";
    self.singerName.font = [UIFont systemFontOfSize:18.0];
    self.singerName.textColor = [UIColor whiteColor];
    self.singerName.textAlignment = NSTextAlignmentCenter;
    [self.effectView addSubview:self.singerName];
}

#pragma mark - 创建音乐图片
- (void)createSongPicture {
    //    旋转的音乐图片
    self.musicPicture = [UIImageView new];
    self.musicPicture.image = [UIImage imageNamed:@"musicpic"];
    [self.effectView addSubview:self.musicPicture];
    self.musicPicture.layer.masksToBounds = YES;
    self.musicPicture.layer.cornerRadius = (WIDTH - PAD * 4) / 2;
    self.musicPicture.layer.borderWidth = 8;
    self.musicPicture.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:1].CGColor;
//    CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
//    basic.fromValue = @(0);
//    basic.toValue = @(2 * M_PI);
//    basic.duration = 10.f;
//    //    basicA1.autoreverses = YES;
//    basic.repeatCount = NSIntegerMax;
//    [self.musicPicture.layer addAnimation:basic forKey:@"basicAnimation"];
}

#pragma mark - 创建进度条slider
- (void)createSliderAndTimeLabels {
    //    播放进度
    self.progressLabel = [UILabel new];
    self.progressLabel.text = @"00:00";
    self.progressLabel.font = [UIFont systemFontOfSize:14.0];
    self.progressLabel.textAlignment = NSTextAlignmentCenter;
    self.progressLabel.textColor = [UIColor whiteColor];
    [self.effectView addSubview:self.progressLabel];
    
    //    总时间
    self.durationLabel = [UILabel new];
    self.durationLabel.text = @"03:03";
    self.durationLabel.font = [UIFont systemFontOfSize:14.0];
    self.durationLabel.textAlignment = NSTextAlignmentCenter;
    self.durationLabel.textColor = [UIColor whiteColor];
    [self.effectView addSubview:self.durationLabel];
    
    //    进度条
    self.timeSlider = [UISlider new];
    [self.timeSlider addTarget:self action:@selector(timeSliderAction:) forControlEvents:UIControlEventTouchUpInside];
    self.timeSlider.value = 0;
    [self.effectView addSubview:self.timeSlider];
    self.timeSlider.minimumTrackTintColor = [UIColor colorWithRed:255 / 255.0 green:181 / 255.0 blue:197 / 255.0 alpha:1.0];
    self.timeSlider.maximumTrackTintColor = [UIColor whiteColor];
    [self.timeSlider setThumbImage:[UIImage imageNamed:@"actionSlider_b"] forState:UIControlStateNormal];
}

#pragma mark - 创建Button
- (void)createControls {

    //    返回键
    self.returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.returnButton setImage:[UIImage imageNamed:@"actionback"] forState:UIControlStateNormal];
    [self.returnButton addTarget:self action:@selector(returnBackToLastPage) forControlEvents:UIControlEventTouchUpInside];
    [self.effectView addSubview:self.returnButton];
    
    //    收藏键
    self.likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.likeButton setImage:[UIImage imageNamed:@"actionIconUnlike_b"] forState:UIControlStateNormal];
    [self.likeButton addTarget:self action:@selector(likeSelect) forControlEvents:UIControlEventTouchUpInside];
    [self.effectView addSubview:self.likeButton];
    
    //    上一曲
    self.lastMusicButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.lastMusicButton setImage:[UIImage imageNamed:@"hp_player_btn_pre_normal"] forState:UIControlStateNormal];
    [self.lastMusicButton addTarget:self action:@selector(playLastMusicAction) forControlEvents:UIControlEventTouchUpInside];
    [self.effectView addSubview:self.lastMusicButton];
    
    //    播放暂停
    self.playAndPauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if ([LMSPlayerManager playerManager].isPlaying == NO) {
            [self.playAndPauseButton setImage:[UIImage imageNamed:@"hp_player_btn_play_normal"] forState:UIControlStateNormal];
    } else {
        [self.playAndPauseButton setImage:[UIImage imageNamed:@"hp_player_btn_pause_normal"] forState:UIControlStateNormal];
    }
    [self.playAndPauseButton addTarget:self action:@selector(playAndPauseAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.effectView addSubview:self.playAndPauseButton];
    
    //    下一曲
    self.nextMusicButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.nextMusicButton setImage:[UIImage imageNamed:@"hp_player_btn_next_normal"] forState:UIControlStateNormal];
    [self.nextMusicButton addTarget:self action:@selector(playNextMusicAction) forControlEvents:UIControlEventTouchUpInside];
    [self.effectView addSubview:self.nextMusicButton];
    
    //    播放模式
    self.playModeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.playModeButton setImage:[UIImage imageNamed:@"play_randomwhite"] forState:UIControlStateNormal];
    [self.playModeButton setImage:[UIImage imageNamed:@"playrepeatwhite"] forState:UIControlStateNormal];
    [self.playModeButton setImage:[UIImage imageNamed:@"playrepeatonewhite"] forState:UIControlStateNormal];
    [self.playModeButton addTarget:self action:@selector(changePlayModeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.effectView addSubview:self.playModeButton];
    
    //    下载
    self.downloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.downloadButton setImage:[UIImage imageNamed:@"actiondownloadwhite"] forState:UIControlStateNormal];
    [self.downloadButton addTarget:self action:@selector(downloadAction) forControlEvents:UIControlEventTouchUpInside];
    [self.effectView addSubview:self.downloadButton];
    
    //    分享
    self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shareButton setImage:[UIImage imageNamed:@"player_btn_share_normal"] forState:UIControlStateNormal];
    [self.shareButton addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    [self.effectView addSubview:self.shareButton];
    
    //    播放列表
    self.musicListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.musicListButton setImage:[UIImage imageNamed:@"playing_recommend_floder"] forState:UIControlStateNormal];
    [self.musicListButton addTarget:self action:@selector(musicListPageAction) forControlEvents:UIControlEventTouchUpInside];
    [self.effectView addSubview:self.musicListButton];

}

#pragma mark - 设置所有控件的Masonry
- (void)setControlConstraint {
    //    背景图片
    [self.backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.view);
    }];
    //    毛玻璃
    [self.effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.view);
    }];
    //    返回按钮
    [self.returnButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.effectView.mas_top).with.offset(PAD);
        make.left.equalTo(self.effectView.mas_left).with.offset(PAD);
        //        make.right.equalTo(self.songName.mas_left).with.offset(-PAD);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(PAD);
    }];
    //    收藏按钮
    [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.effectView.mas_top).with.offset(PAD);
        //        make.left.equalTo(self.songName.mas_right).with.offset(PAD);
        make.right.equalTo(self.effectView.mas_right).with.offset(-PAD);
        make.width.mas_equalTo(self.returnButton);
        make.height.mas_equalTo(PAD);
    }];
    //    歌曲名字
    [self.songName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.effectView.mas_top).with.offset(PAD);
        make.left.equalTo(self.returnButton.mas_right).with.offset(PAD);
        make.right.equalTo(self.likeButton.mas_left).with.offset(-PAD);
        make.height.mas_equalTo(PAD);
        
    }];
    //    歌手名字
    [self.singerName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.songName.mas_bottom).with.offset(15);
        make.left.equalTo(self.effectView.mas_left).with.offset(PAD);
        make.right.equalTo(self.effectView.mas_right).with.offset(-PAD);
        make.height.mas_equalTo(PAD);
    }];
    //    歌曲图片
    [self.musicPicture mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.singerName.mas_bottom).with.offset(PAD);
        make.left.equalTo(self.effectView.mas_left).with.offset(PAD * 2);
        make.right.equalTo(self.effectView.mas_right).with.offset(-PAD * 2);
        make.height.mas_equalTo(WIDTH - PAD * 4);
    }];
    //    歌曲进度条
    [self.timeSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.musicPicture.mas_bottom).with.offset(PAD * 2);
        make.left.equalTo(self.progressLabel.mas_right).with.offset(10);
        make.right.equalTo(self.durationLabel.mas_left).with.offset(-10);
        make.height.equalTo(@15);
    }];
    //    进度时间
    [self.progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeSlider.mas_top);
        make.left.equalTo(self.effectView.mas_left);
//        make.right.equalTo(self.timeSlider.mas_left);
        make.width.equalTo(@40);
        make.height.equalTo(self.timeSlider.mas_height);
    }];
    //    歌曲总时间
    [self.durationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeSlider.mas_top);
        make.left.equalTo(self.timeSlider.mas_right).with.offset(10);
        make.right.equalTo(self.effectView.mas_right);
        make.width.equalTo(self.progressLabel.mas_width);
        make.height.equalTo(self.timeSlider.mas_height);
    }];
    //    上一曲
    [self.lastMusicButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeSlider.mas_bottom).with.offset(PAD / 2);
        make.left.equalTo(self.effectView.mas_left).with.offset(PAD);
        make.height.mas_equalTo(PAD * 3);
        make.width.equalTo(@[self.playAndPauseButton, self.nextMusicButton]);
    }];
    //    播放暂停键
    [self.playAndPauseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lastMusicButton.mas_top);
        make.left.equalTo(self.lastMusicButton.mas_right).with.offset(PAD);
        make.right.equalTo(self.nextMusicButton.mas_left).with.offset(-PAD);
        make.height.equalTo(self.lastMusicButton.mas_height);
        make.width.equalTo(@[self.lastMusicButton, self.nextMusicButton]);
    }];
    //    下一曲
    [self.nextMusicButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lastMusicButton.mas_top);
        make.right.equalTo(self.effectView).with.offset(-PAD);
        make.height.equalTo(self.lastMusicButton.mas_height);
        make.width.equalTo(@[self.lastMusicButton, self.playAndPauseButton]);
    }];
    //    播放模式
    [self.playModeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.playAndPauseButton.mas_bottom).with.offset(PAD);
        make.left.equalTo(self.effectView.mas_left).with.offset(PAD);
        make.width.equalTo(@[self.downloadButton, self.shareButton, self.musicListButton]);
        make.height.mas_equalTo(PAD * 1.5);
        
    }];
    //    下载
    [self.downloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.playModeButton.mas_top);
        make.left.equalTo(self.playModeButton.mas_right).with.offset(PAD);
        make.width.equalTo(@[self.playModeButton, self.shareButton, self.musicListButton]);
        make.height.equalTo(self.playModeButton);
        
    }];
    //    分享
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.playModeButton.mas_top);
        make.left.equalTo(self.downloadButton.mas_right).with.offset(PAD);
        make.width.equalTo(@[self.playModeButton, self.downloadButton, self.musicListButton]);
        make.height.equalTo(self.playModeButton);
        
    }];
    //    播放列表
    [self.musicListButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.playModeButton.mas_top);
        make.left.equalTo(self.shareButton.mas_right).with.offset(PAD);
        make.right.equalTo(self.effectView.mas_right).with.offset(-PAD);
        make.width.equalTo(@[self.playModeButton, self.shareButton, self.downloadButton]);
        make.height.equalTo(self.playModeButton);
        
    }];

}

#pragma mark - 本页Button方法

#pragma mark - 返回上一页方法
- (void)returnBackToLastPage {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - 收藏方法
- (void)likeSelect {
#warning 收藏
}

#pragma mark - 进度条方法
- (void)timeSliderAction:(UISlider *)sender {
    
[[LMSPlayerManager playerManager]musicSeekToTime:sender.value];
    
}

#pragma mark - 上一曲
- (void)playLastMusicAction {
    [[LMSPlayerManager playerManager]upMusic];
}

#pragma mark - 播放暂停
- (void)playAndPauseAction:(UIButton *)sender {


    if (YES == self.musicPlayer.isPlaying) {
        [[LMSPlayerManager playerManager]pause];
                [sender setImage:[UIImage imageNamed:@"hp_player_btn_play_normal"] forState:UIControlStateNormal];
        [LMSPlayerManager playerManager].isPlaying = NO;
    }else{
        [[LMSPlayerManager playerManager]musicPlay];
        [sender setImage:[UIImage imageNamed:@"hp_player_btn_pause_normal"] forState:UIControlStateNormal];
        [LMSPlayerManager playerManager].isPlaying = YES;
    }
}

#pragma mark - 下一曲
- (void)playNextMusicAction {
    [[LMSPlayerManager playerManager]nextMusic];
}

#pragma mark - 播放模式
- (void)changePlayModeAction {
    
}

#pragma mark - 下载
- (void)downloadAction {
    
}

#pragma mark - 分享
- (void)shareAction {
    
}

#pragma mark - 播放列表
- (void)musicListPageAction {
//    [self.navigationController popToRootViewControllerAnimated:YES];
    LMS_MusicList_ViewController *music = [[LMS_MusicList_ViewController alloc] init];
[self presentViewController:music animated:YES completion:^{
    
    
}];
}

#pragma mark - 计时器方法
- (void)changeSliderValue {

}

#pragma mark - 转换时间格式
- (NSString *)covertTimeToString:(NSTimeInterval)seconds {
    
    NSInteger min = seconds / 60;             //分钟
    NSInteger sec = (NSInteger)seconds % 60;  //秒
    
    //%02d 表示显示两位数的整数且十位用0占位
    NSString *string = [NSString stringWithFormat:@"%02ld:%02ld",min, sec];
    return string;
}

#pragma mark - 获取数据
- (void)createData {
    [LMSAFNetTool getNetWithURL:Khttp body:nil headFile:nil responseStyle:LMSJSON success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableDictionary *dic = [responseObject objectForKey:@"data"];
        self.musicInfo = [LMSMusicInfo baseModelWithDictionary:dic];
        
        NSLog(@"picurl: %@", self.musicInfo.picUrl);
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            [self createPlayer:self.musicInfo];
        });

        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
}

#pragma mark - 谁知道这是啥
- (void)didMusicCutWithMusicInfo:(LMSMusicInfo *)musicInfo {
//        [self.musicPlayer prepareMusic:musicInfo];
//    [self createPlayer];
    
//    self.songName.text = musicInfo.name;
//    self.singerName.text = musicInfo.singerName;
    [self createPlayer:musicInfo];
    
}

- (void)playMusicWithFormatString:(NSString *)string{
    self.timeSlider.value = [LMSMusicTimeFormatter getSecondsFormatByString:string];
    self.progressLabel.text = string;
}

-(void)didPlayChangeStatus:(NSString *)time{
    [self playMusicWithFormatString:time];
    self.musicPicture.transform = CGAffineTransformRotate(self.musicPicture.transform, M_PI/360);

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
