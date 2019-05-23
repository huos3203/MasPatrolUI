//
//  ReportTaskListCell.m
//  MasPatrolUI
//
//  Created by admin on 2019/5/20.
//  Copyright © 2019 com. All rights reserved.
//

#import "ReportTaskListCell.h"
#import <Masonry/Masonry.h>
#import "ReportTaskModel.h"
#import "MyViewUtils.h"
@implementation ReportTaskListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self installView];
    return self;
}
-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [MyViewUtils maskLayer:_taskTypeLabel];
}
-(void)installView
{
    //title
    UILabel *taskType = [UILabel new];
    _taskTypeLabel = taskType;
    taskType.backgroundColor = [UIColor colorWithRed:51/255.0 green:146/255.0 blue:254/255.0 alpha:1.0];
    taskType.textColor = [UIColor whiteColor];
    taskType.font = [UIFont systemFontOfSize:11.0];
    taskType.textAlignment = NSTextAlignmentCenter;
    UILabel *name = [UILabel new];
    _nameLabel = name;
    name.font = [UIFont boldSystemFontOfSize:16.0];
    name.textColor = [UIColor colorWithRed:47/255.0 green:56/255.0 blue:86/255.0 alpha:1.0];
    UILabel *address = [UILabel new];
    _addressLabel = address;
    address.font = [UIFont systemFontOfSize:14.0];
    address.textColor = [UIColor colorWithRed:94/255.0 green:99/255.0 blue:123/255.0 alpha:1.0];
    UILabel *ren = [UILabel new];
    _renLabel = ren;
    ren.font = [UIFont systemFontOfSize:14.0];
    ren.textColor = [UIColor colorWithRed:94/255.0 green:99/255.0 blue:123/255.0 alpha:1.0];
    UILabel *time = [UILabel new];
    _timeLabel = time;
    time.font = [UIFont systemFontOfSize:14.0];
    time.textColor = [UIColor colorWithRed:94/255.0 green:99/255.0 blue:123/255.0 alpha:1.0];
    [self.contentView addSubview:taskType];
    [self.contentView addSubview:name];
    [self.contentView addSubview:address];
    [self.contentView addSubview:ren];
    [self.contentView addSubview:time];
    [taskType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.height.equalTo(@18);
        make.top.equalTo(@8);
        make.width.equalTo(@60);
    }];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(taskType.mas_right).offset(8);
        make.centerY.equalTo(taskType);
        make.right.equalTo(@10);
    }];
    [address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(taskType.mas_bottom).offset(8);
        make.leading.equalTo(taskType.mas_leading);
        make.trailing.equalTo(name.mas_trailing);
    }];
    [ren mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(address.mas_bottom).offset(8);
        make.leading.equalTo(taskType.mas_leading);
        make.trailing.equalTo(name.mas_trailing);
    }];
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ren.mas_bottom).offset(8);
        make.leading.equalTo(taskType.mas_leading);
        make.trailing.equalTo(name.mas_trailing);
        make.bottom.equalTo(@-8);
    }];
    
}

-(void)setModel:(ReportTaskModel *)model
{
    _model = model;
    _taskTypeLabel.text = model.ClassifName;
    _nameLabel.text = model.EventName;
    _addressLabel.attributedText = [MyViewUtils installAtrribute:@"地址：" second:model.QuestionFixedLocation];
    _renLabel.attributedText = [MyViewUtils installAtrribute:@"负责人：" second:model.QuestionReporterName];
    _timeLabel.attributedText = [MyViewUtils installAtrribute:@"截止时间：" second:model.QuestionOffDate];
}
@end
