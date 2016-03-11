//
//  LMSRankListTableViewCell.m
//  Freedom
//
//  Created by dllo on 16/1/21.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import "LMSRankListTableViewCell.h"
#import "LMSRankListModel.h"

@implementation LMSRankListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    self.rankListImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100, 100)];
    [self.contentView addSubview:self.rankListImageView];
    
    self.rankListLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 10, 250, 30)];
    [self.contentView addSubview:self.rankListLabel];
    
    self.songLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(120, 50, 250, 20)];
    self.songLabel1.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.songLabel1];
    
    self.songLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(120, 70, 250, 20)];
    self.songLabel2.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.songLabel2];
    
    self.songLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(120, 90, 250, 20)];
    self.songLabel3.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.songLabel3];

}

-(void)rankListInfo:(LMSRankListModel *)model{
    [self.rankListImageView sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    [self.rankListImageView sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    self.rankListLabel.text = model.title;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
