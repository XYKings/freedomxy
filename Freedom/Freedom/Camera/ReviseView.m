//
//  ReviseView.m
//  SYCaremaDemo
//
//  Created by dllo on 16/1/16.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ReviseView.h"
#import "ReviseCollectionViewCell.h"
#import "ReviseVIewCell.h"
#import <QuartzCore/QuartzCore.h>

@interface ReviseView()
@property (nonatomic, strong) UIView *meihuaView;
@end

@implementation ReviseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubView];
    }
    return self;
}

- (void)createSubView {
    [self createFooterButton];
    [self createCai];
}

- (void)createFooterButton {
    UIButton *beauty = [UIButton buttonWithType:UIButtonTypeCustom];
    beauty.backgroundColor = [UIColor whiteColor];
    beauty.frame = CGRectMake(0, self.frame.size.height - 20, WIDTH / 2.0, 20);
    [beauty addTarget:self action:@selector(beautyAction) forControlEvents:UIControlEventTouchUpInside];
    [beauty setTitle:@"美化" forState:UIControlStateNormal];
    [beauty setTitleColor:COLORSTYLE forState:UIControlStateNormal];
    beauty.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [self addSubview:beauty];
    
    UIButton *face = [UIButton buttonWithType:UIButtonTypeCustom];
    face.backgroundColor = [UIColor whiteColor];
    face.frame = CGRectMake(WIDTH / 2.0, self.frame.size.height - 20, WIDTH / 2.0, 20);
    [face setTitle:@"美颜" forState:UIControlStateNormal];
    [face setTitleColor:COLORSTYLE forState:UIControlStateNormal];
    face.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [face addTarget:self action:@selector(faceAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:face];

}
- (void)beautyAction {
    self.meihuaView.hidden = NO;
}
- (void)faceAction {
    self.meihuaView.hidden = YES;
}

- (void)createCai {
    self.meihuaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, self.frame.size.height - 20)];
    [self addSubview:self.meihuaView];
    ReviseVIewCell *cell = [[ReviseVIewCell alloc] initWithFrame:CGRectMake(0, 0, WIDTH / 6, self.frame.size.height - 20)];
    [cell.button setImage:[UIImage imageNamed:@"剪裁"] forState:UIControlStateNormal];
    [cell.button addTarget:self action:@selector(caijianAction) forControlEvents:UIControlEventTouchUpInside];
    cell.label.text = @"剪裁";
    [self.meihuaView addSubview:cell];
}

- (void)caijianAction {
    self.meihuaView.hidden = YES;
    
    UIView *caijianView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, self.frame.size.height)];
    caijianView.backgroundColor = [UIColor lightGrayColor];
    CATransition *trans = [CATransition animation];
    trans.type = kCATransitionPush;
    trans.subtype = kCATransitionFromTop;
    trans.duration = 0.5f;
    [caijianView.layer addAnimation:trans forKey:@"caijian"];
    [self addSubview:caijianView];
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setImage:[UIImage imageNamed:@"退出裁剪"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    back.frame = CGRectMake(0, 0, WIDTH / 7.0, self.frame.size.height);
    [caijianView addSubview:back];
    
    NSArray *array = @[@"1:1", @"4:3", @"16:9", @"任意"];
    for (NSInteger i = 0; i < 4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * WIDTH / 6.0 + WIDTH / 7.0, 0, WIDTH / 6.0, self.frame.size.height);
        [button setTitle: array[i] forState:UIControlStateNormal];
        [button setTitleColor:COLORSTYLE forState:UIControlStateNormal];
        button.tag = 100 + i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [caijianView addSubview:button];
    }
    
    UIButton *rightSave = [UIButton buttonWithType:UIButtonTypeCustom];
    rightSave.frame = CGRectMake(WIDTH - WIDTH / 7.0, 0, WIDTH / 7.0, self.frame.size.height);
    [rightSave setImage:[UIImage imageNamed:@"对号"] forState:UIControlStateNormal];
    [rightSave addTarget:self action:@selector(rightSave:) forControlEvents:UIControlEventTouchUpInside];
    [caijianView addSubview:rightSave];
}

- (void)buttonAction:(UIButton *)sender {
    switch (sender.tag) {
            //1:1
        case 100:
            NSLog(@"1:1");
            [self.delegate caijianWithButtonTag:100];
            
            break;
            //4:3
        case 101:
            NSLog(@"4:3");
            [self.delegate caijianWithButtonTag:101];
            break;
            //16:9
        case 102:
            NSLog(@"16:9");
            [self.delegate caijianWithButtonTag:102];
            break;
            //任意
        case 103:
            NSLog(@"任意");
            [self.delegate caijianWithButtonTag:103];
            break;
        default:
            break;
    }
}
    
- (void)rightSave:(UIButton *)sender {
    self.meihuaView.hidden = NO;
    [[sender superview] removeFromSuperview];
}

- (void)backAction:(UIButton *)sender {
    self.meihuaView.hidden = NO;
    [[sender superview] removeFromSuperview];
}

@end
