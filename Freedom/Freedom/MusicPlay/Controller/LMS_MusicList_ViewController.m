//
//  LMS_MusicList_ViewController.m
//  Freedom
//
//  Created by dllo on 16/1/16.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import "LMS_MusicList_ViewController.h"
#import "LMSPlayerManager.h"
#import "LMS_MusicPlay_ViewController.h"
#import "LMSMusicInfo.h"
#import "LMS_MusicList_TableViewCell.h"

@interface LMS_MusicList_ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *musicListTableView;
@property (nonatomic, retain) LMSPlayerManager *playManager;
//@property (nonatomic, retain) 

@end

@implementation LMS_MusicList_ViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.playManager = [LMSPlayerManager playerManager];
    self.navigationItem.title = @"播放列表";
    [self.playManager getPlayListCompletionHandler:^{
        NSLog(@"请求完成");
        [self.musicListTableView reloadData];
    }];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.musicListTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.musicListTableView.delegate = self;
    self.musicListTableView.dataSource = self;
    [self.musicListTableView registerClass:[LMS_MusicList_TableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.musicListTableView];
    
 
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.playManager.playlistCount;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LMS_MusicList_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    LMSMusicInfo *music = [self.playManager getmusicInfoWithIndext:indexPath.row];
    [cell.musicPic sd_setImageWithURL:[NSURL URLWithString:music.picUrl]];
    cell.musicName.text = music.name;
    if (music.singerName.length != 0) {
        cell.singerName.text = music.singerName;
    }
    if (music.singer.length != 0) {
        cell.singerName.text = music.singer;
    }
//    NSLog(@"%@", music.name);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LMS_MusicPlay_ViewController *playVC = [LMS_MusicPlay_ViewController musicPlay];
    playVC.musicIndex = indexPath.row;
    
    NSUserDefaults *musicIndex = [NSUserDefaults standardUserDefaults];
    [musicIndex setObject:[NSString stringWithFormat:@"%ld", indexPath.row] forKey:@"musicIndex"];
    
    [self presentViewController:playVC animated:YES completion:^{
        
        
    }];
    
//    [self.navigationController pushViewController:playVC animated:YES];

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
