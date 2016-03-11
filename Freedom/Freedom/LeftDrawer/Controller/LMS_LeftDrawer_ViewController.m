//
//  LMS_LeftDrawer_ViewController.m
//  Freedom
//
//  Created by dllo on 16/1/12.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import "LMS_LeftDrawer_ViewController.h"
#import "ViewController.h"
@interface LMS_LeftDrawer_ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, assign) CGFloat path;

@end

@implementation LMS_LeftDrawer_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *back = [[UIImageView alloc] initWithFrame:self.view.frame];
    back.image = [UIImage imageNamed:@"抽屉背景"];
    [self.view addSubview:back];
    
    [self createView];
}

- (void)viewWillAppear:(BOOL)animated {
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    self.path = [self folderSizeAtPath:path];
    [self.tableView reloadData];
}

#pragma mark - 创建View
- (void)createView {
    [self createTableView];
}
- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, HEIGHT / 2 - 200, WIDTH - 100, 400) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//没有线
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSString *str = [NSString stringWithFormat:@"清除缓存: (%.2fMB)", self.path];
    NSArray *arr = @[@"来张照片吧", @"我的收藏", str];
    cell.textLabel.text = arr[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.row) {
        ViewController *cameraVC = [[ViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:cameraVC];
        nav.navigationBar.translucent = NO;
        [self presentViewController:nav animated:YES completion:nil];
    }
    
    else if (2 == indexPath.row) {
        
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        
        if (0 == [self folderSizeAtPath:path]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"当前无缓存" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [self clearCache:path];
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
                
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
                
            }]];
            [self presentViewController:alert animated:YES completion:^{
                
            }];
            
        } else {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"你确定要删除 %.2fMB 的缓存么?", [self folderSizeAtPath:path]] preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [self clearCache:path];
                self.path = [self folderSizeAtPath:path];
                [self.tableView reloadData];
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
                
            }]];
            [self presentViewController:alert animated:YES completion:^{
                
            }];
        }
    }
}

//单个文件的大小
- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
    
}
//遍历文件夹获得文件夹大小，返回多少M
- (float) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath] ;
    }
    return folderSize/(1024.0*1024.0) + [[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
}

- (void)clearCache:(NSString *)path {
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
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
