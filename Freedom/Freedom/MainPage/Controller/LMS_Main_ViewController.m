//
//  LMS_Main_ViewController.m
//  Freedom
//
//  Created by dllo on 16/1/12.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import "LMS_Main_ViewController.h"
#import <MMDrawerBarButtonItem.h>
#import <UIViewController+MMDrawerController.h>
#import "LMS_LeftDrawer_ViewController.h"
#import "LMS_MusicPlay_ViewController.h"
#import "LMSPlayerManager.h"
#import "LMS_SearchPageViewController.h"
#import "LMS_Discover_ViewController.h"

#import "LMS_MVLookViewController.h"
#import "LMS_MusicList_ViewController.h"


@interface LMS_Main_ViewController ()<playerManagerDelegate>

//    跳转至单例播放器的toolbar
@property (nonatomic, retain) LMSPlayerManager *musicPlayer;
@property (nonatomic, retain) LMSMusicInfo *musicInfo;
@property (nonatomic, assign) NSInteger musicIndex;
@property (nonatomic, retain) UIToolbar *toolbar;
@property (nonatomic, retain) UIImageView *musicPicture;
@property (nonatomic, retain) UILabel *songName;
@property (nonatomic, retain) UILabel *singerName;
@property (nonatomic, retain) UIButton *playAndPauseButton;
@property (nonatomic, retain) UIButton *musicListButton;

@property (nonatomic, strong) LMS_MVLookViewController *look;
@property (nonatomic, strong) LMS_Discover_ViewController *discoverVC;
@property (nonatomic, strong) LMS_MusicList_ViewController *musicList;
@end

@implementation LMS_Main_ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.musicIndex = [[[NSUserDefaults standardUserDefaults] objectForKey:@"musicIndex"] integerValue];
//    self.musicPlayer.isPlaying = NO;
//    [[LMSPlayerManager playerManager] getPlayListCompletionHandler:^{
//        [self.musicPlayer prepareMusic:self.musicIndex];
//        self.musicInfo = [[LMSPlayerManager playerManager] getmusicInfoWithIndext:self.musicIndex];
//        [self createPlayer:self.musicInfo];
//    }];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
        self.musicIndex = [[[NSUserDefaults standardUserDefaults] objectForKey:@"musicIndex"] integerValue];
    self.musicInfo = [[LMSPlayerManager playerManager] getmusicInfoWithIndext:self.musicIndex];
    [self createPlayer:self.musicInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[LMSPlayerManager playerManager] getPlayListCompletionHandler:^{
        [self.musicPlayer prepareMusic:self.musicIndex];
        self.musicInfo = [[LMSPlayerManager playerManager] getmusicInfoWithIndext:self.musicIndex];
    [self createView];
    }];
    

    self.musicPlayer = [LMSPlayerManager playerManager];
    self.musicPlayer.delegate = self;
    [LMSPlayerManager playerManager].isPlaying = NO;
    NSLog(@"%@", NSHomeDirectory());
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconfont-sousuo"] style:UIBarButtonItemStylePlain target:self action:@selector(searchAction)];
    
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"发现", @"MV精选", nil]];
    segment.frame = CGRectMake(0, 0, 100, 30);
    segment.selectedSegmentIndex = 0;
    [segment addTarget:self action:@selector(segmentSelect:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segment;
    [self demo];
}

- (void)demo {
//    self.discoverVC = [[LMS_Discover_ViewController alloc] init];
//    [self addChildViewController:self.discoverVC];
//    [self.view addSubview:self.discoverVC.view];
//    self.discoverVC.view.hidden = NO;
    
    self.musicList = [[LMS_MusicList_ViewController alloc] init];
    [self addChildViewController:self.musicList];
    [self.view addSubview:self.musicList.view];
    self.musicList.view.hidden = NO;
    
    self.look = [[LMS_MVLookViewController alloc] init];
    [self addChildViewController:self.look];
    [self.view addSubview:self.look.view];
    self.look.view.hidden = YES;
}

- (void)segmentSelect:(UISegmentedControl *)sender {
    //发现
    if (0 == sender.selectedSegmentIndex) {
        self.musicList.view.hidden = NO;
        self.look.view.hidden = YES;
        //MV精选
    } else {
        self.musicList.view.hidden = YES;
        self.look.view.hidden = NO;
    }

}
#pragma mark - 创建View
- (void)createView {
    
    [self createLeftMenuButton];
    [self createToolbarWithMusicInfo:self.musicInfo];

}
#pragma mark - 创建button跳转抽屉
- (void)createLeftMenuButton {
    MMDrawerBarButtonItem *leftButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    
    [self.navigationItem setLeftBarButtonItem:leftButton animated:YES];
}

#pragma mark - 创建toolBar
- (void)createToolbarWithMusicInfo:(LMSMusicInfo *)musicInfo {
    self.toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, HEIGHT - 60 - 60, WIDTH, 60)];
    [self.view addSubview:self.toolbar];
   
    
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toolbarTapAction:)];
    [self.toolbar addGestureRecognizer:tapGR];
