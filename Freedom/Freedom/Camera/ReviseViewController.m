//
//  ReviseViewController.m
//  SYCaremaDemo
//
//  Created by dllo on 16/1/15.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ReviseViewController.h"
#import "ReviseView.h"
#import <QuartzCore/QuartzCore.h>

@interface ReviseViewController () <UIScrollViewDelegate, ReviseViewDelegate>
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIToolbar *footerSpecialView;
@end

@implementation ReviseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dic;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"编辑";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveReviseImage)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(returnCamera)];
    
    [self createSpecialView];
}

- (void)createSpecialView {
    ReviseView *revise = [[ReviseView alloc] initWithFrame:CGRectMake(0, HEIGHT - 139, WIDTH, 75)];
    revise.delegate = self;
    [self.view addSubview:revise];
}
#pragma mark - revise的代理方法(判断给图片剪裁比例)
- (void)caijianWithButtonTag:(NSInteger)tag {
    switch (tag) {
            //1:1
        case 100:
            [self caijianImage];
            break;
        case 101:
            
            break;
        case 102:
            
            break;
        case 103:
            
            break;
            
        default:
            break;
    }
}

#pragma mark - 图片剪裁方法
- (void)caijianImage {
//    self.imageView.image = [self handleImage:self.imageView.image withSize:CGSizeMake(WIDTH, WIDTH)];
    self.imageView.image = [self circleImage:self.imageView.image];
}

-(UIImage*) circleImage:(UIImage*) image {
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.width);
    CGContextAddRect(context, rect);
    CGContextClip(context);
    
    [image drawInRect:rect];
    CGContextAddRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

- (UIImage *)handleImage:(UIImage *)originalImage withSize:(CGSize)size {
    CGSize originalsize = [originalImage size];
    NSLog(@"改变前图片的宽度为%f,图片的高度为%f",originalsize.width,originalsize.height);
    
    //原图长宽均小于标准长宽的，不作处理返回原图
    if (originalsize.width<size.width && originalsize.height<size.height)
    {
        return originalImage;
    }
    
    //原图长宽均大于标准长宽的，按比例缩小至最大适应值
    else if(originalsize.width>size.width && originalsize.height>size.height)
    {
        CGFloat rate = 1.0;
        CGFloat widthRate = originalsize.width/size.width;
        CGFloat heightRate = originalsize.height/size.height;
        
        rate = widthRate>heightRate?heightRate:widthRate;
        
        CGImageRef imageRef = nil;
        
        if (heightRate > widthRate)
        {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(0, originalsize.height/2-size.height*rate/2, originalsize.width, size.height*rate));//获取图片整体部分
        }
        else
        {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(originalsize.width/2-size.width*rate/2, 0, size.width*rate, originalsize.height));//获取图片整体部分
        }
        UIGraphicsBeginImageContext(size);//指定要绘画图片的大小
        CGContextRef con = UIGraphicsGetCurrentContext();
        
        CGContextTranslateCTM(con, 0.0, size.height);
        CGContextScaleCTM(con, 1.0, -1.0);
        
        CGContextDrawImage(con, CGRectMake(0, 0, size.width, size.height), imageRef);
        
        UIImage *standardImage = UIGraphicsGetImageFromCurrentImageContext();
        NSLog(@"改变后图片的宽度为%f,图片的高度为%f",[standardImage size].width,[standardImage size].height);
        
        UIGraphicsEndImageContext();
        CGImageRelease(imageRef);
        
        return standardImage;
    }
    
    //原图长宽有一项大于标准长宽的，对大于标准的那一项进行裁剪，另一项保持不变
    else if(originalsize.height>size.height || originalsize.width>size.width)
    {
        CGImageRef imageRef = nil;
        
        if(originalsize.height>size.height)
        {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(0, originalsize.height/2-size.height/2, originalsize.width, size.height));//获取图片整体部分
        }
        else if (originalsize.width>size.width)
        {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(originalsize.width/2-size.width/2, 0, size.width, originalsize.height));//获取图片整体部分
        }
        
        UIGraphicsBeginImageContext(size);//指定要绘画图片的大小
        CGContextRef con = UIGraphicsGetCurrentContext();
        
        CGContextTranslateCTM(con, 0.0, size.height);
        CGContextScaleCTM(con, 1.0, -1.0);
        
        CGContextDrawImage(con, CGRectMake(0, 0, size.width, size.height), imageRef);
        
        UIImage *standardImage = UIGraphicsGetImageFromCurrentImageContext();
        NSLog(@"改变后图片的宽度为%f,图片的高度为%f",[standardImage size].width,[standardImage size].height);
        
        UIGraphicsEndImageContext();
        CGImageRelease(imageRef);
        
        return standardImage;
    }
    
    //原图为标准长宽的，不做处理
    else
    {
        return originalImage;
    }
}

- (void)saveReviseImage {
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
}
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *message = @"";
    if (!error) {
        message = @"保存图片成功";
    }else
    {
        message = [error description];
    }
    NSLog(@"message is %@",message);
}

- (void)returnCamera {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)createImageViewWithImage:(UIImage *)image {
    UIScrollView *view = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 139)];
    view.contentSize = CGSizeMake(WIDTH, HEIGHT - 139);
    view.showsVerticalScrollIndicator = NO;
    view.showsHorizontalScrollIndicator = NO;
    view.bounces = YES;
    view.alwaysBounceVertical = YES;//用这个方法可以保证随时可以移动
    view.alwaysBounceHorizontal = YES;
    view.minimumZoomScale = 1.0;
    view.maximumZoomScale = 2.0;
    view.delegate = self;
    [self.view addSubview:view];
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.image = image;
    self.imageView.userInteractionEnabled = YES;
    [view addSubview:self.imageView];
    
    //首先判断从相册中选出来的照片的尺寸 (HEIGHT - 139)
    //①如果是正方形照片
    if (image.size.width == image.size.height) {
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(WIDTH, WIDTH * image.size.height / image.size.width));
        }];
        //②如果照片尺寸超过给定高度
    } else if (HEIGHT - 139 < WIDTH * image.size.height / image.size.width) {
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view.mas_centerY);
            make.centerX.equalTo(view.mas_centerX);
            make.size.mas_equalTo(CGSizeMake((HEIGHT - 139) * image.size.width / image.size.height, HEIGHT - 139));
        }];
    } else {
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(WIDTH, WIDTH * image.size.height / image.size.width));
        }];
    }
    
}

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return scrollView.subviews.firstObject;
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
