//
//  LMSDiscoverTableViewCell.m
//  Freedom
//
//  Created by dllo on 16/1/21.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import "LMSDiscoverTableViewCell.h"
#import "LMSDiscoverModel.h"

#define Xlen 70

@implementation LMSDiscoverTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    
    _findImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, Xlen, Xlen)];
    [self.contentView addSubview:_findImageView];
    
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 + Xlen + 10, 10, 200, 30)];
    [self.contentView addSubview:_titleLabel];
    
    
    _briefLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 + Xlen + 10, 10 + _titleLabel.frame.size.height + 10, 200, 20)];
    _briefLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_briefLabel];
}

//发现页面赋值
-(void)findDataInfo:(LMSDiscoverModel *)model{
    self.titleLabel.text = model.name;
    self.briefLabel.text = model.singerName;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
