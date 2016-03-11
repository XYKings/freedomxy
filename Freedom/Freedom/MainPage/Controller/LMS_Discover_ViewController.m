//
//  LMS_Discover_ViewController.m
//  Freedom
//
//  Created by dllo on 16/1/19.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import "LMS_Discover_ViewController.h"
#import "LMSDiscoverView.h"
#import "LMSDiscoverModel.h"
#import "LMSRankViewController.h"
#import "LMSMusicMenuViewController.h"



@interface LMS_Discover_ViewController ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, SDCycleScrollViewDelegate>

@property (nonatomic, retain) UIScrollView *homeScrollView;
@property (nonatomic, retain) NSMutableArray *sectionArray;//section标题
@property (nonatomic, retain) NSMutableArray *discoverModelArray;//find页面所有信息
@property (nonatomic, retain) NSMutableArray *cycleArray;//轮播图所有信息
@property (nonatomic, retain) NSMutableArray *cyclePictureArray;//轮播图图片
@property (nonatomic, retain) LMSDiscoverModel *findSongModel;
@property (nonatomic, retain) NSMutableArray *sortArray;//快捷分类

@property (nonatomic, retain) LMSDiscoverView *discoverView;

@property (nonatomic, retain) UITableView *tableView;

@end

@implementation LMS_Discover_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createView];
    
    
}

- (void)createView {
    
    self.discoverView = [[LMSDiscoverView alloc]initWithFrame:CGRectMake(_homeScrollView.frame.size.width * 2, 0, self.view.frame.size.width, _homeScrollView.frame.size.height)];
    [_homeScrollView addSubview:self.discoverView];
    self.discoverView.backgroundColor = [UIColor clearColor];

    self.discoverView.findTableView.delegate = self;
    self.discoverView.findTableView.dataSource = self;
    //快捷分类添加点击方法
    UITapGestureRecognizer *tapGesFirst = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rankButtonClick)];
    [self.discoverView.rankImageView addGestureRecognizer:tapGesFirst];

    
    UITapGestureRecognizer *tapGesSecond = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(listButtonClick)];
    [self.discoverView.listImageView addGestureRecognizer:tapGesSecond];

    
//    UITapGestureRecognizer *tapGesThird = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(radioImageViewClick)];
//    [self.discoverView.radioImageView addGestureRecognizer:tapGesThird];
//
//    
//    UITapGestureRecognizer *tapGesFourth = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singerButtonClick)];
//    [self.discoverView.singerImageView addGestureRecognizer:tapGesFourth];
//    
//    self.discoverView.cycleView.delegate = self;
    
    [self createTableView];
    
}


//快捷分类-->排行榜点击方法
-(void)rankButtonClick{
    LMSRankViewController *rank = [[LMSRankViewController alloc]init];
    [self.navigationController pushViewController:rank animated:YES];
}

//快捷分类-->歌单点击方法
-(void)listButtonClick{
    LMSMusicMenuViewController *songMenu = [[LMSMusicMenuViewController alloc]init];
    [self.navigationController pushViewController:songMenu animated:YES];
}

////快捷分类-->电台点击方法
//-(void)radioImageViewClick{
//    RadioViewController *radio = [[RadioViewController alloc]init];
//    [self.navigationController pushViewController:radio animated:YES];
//}
//
////快捷分类-->歌手点击方法
//-(void)singerButtonClick{
//    SingerViewController *singer = [[SingerViewController alloc]init];
//    [self.navigationController pushViewController:singer animated:YES];
//}

- (void)createTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionArray.count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return _sectionArray[section];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 4;
            break;
        case (2 , 3 , 5 , 6 , 8):
            return 2;
            break;
        case 4:
            return 4;
            break;
        case 7:
            return 9;
            break;
        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 || indexPath.section == 2) {
        return self.view.frame.size.width / 3 + 30;
    }
    return 80;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//        static NSString *cellId = @"cell";
//    if (indexPath.section == 1 || indexPath.section == 2) {
//        FindListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//        if (!cell) {
//            cell = [[FindListTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId2];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            for (int i = 0; i < 3; i++) {
//                UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageClick:)];
//                [[cell viewWithTag:100 + i] addGestureRecognizer:tapImage];
//                [tapImage release];
//            }
//        }
//        for (int i = 0; i < 3; i++ ) {
//            FindModel *model = _findModelArray[indexPath.section][indexPath.row * 3 + i];
//            UIImageView * imageView = (UIImageView *)[cell viewWithTag:100 + i];
//            [imageView sd_setImageWithURL:[NSURL URLWithString:model.picUrl] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
//            UILabel *label = (UILabel *)[cell viewWithTag:200 + i];
//            label.text = model.name;
//        }
//        return cell;
//        
//    }else{
//        FindTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//        if (!cell) {
//            cell = [[FindTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
//            cell.selectionStyle = UITableViewCellAccessoryNone;
//        }
//        FindModel *model = _findModelArray[indexPath.section][indexPath.row];
//        [cell findDataInfo:model];
//        [cell.findImageView sd_setImageWithURL:[NSURL URLWithString:model.picUrl] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
//        return cell;
//    }
//
//    
//    
//}


