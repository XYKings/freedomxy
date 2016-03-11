//
//  LMS_MVLookViewController.m
//  Freedom
//
//  Created by dllo on 16/1/21.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import "LMS_MVLookViewController.h"
#import "LMSAFNetTool.h"
#import "LMS_MVLook.h"
#import "LMS_MVModel.h"
#import "LMS_MVLookTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "LMS_MVPlayerViewController.h"
#import <MJRefresh.h>

@interface LMS_MVLookViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *tableV;
@property (nonatomic, retain) NSMutableArray *arr;
@property (nonatomic, assign) NSInteger temp;
@property (nonatomic, assign) NSInteger pages;

@end

@implementation LMS_MVLookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"MV精选";
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dic;
    
    [self createTableView];
    // 下拉刷新
    self.tableV.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self.temp = 0;
        self.pages = 1;
        [self getData];
        // 结束刷新
        [self.tableV.mj_header endRefreshing];
    }];
    
    // 上拉刷新
    self.tableV.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        self.temp = 1;
        self.pages++;
        [self getData];
        // 结束刷新
        [self.tableV.mj_footer endRefreshing];
    }];
    
    [self.tableV.mj_header beginRefreshing];

}

#pragma 请求数据
- (void)getData {
    
    if (self.temp == 0) {
        
        [LMSAFNetTool getNetWithURL:@"http://api.dongting.com/channel/channel/mvs?page=1&size=10" body:nil headFile:nil responseStyle:LMSJSON success:^(NSURLSessionDataTask *task, id responseObject) {
            
            NSMutableArray *arr = responseObject[@"data"];
            self.arr = [NSMutableArray array];
            for (NSMutableDictionary *tempDic in arr) {
                
                if (tempDic[@"songName"] == nil) {
                    
                    return;
                }
                LMS_MVLook *mvLook = [[LMS_MVLook alloc] initWithDictionary:tempDic];
                mvLook.mvList = [NSMutableArray array];
                for (NSMutableDictionary *dic in tempDic[@"mvList"]) {
                    
                    LMS_MVModel *mvModel = [[LMS_MVModel alloc] initWithDictionary:dic];
                    [mvLook.mvList addObject:mvModel];
                }
                [self.arr addObject:mvLook];
            }
            [self.tableV reloadData];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }
    else {
        
        [LMSAFNetTool getNetWithURL:[NSString stringWithFormat:@"http://api.dongting.com/channel/channel/mvs?page=%ld&size=10", self.pages] body:nil headFile:nil responseStyle:LMSJSON success:^(NSURLSessionDataTask *task, id responseObject) {
            
            NSMutableArray *arr = responseObject[@"data"];
            for (NSMutableDictionary *tempDic in arr) {
                
                if (tempDic[@"songName"] == nil) {
                    
                    return;
                }
                LMS_MVLook *mvLook = [[LMS_MVLook alloc] initWithDictionary:tempDic];
                mvLook.mvList = [NSMutableArray array];
                for (NSMutableDictionary *dic in tempDic[@"mvList"]) {
                    
                    LMS_MVModel *mvModel = [[LMS_MVModel alloc] initWithDictionary:dic];
                    [mvLook.mvList addObject:mvModel];
                }
                [self.arr addObject:mvLook];
            }
            [self.tableV reloadData];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }
}

#pragma 创建tableView
- (void)createTableView {
    
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 60) style:UITableViewStylePlain];
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.view addSubview:self.tableV];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.arr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 240;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LMS_MVLook *mvLook = [self.arr objectAtIndex:indexPath.row];
    
    static NSString *cellStr = @"cell";
    LMS_MVLookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];

    if (!cell) {
        
        cell = [[LMS_MVLookTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:mvLook.bigPicUrl] placeholderImage:[UIImage imageNamed:@"图片载入失败icon"]];
    
    if (mvLook.title.length == 5) {
        
        NSRange range1 = {0, 2};
        cell.monthL.text = [mvLook.title substringWithRange:range1];
        
        NSRange range2 = {3, 2};
        cell.dayL.text = [mvLook.title substringWithRange:range2];
    }
    else if(mvLook.title.length == 4) {
        
        NSRange range1 = {0, 2};
        cell.monthL.text = [mvLook.title substringWithRange:range1];
        
        NSRange range2 = {3, 1};
        cell.dayL.text = [mvLook.title substringWithRange:range2];
    }
    else {
        
        NSRange range1 = {0, 1};
        cell.monthL.text = [mvLook.title substringWithRange:range1];
        
        NSRange range2 = {2, 1};
        cell.dayL.text = [mvLook.title substringWithRange:range2];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleL.text = mvLook.desc;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LMS_MVLook *mvLook = [self.arr objectAtIndex:indexPath.row];
    LMS_MVModel *mvModel = [mvLook.mvList firstObject];
    LMS_MVPlayerViewController *mvPlayer = [[LMS_MVPlayerViewController alloc] init];
    mvPlayer.videoId = mvModel.videoId;
    [self presentViewController:mvPlayer animated:YES completion:^{
        
        
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
