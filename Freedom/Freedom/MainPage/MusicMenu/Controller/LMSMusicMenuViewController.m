//
//  LMSMusicMenuViewController.m
//  Freedom
//
//  Created by dllo on 16/1/21.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import "LMSMusicMenuViewController.h"
#import "LMSMusicListModel.h"
#import "LMSMusicMenuView.h"
#import "LMSMusicListViewController.h"
#import "LMSMusicMenuCollectionViewCell.h"

@interface LMSMusicMenuViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>


@property (nonatomic, retain) NSMutableArray *listModelArray;//歌单页面model
@property (nonatomic, retain) LMSMusicMenuView *menuView;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, copy) NSString *str;
@property (nonatomic, copy) NSString *string;


@end

@implementation LMSMusicMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createView];

    
}

- (void)createView {
    [self createButton];
}

- (void)createButton {
    self.title = @"歌单";
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 25, 25);
    [backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"backlast.png"] forState:UIControlStateNormal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
    
}

- (void)createCollectionView {
    self.number = 1;
    self.menuView = [[LMSMusicMenuView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64 - 49)];
    [self.view addSubview:_menuView];
    
    //collectionView代理
    self.menuView.collectionView.delegate = self;
    self.menuView.collectionView.dataSource = self;
    [self.menuView.hotButton addTarget:self action:@selector(hotButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.menuView.newestButton addTarget:self action:@selector(newestButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.menuView.hotButton.selected = YES;
    
    [self songListData];
    [self newSongListData];
    
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _listModelArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LMSMusicMenuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    LMSMusicListModel *model = self.listModelArray[indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.pic_url] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    //[cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.pic_url]];
    cell.label.text = model.title;
    return cell;
}

-(void)hotButtonClick:(UIButton *)button{
    self.menuView.hotButton.selected = YES;
    self.menuView.newestButton.selected = NO;
    self.number = 1;
    [self songListData];
    [self newSongListData];
    //[_menuView.collectionView reloadData];
}


-(void)newestButtonClick:(UIButton *)button{
    self.menuView.newestButton.selected = YES;
    self.menuView.hotButton.selected = NO;
    self.number = 1;
    [self songListData];
    [self newSongListData];
    //[_menuView.collectionView reloadData];
}

//collection点击方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LMSMusicListViewController *song = [[LMSMusicListViewController alloc]init];
    LMSMusicListModel *model = self.listModelArray[indexPath.row];
    [song setListModel:model];
    [self.navigationController pushViewController:song animated:YES];
}

#pragma mark - 解析数据
-(void)songListData{
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.listModelArray = [[NSMutableArray alloc]init];
    if (self.menuView.hotButton.selected == YES) {
        self.str = @"http://so.ard.iyyin.com/s/songlist?s=s200&size=10&hid=6125550060252570&q=tag%3A%E6%9C%80%E7%83%AD&net=2&app=ttpod&v=v8.1.0.2015071519&alf=alf700159&tid=0&uid=863583022034533&f=f168&page=1&imsi=460026046186283";
        
    }else if(self.menuView.newestButton.selected == YES){
        self.str =@"http://so.ard.iyyin.com/s/songlist?s=s200&size=10&hid=6125550060252570&q=tag%3A%E6%9C%80%E6%96%B0&net=2&app=ttpod&v=v8.1.0.2015071519&alf=alf700159&tid=0&uid=863583022034533&f=f168&page=1&imsi=460026046186283";
        
    }
    
    //    NSURL *url = [NSURL URLWithString:_str];
    //    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //    NSMutableDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    [LMSAFNetTool getNetWithURL:self.str body:nil headFile:nil responseStyle:LMSJSON success:^(NSURLSessionDataTask *task, id responseObject) {
        
                NSArray *dataArray = [responseObject objectForKey:@"data"];
                for (NSDictionary *myDic in dataArray) {
                    LMSMusicListModel *model = [[LMSMusicListModel alloc]init];
                    [model setValuesForKeysWithDictionary:myDic];
                    [self.listModelArray addObject:model];
                }
                [self.menuView.collectionView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];

}




-(void)newSongListData{
    [self.menuView.collectionView setMj_reloadDataBlock:^(NSInteger number) {
        _number ++;
        if (_menuView.hotButton.selected == YES) {
            self.string = @"http://so.ard.iyyin.com/s/songlist?s=s200&size=10&hid=6125550060252570&q=tag%3A%E6%9C%80%E7%83%AD&net=2&app=ttpod&v=v8.1.0.2015071519&alf=alf700159&tid=0&uid=863583022034533&f=f168&page=1&imsi=460026046186283";
        }else if (_menuView.newestButton.selected == YES){
            self.string = @"http://so.ard.iyyin.com/s/songlist?s=s200&size=10&hid=6125550060252570&q=tag%3A%E6%9C%80%E6%96%B0&net=2&app=ttpod&v=v8.1.0.2015071519&alf=alf700159&tid=0&uid=863583022034533&f=f168&page=1&imsi=460026046186283";
        }
        NSString *sss = [NSString stringWithFormat:@"page=%ld",self.number];
        self.string = [self.string stringByReplacingOccurrencesOfString:@"page=1" withString:sss];
        //            NSURL *url = [NSURL URLWithString:_str1];
        //            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        //            NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        //            NSMutableDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        [LMSAFNetTool getNetWithURL:self.string body:nil headFile:nil responseStyle:LMSJSON success:^(NSURLSessionDataTask *task, id responseObject) {
            
            NSArray *dataArray = [responseObject objectForKey:@"data"];
            for (NSDictionary *myDic in dataArray) {
                LMSMusicListModel *model = [[LMSMusicListModel alloc]init];
                [model setValuesForKeysWithDictionary:myDic];
                [self.listModelArray addObject:model];
            }
            [self.menuView.collectionView reloadData];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            
        }];
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
