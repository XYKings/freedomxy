//
//  LMSRankViewController.m
//  Freedom
//
//  Created by dllo on 16/1/21.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import "LMSRankViewController.h"
#import "LMSRankListModel.h"
#import "LMSRankListTableViewCell.h"
#import "LMSMusicListViewController.h"

@interface LMSRankViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,retain)NSMutableArray *rankListModelArray;
@property(nonatomic,retain)NSMutableArray *rankListSongArray;//三首歌装进一个数组
@property(nonatomic,retain)UITableView *rankListTableView;

@end


@implementation LMSRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createView];
    [self rankListData];
    
}
- (void)createView {
    [self createButton];
    [self createTableView];
    self.rankListModelArray = [NSMutableArray array];
    self.rankListSongArray = [NSMutableArray array];
}
- (void)createButton {
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 25, 25);
    [backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"backlast.png"] forState:UIControlStateNormal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
    self.navigationItem.title = @"排行榜";
    
}
- (void)createTableView {

    
    self.rankListTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64- 49) style:UITableViewStylePlain];
    self.rankListTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.rankListTableView];
    self.rankListTableView.dataSource = self;
    self.rankListTableView.delegate = self;
    self.rankListTableView.bounces = NO;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.rankListModelArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"celll";
    LMSRankListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[LMSRankListTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    LMSRankListModel *model = _rankListModelArray[indexPath.row];
    [cell rankListInfo:model];
    cell.songLabel1.text = [NSString stringWithFormat:@"1.%@",[self.rankListSongArray[indexPath.row][0] name]];
    cell.songLabel2.text = [NSString stringWithFormat:@"2.%@",[self.rankListSongArray[indexPath.row][1] name]];
    cell.songLabel3.text = [NSString stringWithFormat:@"3.%@",[self.rankListSongArray[indexPath.row][2] name]];
    
    return cell;
}

//cell点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LMSMusicListViewController *song = [[LMSMusicListViewController alloc]init];
    LMSRankListModel *model = self.rankListModelArray[indexPath.row];
    [song setRankModel:model];
    [self.navigationController pushViewController:song animated:YES];
}
#pragma mark - 数据解析

-(void)rankListData{
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *str = @"http://api.songlist.ttpod.com/channels/bhb/children?";
    
    [LMSAFNetTool getNetWithURL:str body:nil headFile:nil responseStyle:LMSJSON success:^(NSURLSessionDataTask *task, id responseObject) {
        for (NSDictionary *dic in responseObject) {
            NSArray *refsArray = [dic objectForKey:@"refs"];
            for (NSDictionary *mydic in refsArray) {
                LMSRankListModel *model = [[LMSRankListModel alloc]init];
                
                [model setValuesForKeysWithDictionary:mydic];
                NSDictionary *imageDic = [mydic objectForKey:@"image"];
                model.pic = [imageDic objectForKey:@"pic"];
                [_rankListModelArray addObject:model];

                NSMutableArray *songArray = [[NSMutableArray alloc]init];
                NSArray *songsArray = [mydic objectForKey:@"songs"];
                for (NSDictionary *ddd in songsArray) {
                    LMSRankListModel *song = [[LMSRankListModel alloc]init];
                    [song setValuesForKeysWithDictionary:ddd];
                    [songArray addObject:song];

                }
                [self.rankListSongArray addObject:songArray];
            }
        }
        [self.rankListTableView reloadData];

        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    
        
}


-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
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
