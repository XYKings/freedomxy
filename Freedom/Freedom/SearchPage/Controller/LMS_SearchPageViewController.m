//
//  LMS_SearchPageViewController.m
//  Freedom
//
//  Created by dllo on 16/1/18.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import "LMS_SearchPageViewController.h"
#import "LMS_SearchPageCollectionViewCell.h"
#import "LMS_MVPlayerViewController.h"
#import "LMSAFNetTool.h"
#import "LMS_VideoModel.h"
#import "LMS_MVModel.h"
#import <Masonry.h>

#define COLORSTYLE [UIColor colorWithRed:1.000 green:0.710 blue:0.773 alpha:1.000]
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface LMS_SearchPageViewController () <UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate, SearchPageDelegate>

@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) UIView *chooseV;
@property (nonatomic, retain) UIButton *songButton;
@property (nonatomic, retain) UIButton *mvButton;
@property (nonatomic, retain) UIView *chooseView;
@property (nonatomic, retain) UICollectionView *collectionV;
@property (nonatomic, retain) NSMutableDictionary *dic;

@end

@implementation LMS_SearchPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.backgroundColor = COLORSTYLE;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mc_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    
    [self createCollectionView];
    [self createSearchBar];
    [self createChooseView];}

#pragma 创建searchBar
- (void)createSearchBar {
    
    self.searchBar = [[UISearchBar alloc] init];
    [self.navigationController.navigationBar addSubview:self.searchBar];
    self.searchBar.frame = CGRectMake(0, 0, 300, 80);
    self.searchBar.center = CGPointMake(self.navigationController.navigationBar.center.x + 20, 22);
    [self.searchBar becomeFirstResponder];
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"单曲、MV";
}

#pragma 搜索 - 开始输入
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
   [self.searchBar becomeFirstResponder];
}

#pragma 搜索 - 点击搜索
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    self.dic = [NSMutableDictionary dictionary];
    [self getSongData:searchBar.text];
    [self getMVData:searchBar.text];
    [self.searchBar resignFirstResponder];
}

#pragma 创建选择栏
- (void)createChooseView {
    
    self.chooseV = [[UIView alloc] init];
    [self.view addSubview:self.chooseV];
    [self.chooseV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view);
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(36);
    }];
    self.chooseV.backgroundColor = [UIColor colorWithWhite:0.921 alpha:1.000];
    
    // 单曲
    self.songButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.chooseV addSubview:self.songButton];
    [self.songButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.bottom.equalTo(self.chooseV);
        make.left.equalTo(self.chooseV);
        make.width.mas_equalTo(WIDTH / 2);
    }];
    [self.songButton setTitle:@"单曲" forState:UIControlStateNormal];
    self.songButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.songButton setTitleColor:COLORSTYLE forState:UIControlStateNormal];
    [self.songButton addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    self.songButton.tag = 10001;
    
    
    // MV
    self.mvButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.chooseV addSubview:self.mvButton];
    [self.mvButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.bottom.equalTo(self.chooseV);
        make.left.equalTo(self.songButton.mas_right);
        make.width.equalTo(self.songButton);
    }];
    [self.mvButton setTitle:@"MV" forState:UIControlStateNormal];
    self.mvButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.mvButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.mvButton addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    self.mvButton.tag = 10002;
    
    // 选择条
    self.chooseView = [[UIView alloc] initWithFrame:CGRectMake(0, 34, WIDTH / 2, 2)];
    self.chooseView.backgroundColor = COLORSTYLE;
    [self.chooseV addSubview:self.chooseView];
}

#pragma 选择项
- (void)chooseAction:(UIButton *)sender {
    
    [self.searchBar resignFirstResponder];
    switch (sender.tag) {
        case 10001:
            [self.songButton setTitleColor:COLORSTYLE forState:UIControlStateNormal];
         
            [self.mvButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            break;
        case 10002:
            [self.songButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                      [self.mvButton setTitleColor:COLORSTYLE forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    
    // 滑动动画
    [UIView animateWithDuration:0.3 animations:^{
        
        self.chooseView.frame = CGRectMake(sender.frame.origin.x, 34, WIDTH / 2, 2);
    }];
    
    self.collectionV.contentOffset = CGPointMake(WIDTH * (sender.tag - 10001), 0);
}

#pragma 请求单曲数据
- (void)getSongData:(NSString *)text {
    
    [LMSAFNetTool getNetWithURL:[NSString stringWithFormat:@"http://search.dongting.com/song/search?q=%@&page=1&size=20", text] body:nil headFile:nil responseStyle:LMSJSON success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSMutableArray *arr = responseObject[@"data"];
        for (NSMutableDictionary *dic in arr) {
            
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma 请求MV数据
- (void)getMVData:(NSString *)text {
    
    [LMSAFNetTool getNetWithURL:[NSString stringWithFormat:@"http://search.dongting.com/mv/search?q=%@&page=1&size=20", text] body:nil headFile:nil responseStyle:LMSJSON success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSMutableArray *mvArr = [NSMutableArray array];
        NSMutableArray *arr = responseObject[@"data"];
        for (NSMutableDictionary *dic in arr) {
           
            if (![dic[@"mvList"] isKindOfClass:[NSNull class]]) {
                
                LMS_VideoModel *video = [[LMS_VideoModel alloc] initWithDictionary:dic];
                video.mvList = [NSMutableArray array];
                for (NSMutableDictionary *mvDic in dic[@"mvList"]) {
                    
                    LMS_MVModel *mv = [[LMS_MVModel alloc] initWithDictionary:mvDic];
                    [video.mvList addObject:mv];
                }
                [mvArr addObject:video];
            }
            else {
                
                continue;
            }
        }
        [self.dic setObject:mvArr forKey:@"mv"];
        [self.collectionV reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma 创建collectionView
- (void)createCollectionView {
    
    UICollectionViewFlowLayout *flowL = [[UICollectionViewFlowLayout alloc] init];
    [flowL setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    flowL.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 36);
    flowL.minimumLineSpacing = 0;
    flowL.sectionInset = UIEdgeInsetsMake(36, 0, 0, 0);
    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.chooseV.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.chooseV.frame.size.height) collectionViewLayout:flowL];
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    [self.view addSubview:self.collectionV];
    self.collectionV.pagingEnabled = YES;
    self.collectionV.bounces = NO;
    [self.collectionV registerClass:[LMS_SearchPageCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}

#pragma collectionView块数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 2;
}

#pragma collectionViewCell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    LMS_SearchPageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.dic = self.dic;
    cell.row = indexPath.row;
    return cell;
}

#pragma 滑动collectionView
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self.searchBar resignFirstResponder];
    // 滑动动画
    [UIView animateWithDuration:0.3 animations:^{
        
        self.chooseView.frame = CGRectMake(self.collectionV.contentOffset.x / 2, 34, WIDTH / 2, 2);
    }];
    if (self.chooseView.frame.origin.x == 0) {
        
        [self.songButton setTitleColor:COLORSTYLE forState:UIControlStateNormal];
      
        [self.mvButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }

    else {
        
        [self.songButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

        [self.mvButton setTitleColor:COLORSTYLE forState:UIControlStateNormal];
    }
}

#pragma 跳转播放
- (void)playMV:(NSString *)videoId {
    
    LMS_MVPlayerViewController *mvVC = [[LMS_MVPlayerViewController alloc] init];
    mvVC.videoId = videoId;
    [self presentViewController:mvVC animated:YES completion:^{
        
    }];
}


#pragma 返回
- (void)backAction {
    
    [self.searchBar removeFromSuperview];
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
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
