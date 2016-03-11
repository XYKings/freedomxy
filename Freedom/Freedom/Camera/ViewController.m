//
//  ViewController.m
//  SYCaremaDemo
//
//  Created by dllo on 16/1/13.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ViewController.h"
#import "SelectSpecialView.h"
#import "CameraManager.h"
#import "CameraFIlters.h"
#import "ReviseViewController.h"
#import <GPUImage.h>
#import <Photos/Photos.h>



@interface ViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate>
{
    GPUImageStillCamera *videoCamera;
}


@property (nonatomic, strong) NSArray *filterArray;
@property (nonatomic, strong) CameraManager *cameraManager;

@property (nonatomic, strong) SelectSpecialView *selectView;

@property (nonatomic, strong) UIImageView *viewContainer;
@property (nonatomic, strong) UIToolbar *footerToolBar;
@property (nonatomic, strong) UIButton *takePhoto;
@property (nonatomic, strong) UIButton *changeCamera;
@property (nonatomic, strong) UIButton *changeFlashModleTypeButton;
@property (nonatomic, strong) UIButton *selectSpecial;
@property (nonatomic, strong) UIImageView *smallPhoto;
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.cameraManager startCamera];
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dic;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = COLORSTYLE;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"<返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
    [self createSubViews];
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (NSArray *)filterArray {
    if (!_filterArray) {
        GPUImageFilterGroup *f1 = [CameraFIlters normal];
        [videoCamera addTarget:f1];
        
        GPUImageFilterGroup *f2 = [CameraFIlters contrast];
        [videoCamera addTarget:f2];
        
        GPUImageFilterGroup *f3 = [CameraFIlters exposure];
        [videoCamera addTarget:f3];
        
        GPUImageFilterGroup *f4 = [CameraFIlters saturation];
        [videoCamera addTarget:f4];
        
        GPUImageFilterGroup *f5 = [CameraFIlters testGroup];
        [videoCamera addTarget:f5];
        
        GPUImageFilterGroup *f6 = [CameraFIlters dianyatexiao];
        [videoCamera addTarget:f6];
        
        GPUImageFilterGroup *f7 = [CameraFIlters sumiaotexiao];
        [videoCamera addTarget:f7];
        
        GPUImageFilterGroup *f8 = [CameraFIlters shenhesetexiao];
        [videoCamera addTarget:f8];
        
        GPUImageFilterGroup *f9 = [CameraFIlters ruihuatexiao];
        [videoCamera addTarget:f9];
        
        GPUImageFilterGroup *f10 = [CameraFIlters fudiaotexiao];
        [videoCamera addTarget:f10];
        
        NSArray *arr = [NSArray arrayWithObjects:f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,nil];
        _filterArray = arr;
    }
    return _filterArray;
}

- (CameraManager *)cameraManager {
    if (!_cameraManager) {
        CameraManager *camearManager = [[CameraManager alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - HEIGHT / 7.0 - 64) superview:self.view];
        [camearManager addFilters:self.filterArray];
        [camearManager setFocusImage:[UIImage imageNamed:@"对焦"]];
        _cameraManager = camearManager;
    }
    return _cameraManager;
}

#pragma mark - 创建拍照显示拍照按钮的FooterBar
- (void)createFooterBar {
    self.footerToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, HEIGHT - (HEIGHT / 7.0) - 64, WIDTH, HEIGHT / 7.0)];
    self.footerToolBar.barTintColor = COLORSTYLE;
    [self.view addSubview:self.footerToolBar];
}

#pragma mark - 选择特效
- (void)selectSpecialAction {
    self.footerToolBar.hidden = YES;
    self.selectView.hidden = NO;
    __weak ViewController *weakSelf = self;
    [self.selectView selectIndex:^(NSInteger index) {
        [weakSelf.cameraManager setFilterAtIndex:index];
        self.selectView.hidden = YES;
        self.footerToolBar.hidden = NO;
    }];
}

#pragma mark - 创建显示特效的视图
- (void)createSelectView {
    self.selectView = [[SelectSpecialView alloc] initWithFrame:CGRectMake(0, HEIGHT - (HEIGHT / 7.0) - 64, WIDTH, HEIGHT / 7.0)];
    [self.selectView addFilters:self.filterArray];
    [self.view addSubview:self.selectView];
    self.selectView.hidden = YES;
}

