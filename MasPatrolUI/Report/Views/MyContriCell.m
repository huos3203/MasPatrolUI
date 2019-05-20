//
//  MyContriCell.m
//  MasPatrolUI
//
//  Created by admin on 2019/5/20.
//  Copyright © 2019 com. All rights reserved.
//

#import "MyContriCell.h"
#import <Masonry/Masonry.h>
#import "ReportTaskModel.h"

@implementation MyContriCell
{
    UILabel *statusLabel;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}

-(void)updateConstraints
{
    //更新
    [self.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.taskTypeLabel.mas_right).offset(8);
        make.centerY.equalTo(self.taskTypeLabel);
        make.right.equalTo(@-60);
    }];
    [self.timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addressLabel.mas_bottom).offset(8);
        make.leading.equalTo(self.taskTypeLabel.mas_leading);
        make.trailing.equalTo(@10);
        make.bottom.equalTo(@-8);
    }];
    //移除多余View
    [self.renLabel removeFromSuperview];
    //添加新控件
    UILabel *status = [UILabel new];
    statusLabel = status;
    status.font = [UIFont systemFontOfSize:13.0];
    status.textColor = [UIColor colorWithRed:255/255.0 green:106/255.0 blue:52/255.0 alpha:1.0];
    [self.contentView addSubview:status];
    [status mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nameLabel);
        make.left.equalTo(self.nameLabel.mas_right).offset(8);
    }];
    
    [super updateConstraints];
}

-(void)setModel:(ReportTaskModel *)model
{
    [super setModel:model];
    statusLabel.text = model.QuestionStatus;
}

@end
