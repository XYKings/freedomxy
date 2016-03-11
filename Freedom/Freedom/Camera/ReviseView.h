//
//  ReviseView.h
//  SYCaremaDemo
//
//  Created by dllo on 16/1/16.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ReviseViewDelegate <NSObject>

- (void)caijianWithButtonTag:(NSInteger)tag;

@end

@interface ReviseView : UIView
@property (nonatomic, assign) id<ReviseViewDelegate> delegate;
@end