#pragma mark - 发现页面数据解析
-(void)findData{
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *string = @"http://api.dongting.com/frontpage/frontpage?v=v8.1.0.2015071519&f=f168&s=s200&version=0";
    
    [LMSAFNetTool getNetWithURL:string body:nil headFile:nil responseStyle:LMSJSON success:^(NSURLSessionDataTask *task, id responseObject) {
        [_discoverModelArray removeAllObjects];
        NSArray *bigDataArray = [responseObject objectForKey:@"data"];
        for (int i = 0; i < bigDataArray.count - 2; i++) {
            NSDictionary *dic = bigDataArray[i];
            //轮播图
            if (i == 0) {
                NSArray *dataArray = [dic objectForKey:@"data"];
                for (NSDictionary *myDic in dataArray) {
                    LMSDiscoverModel *discoverModel = [[LMSDiscoverModel alloc]init];
                    [discoverModel setValuesForKeysWithDictionary:myDic];
                    NSDictionary *actionDic = [myDic objectForKey:@"action"];
                    [discoverModel setValuesForKeysWithDictionary:actionDic];
                    [_cycleArray addObject:discoverModel];
                    [_cyclePictureArray addObject:discoverModel.picUrl];
                }
            }else if(i == 1){
                //快捷分类
                NSArray *dataArray = [dic objectForKey:@"data"];
                for (NSDictionary *myDic in dataArray){
                    //图片和标题装进了同一个数组
                    LMSDiscoverModel *model = [[LMSDiscoverModel alloc]init];
                    model.picUrl = [myDic objectForKey:@"picUrl"];
                    [self.sortArray addObject:model.picUrl];
                    model.name = [myDic objectForKey:@"name"];
                    [self.sortArray addObject:model.name];
                }
            }else if(i == 2){
                //大家在听
                LMSDiscoverModel *discoverModel = [[LMSDiscoverModel alloc]init];
                discoverModel.sectionName = [dic objectForKey:@"name"];
                [_sectionArray addObject:discoverModel.sectionName];
                NSArray *dataArray = [dic objectForKey:@"data"];
                NSMutableArray *everySectionArray = [[NSMutableArray alloc]init];
                NSDictionary *myDic = dataArray[0];
                NSArray *songsArray = [myDic objectForKey:@"songs"];
                for (NSDictionary *songDic in songsArray) {
                    LMSDiscoverModel *model = [[LMSDiscoverModel alloc]init];
                    [model setValuesForKeysWithDictionary:songDic];
                    //歌曲地址
                    NSArray *auditionListArray = [songDic objectForKey:@"auditionList"];
                    if (model.auditionList.count > 1) {
                        NSDictionary *auditionDic = auditionListArray[1];
                        model.url = [auditionDic objectForKey:@"url"];
                    }else if(model.auditionList.count > 0){
                        NSDictionary *auditionDic = auditionListArray[0];
                        model.url = [auditionDic objectForKey:@"url"];
                    }
                    [everySectionArray addObject:model];
                }
                [_discoverModelArray addObject:everySectionArray];
            }else if (i == 6){
                //新碟上架
                NSMutableArray *everySectionArray = [[NSMutableArray alloc]init];
                NSArray *dataArray = [dic objectForKey:@"data"];
                NSDictionary *dic = dataArray[1];
                LMSDiscoverModel *discoverModel = [[LMSDiscoverModel alloc]init];
                discoverModel.sectionName = [dic objectForKey:@"name"];
                [_sectionArray addObject:discoverModel.sectionName];
                discoverModel.picUrl = [dic objectForKey:@"picUrl"];
                discoverModel.name = [dic objectForKey:@"desc"];
                [everySectionArray addObject:discoverModel];
                [_discoverModelArray addObject:everySectionArray];
            }else{
                //其他信息
                LMSDiscoverModel *discoverModel = [[LMSDiscoverModel alloc]init];
                discoverModel.sectionName = [dic objectForKey:@"name"];
                [_sectionArray addObject:discoverModel.sectionName];
                NSArray *dataArray = [dic objectForKey:@"data"];
                //每个section的model存进一个小数组，再把小数组存进_finfModelArray
                NSMutableArray *everySectionArray = [[NSMutableArray alloc]init];
                for (NSDictionary *myDic in dataArray) {
                    LMSDiscoverModel *model = [[LMSDiscoverModel alloc]init];
                    [model setValuesForKeysWithDictionary:myDic];
                    NSDictionary *actionDic = [myDic objectForKey:@"action"];
                    [model setValuesForKeysWithDictionary:actionDic];
                    [everySectionArray addObject:model];
                }
                [_discoverModelArray addObject:everySectionArray];
            }
        }
        
        //快捷分类
        if (7 < self.sortArray.count) {
            [self.discoverView.rankImageView sd_setImageWithURL:[NSURL URLWithString:self.sortArray[0]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
            [self.discoverView.listImageView sd_setImageWithURL:[NSURL URLWithString:self.sortArray[2]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
            [self.discoverView.radioImageView sd_setImageWithURL:[NSURL URLWithString:self.sortArray[4]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
            [self.discoverView.singerImageView sd_setImageWithURL:[NSURL URLWithString:self.sortArray[6]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
            self.discoverView.rangLabel.text = self.sortArray[1];
            self.discoverView.listLabel.text = self.sortArray[3];
            self.discoverView.radioLabel.text = self.sortArray[5];
            self.discoverView.singerLabel.text = self.sortArray[7];
        }
        [self.discoverView.cycleView setImageURLStringsGroup:_cyclePictureArray];//轮播图
        [self.discoverView.findTableView reloadData];
//        [MBProgressHUD hideHUDForView:self.view animated:YES];

        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
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