//    self.toolbar.backgroundColor = [UIColor greenColor];
    
    //    专辑图片
    self.musicPicture = [UIImageView new];
    [self.musicPicture sd_setImageWithURL:[NSURL URLWithString:musicInfo.picUrl] placeholderImage:[UIImage imageNamed:@"musicpic"]];
    [self.toolbar addSubview:self.musicPicture];
    self.musicPicture.layer.masksToBounds = YES;
    self.musicPicture.layer.cornerRadius = 25;
    self.musicPicture.layer.borderWidth = 1;
    self.musicPicture.layer.borderColor = [UIColor lightGrayColor].CGColor;
    //    歌曲名字
    self.songName = [UILabel new];
    self.songName.text = musicInfo.name;
    self.songName.textColor = [UIColor lightGrayColor];
    [self.toolbar addSubview:self.songName];
//    self.songName.backgroundColor = [UIColor cyanColor];
    
    //    歌手名字
    self.singerName = [UILabel new];
    self.singerName.text = musicInfo.singerName;
    self.singerName.textColor = [UIColor lightGrayColor];
    [self.toolbar addSubview:self.singerName];
    
    //    开始暂停button
    self.playAndPauseButton = [UIButton buttonWithType:UIButtonTypeCustom];

    if ([LMSPlayerManager playerManager].isPlaying == NO) {
    [self.playAndPauseButton setImage:[UIImage imageNamed:@"toolbarplay"] forState:UIControlStateNormal];
    } else {
    [self.playAndPauseButton setImage:[UIImage imageNamed:@"toolbarpause"] forState:UIControlStateNormal];
    }
    [self.playAndPauseButton addTarget:self action:@selector(playAndPauseAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.toolbar addSubview:self.playAndPauseButton];
    
    //    播放列表
    self.musicListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.musicListButton setImage:[UIImage imageNamed:@"toolbarmusiclist"] forState:UIControlStateNormal];
    [self.musicListButton addTarget:self action:@selector(musicListAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.toolbar addSubview:self.musicListButton];
    
    [self.musicPicture mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.toolbar.mas_centerY);
        make.left.equalTo(self.toolbar.mas_left).with.offset(10);
        make.width.and.height.mas_equalTo(50);
    }];
    [self.songName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.equalTo(self.musicPicture.mas_right).with.offset(10);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(WIDTH / 2 - 20);
    }];
    [self.singerName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.songName.mas_bottom);
        make.height.equalTo(self.songName.mas_height);
        make.left.equalTo(self.songName.mas_left);
        make.width.equalTo(self.songName.mas_width);
    }];
    [self.playAndPauseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.musicPicture);
        make.right.equalTo(self.musicListButton.mas_left).with.offset(- 20);
        make.height.and.width.equalTo(self.musicPicture);
    }];
    [self.musicListButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.musicPicture);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
        make.height.and.with.equalTo(self.playAndPauseButton);
    }];

}

- (void)createPlayer:(LMSMusicInfo *)musicInfo {
    [self.musicPicture sd_setImageWithURL:[NSURL URLWithString:musicInfo.picUrl]];
    self.songName.text = musicInfo.name;
        self.singerName.text = self.musicInfo.singerName;
}
#pragma mark - toolbar两个Button方法
- (void)playAndPauseAction:(UIButton *)sender {
    if (YES == self.musicPlayer.isPlaying) {
        [[LMSPlayerManager playerManager]pause];
        [sender setImage:[UIImage imageNamed:@"toolbarplay"] forState:UIControlStateNormal];
        [LMSPlayerManager playerManager].isPlaying = NO;
    }else{
        [[LMSPlayerManager playerManager]musicPlay];
        [sender setImage:[UIImage imageNamed:@"toolbarpause"] forState:UIControlStateNormal];
        [LMSPlayerManager playerManager].isPlaying = YES;
    }
}
- (void)musicListAction:(UIButton *)sender {
    
}
- (void)toolbarTapAction:(UITapGestureRecognizer *)sender {
    LMS_MusicPlay_ViewController *musicVC = [LMS_MusicPlay_ViewController musicPlay];
    [self presentViewController:musicVC animated:YES completion:^{
        
        
    }];
}
/*
 当歌曲正在播放时被一直调用的代理方法
 */
- (void)didPlayChangeStatus:(NSString *)time {
    
}
/*
 当音乐被切换时调用的代理方法  外部需要拿到数据模型 进行改变
 */
- (void)didMusicCutWithMusicInfo:(LMSMusicInfo *)musicInfo {
        self.musicPicture.transform = CGAffineTransformRotate(self.musicPicture.transform, M_PI/360);
}


#pragma mark - 左抽屉方法
- (void)leftDrawerButtonPress:(MMDrawerBarButtonItem *)sender {
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {
        
    }];
}

#pragma 搜索
- (void)searchAction {
    LMS_SearchPageViewController *searchVC = [[LMS_SearchPageViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchVC];
    nav.navigationBar.translucent = NO;
    [self presentViewController:nav animated:YES completion:nil];
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
