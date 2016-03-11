//
//  LMS_SearchPageCollectionViewCell.h
//  Freedom
//
//  Created by dllo on 16/1/18.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import "LMSBaseCollectionViewCell.h"

@protocol SearchPageDelegate <NSObject>

- (void)playMV:(NSString *)videoId;

@end

@interface LMS_SearchPageCollectionViewCell : LMSBaseCollectionViewCell

@property (nonatomic, retain) NSMutableDictionary *dic;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, assign) id<SearchPageDelegate> delegate;

@end
