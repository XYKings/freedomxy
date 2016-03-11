//
//  FilterGroup.m
//  SYCaremaDemo
//
//  Created by dllo on 16/1/14.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "FilterGroup.h"
#import <objc/runtime.h>

static char GPUImageFilterGroupTitleKey;
static char GPUImageFilterGroupColorKey;

@implementation GPUImageFilterGroup(addTitleColor)

- (void)setTitle:(NSString *)title {
    [self willChangeValueForKey:@"GPUImageFilterGroupTitleKey"];
    objc_setAssociatedObject(self, &GPUImageFilterGroupTitleKey, title, OBJC_ASSOCIATION_COPY);
}

- (NSString *)title {
    return objc_getAssociatedObject(self, &GPUImageFilterGroupTitleKey);
}

- (void)setColor:(UIColor *)color {
    [self willChangeValueForKey:@"GPUImageFilterGroupColorKey"];
    objc_setAssociatedObject(self, &GPUImageFilterGroupColorKey, color, OBJC_ASSOCIATION_RETAIN);
    [self didChangeValueForKey:@"GPUImageFilterGroupColorKey"];
}

- (UIColor *)color {
    return objc_getAssociatedObject(self, &GPUImageFilterGroupColorKey);
}
@end