#pragma mark - 拍照
- (void)takePhotoAction {
    [self.cameraManager takePhotoSuccess:^(UIImage *image) {
        [self isSaveImage:image];
        [self.cameraManager stopCamera];
    } failure:^{
        
    }];
}

- (void)isSaveImage:(UIImage *)image {
    UIScrollView *view = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - HEIGHT / 7.0 - 64)];
    view.backgroundColor = [UIColor blackColor];
    view.contentSize = CGSizeMake(WIDTH, HEIGHT - HEIGHT / 7.0 - 64);
    view.showsVerticalScrollIndicator = NO;
    view.showsHorizontalScrollIndicator = NO;
    view.bounces = YES;
    view.alwaysBounceVertical = YES;//用这个方法可以保证随时可以移动
    view.alwaysBounceHorizontal = YES;
    view.minimumZoomScale = 1.0;
    view.maximumZoomScale = 2.0;
    view.delegate = self;
    [self.view addSubview:view];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH * image.size.height / image.size.width)];
    imageview.center = view.center;
    imageview.image = image;
    imageview.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapWithImageView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
    [imageview addGestureRecognizer:tapWithImageView];
    [view addSubview:imageview];
    [view bringSubviewToFront:imageview];
}

- (void)tapImage:(UITapGestureRecognizer *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"重新拍" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        UIImageView *imageView = (UIImageView *)sender.view;
        UIScrollView *tempView = (UIScrollView *)[imageView superview];
        [sender.view removeFromSuperview];
        [tempView removeFromSuperview];
        [self.cameraManager startCamera];
    }]];

    [alert addAction:[UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImageView *imageView = (UIImageView *)sender.view;
        UIScrollView *tempView = (UIScrollView *)[imageView superview];
        UIImageWriteToSavedPhotosAlbum(imageView.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
        [sender.view removeFromSuperview];
        [tempView removeFromSuperview];
        [self.cameraManager startCamera];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *message = @"";
    if (!error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self getLastPhotoFromAlbum];
        });
    }else
    {
        message = [error description];
    }
    NSLog(@"message is %@",message);
}

#pragma mark - 从系统相册中找出最后一张照片
- (void)getLastPhotoFromAlbum {
    // 获取所有资源的集合，并按资源的创建时间排序
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    
    // 在资源的集合中获取第一个集合，并获取其中的图片
    PHCachingImageManager *imageManager = [[PHCachingImageManager alloc] init];
    PHAsset *asset = [assetsFetchResults lastObject];
    [imageManager requestImageForAsset:asset
                            targetSize:PHImageManagerMaximumSize
                           contentMode:PHImageContentModeAspectFill
                               options:nil
                         resultHandler:^(UIImage *result, NSDictionary *info) {
                             // 得到一张 UIImage，展示到界面上
                             self.smallPhoto.image = result;
                         }];
}

