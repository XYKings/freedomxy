//
//  LMSMusicListViewController.m
//  Freedom
//
//  Created by dllo on 16/1/21.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import "LMSMusicListViewController.h"
#import "LMS_SearchPageViewController.h"
#import "LMS_Discover_ViewController.h"
#import "LMSRankViewController.h"
#import "LMSMusicInfo.h"
#import "LMSMusicListView.h"
#import "LMSRankListModel.h"
#import "LMSDiscoverModel.h"
#import "LMSMusicListModel.h"

@interface LMSMusicListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) UITableView *listTableView;
@property (nonatomic, retain) UIImageView *listImageView;
@property (nonatomic, retain) NSMutableArray *songsArray;

//@property (nonatomic, retain) SingerAlbumModel *albumModel;
@property (nonatomic, assign) NSInteger count;

@end

@implementation LMSMusicListViewController

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createView];
    self.songsArray = [[NSMutableArray alloc]init];
//    [self songListData];
}


- (void)createView {
    
    [self createButton];
    [self createTableView];
    
}
- (void)createButton {
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 25, 25);
    [backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"backlast.png"] forState:UIControlStateNormal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)createTableView {
    //tableView
    self.listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64 - 49) style:UITableViewStylePlain];
    self.listTableView.backgroundColor = [UIColor clearColor];
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    [self.view addSubview:self.listTableView];

    
    //图片
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
    [self.listTableView setTableHeaderView:image];

    
    self.listImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
    [image addSubview:self.listImageView];
    //[_listTableView setTableHeaderView:_listImageView];
    
    self.titleView = [[LMSMusicListView alloc]initWithFrame:self.listImageView.frame];
    self.titleView.backgroundColor = [UIColor clearColor];
    [self.listImageView addSubview:_titleView];
}

- (void)createImages {
    
    //_rankModel是从排行榜传过来的，
    if (self.rankModel) {
        [self.listImageView sd_setImageWithURL:[NSURL URLWithString:self.rankModel.pic] placeholderImage:[UIImage imageNamed:@"musicpic"]];
        self.titleView.titleLabel.text = self.rankModel.title;
        self.title = self.rankModel.title;
        self.titleView.descLabel.text = self.rankModel.desc;
        self.titleView.listenCountLabel.text = [NSString stringWithFormat:@"%@",self.rankModel.song_count];
        self.title = self.rankModel.title;
    }else if(self.songListModel){
        //_songListModel发现页面传过来的
        [self.listImageView sd_setImageWithURL:[NSURL URLWithString:self.songListModel.picUrl] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        //_titleView.titleLabel.text = _songListModel.name;
        self.title = self.songListModel.name;
        self.titleView.descLabel.text = _songListModel.desc;
        self.titleView.listenCountLabel.text = [NSString stringWithFormat:@"%@",self.songListModel.listenCount];
    }else if(self.listModel){
        //_listModel歌单页
        [self.listImageView sd_setImageWithURL:[NSURL URLWithString:self.listModel.pic_url] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        //_titleView.titleLabel.text = _listModel.title;
        self.title = self.listModel.title;
        self.titleView.descLabel.text = self.listModel.desc;
        self.titleView.listenCountLabel.text = [NSString stringWithFormat:@"%@",self.listModel.listen_count];
//    }else if(self.albumModel){
//        //专辑
//        [_listImageView sd_setImageWithURL:[NSURL URLWithString:_albumModel.picUrl] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
//        _titleView.titleLabel.text = _albumModel.name;
//        self.title = _albumModel.name;
//        _titleView.descLabel.text = _albumModel.singerName;
//        _titleView.listenCountLabel.hidden = YES;
    }else{
        [_listImageView setImage:[UIImage imageNamed:@"222.png"]];
        // _titleView.titleLabel.text = @"大家在听";
        _titleView.descLabel.text = @"  ";
        _titleView.listenCountLabel.hidden = YES;
        self.title = @"大家在听";
    }

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