#pragma mark - 轻拍照片的方法
- (void)tapWithPhotoInAlbum:(UITapGestureRecognizer *)tap {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;

    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = [info objectForKeyedSubscript:UIImagePickerControllerOriginalImage];
    [self reviseImage:image];
    [self.cameraManager stopCamera];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)reviseImage:(UIImage *)image {
    ReviseViewController *revise = [[ReviseViewController alloc] init];
    [revise createImageViewWithImage:image];
    [self.navigationController pushViewController:revise animated:YES];
}
#pragma mark - 切换摄像头
- (void)changeCameraAction {
    if (self.cameraManager.syposition == SYDevicePositionBack) {
        [self.cameraManager setSyposition:SYDevicePositionFront];
    } else {
        self.cameraManager.syposition = SYDevicePositionBack;
    }
}
#pragma mark - 改变闪光灯状态
- (void)changeFlashModleTypeButtonAction:(UIButton *)sender {
    switch (self.cameraManager.syflashModel) {
        case SYCameraManagerFlashModeAuto:
            self.cameraManager.syflashModel = SYCameraManagerFlashModeOn;
            [sender setImage:[UIImage imageNamed:@"闪光灯开启"] forState:UIControlStateNormal];
            break;
        case SYCameraManagerFlashModeOn:
            self.cameraManager.syflashModel = SYCameraManagerFlashModeOff;
            [sender setImage:[UIImage imageNamed:@"闪光灯关闭"] forState:UIControlStateNormal];
            break;
        case SYCameraManagerFlashModeOff:
            self.cameraManager.syflashModel = SYCameraManagerFlashModeAuto;
            [sender setImage:[UIImage imageNamed:@"闪光灯智能"] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

- (void)createSubViews {
    [self createFooterBar];
    [self createSelectView];
    [self createButton];
    [self createFooterPhoto];
    
}

- (void)createButton {
    [self createTakePhotoButton];
    [self createChangeFlastModelTypeButton:SYCameraManagerFlashModeAuto];
    [self createChangeCameraButton];
    [self createSelectSpecialButton];
    
}
//拍照按钮
- (void)createTakePhotoButton {
    self.takePhoto = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.takePhoto addTarget:self action:@selector(takePhotoAction) forControlEvents:UIControlEventTouchUpInside];
    [self.takePhoto setImage:[UIImage imageNamed:@"拍照"] forState:UIControlStateNormal];
    [self.footerToolBar addSubview:self.takePhoto];
    [self.takePhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.footerToolBar);
        make.size.mas_equalTo(CGSizeMake(self.footerToolBar.frame.size.height * 2 / 3, self.footerToolBar.frame.size.height * 2 / 3));
    }];
}
//切换摄像头
- (void)createChangeCameraButton {
    self.changeCamera = [UIButton buttonWithType:UIButtonTypeCustom];
    self.changeCamera.frame = CGRectMake(0, 0, 40, 40);
    [self.changeCamera addTarget:self action:@selector(changeCameraAction) forControlEvents:UIControlEventTouchUpInside];
    [self.changeCamera setImage:[UIImage imageNamed:@"切换摄像头"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.changeCamera];
}
//创建切换闪光灯按钮(默认按钮为自动补光)
- (void)createChangeFlastModelTypeButton:(SYCameraDeviceFlashModel)flashType {
    self.changeFlashModleTypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.changeFlashModleTypeButton.frame = CGRectMake(0, 0, 40, 40);
    switch (flashType) {
        case SYCameraManagerFlashModeAuto:
            self.cameraManager.syflashModel = SYCameraManagerFlashModeAuto;
            [self.changeFlashModleTypeButton setImage:[UIImage imageNamed:@"闪光灯智能"] forState:UIControlStateNormal];
            break;
        case SYCameraManagerFlashModeOff:
            self.cameraManager.syflashModel = SYCameraManagerFlashModeOff;
            [self.changeFlashModleTypeButton setImage:[UIImage imageNamed:@"闪光灯关闭"] forState:UIControlStateNormal];
            break;
        case SYCameraManagerFlashModeOn:
            self.cameraManager.syflashModel = SYCameraManagerFlashModeOn;
            [self.changeFlashModleTypeButton setImage:[UIImage imageNamed:@"闪光灯开启"] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
    [self.changeFlashModleTypeButton addTarget:self action:@selector(changeFlashModleTypeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = self.changeFlashModleTypeButton;
}
//切换特效
- (void)createSelectSpecialButton {
    self.selectSpecial = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.selectSpecial addTarget:self action:@selector(selectSpecialAction) forControlEvents:UIControlEventTouchUpInside];
    [self.selectSpecial setImage:([UIImage imageNamed:@"特效"]) forState:UIControlStateNormal];
    [self.footerToolBar addSubview:self.selectSpecial];
    [self.selectSpecial mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.footerToolBar.mas_centerY);
        make.width.mas_equalTo(@40);
        make.right.equalTo(self.footerToolBar.mas_right).offset(-50);
    }];
}

//创建footerbar左下角相册的图片
- (void)createFooterPhoto {
    self.smallPhoto = [[UIImageView alloc] init];
    self.smallPhoto.backgroundColor = [UIColor blackColor];
    self.smallPhoto.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapWithPhotoInAlbum:)];
    [self.smallPhoto addGestureRecognizer:tap];
    [self.footerToolBar addSubview:self.smallPhoto];
    [self.smallPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.footerToolBar.mas_centerY);
        make.width.mas_equalTo(@(self.footerToolBar.frame.size.height * 3 / 4));
        make.height.mas_equalTo(@(self.footerToolBar.frame.size.height * 4 / 5));
        make.left.equalTo(self.footerToolBar.mas_left).offset(30);
    }];
    [self getLastPhotoFromAlbum];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
