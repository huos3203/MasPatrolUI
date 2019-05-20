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

@implementation ReportTaskListCell
{
    UILabel *taskTypeLabel;
    UILabel *nameLabel;
    UILabel *addressLabel;
    UILabel *renLabel;
    UILabel *timeLabel;
}
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
    [self maskLayer:taskTypeLabel];
}
-(void)installView
{
    //title
    UILabel *taskType = [UILabel new];
    taskTypeLabel = taskType;
    taskType.backgroundColor = [UIColor colorWithRed:51/255.0 green:146/255.0 blue:254/255.0 alpha:1.0];
    taskType.textColor = [UIColor whiteColor];
    taskType.font = [UIFont systemFontOfSize:11.0];
    taskType.textAlignment = NSTextAlignmentCenter;
    UILabel *name = [UILabel new];
    nameLabel = name;
    name.font = [UIFont boldSystemFontOfSize:16.0];
    name.textColor = [UIColor colorWithRed:47/255.0 green:56/255.0 blue:86/255.0 alpha:1.0];
    UILabel *address = [UILabel new];
    addressLabel = address;
    address.font = [UIFont systemFontOfSize:14.0];
    address.textColor = [UIColor colorWithRed:94/255.0 green:99/255.0 blue:123/255.0 alpha:1.0];
    UILabel *ren = [UILabel new];
    renLabel = ren;
    ren.font = [UIFont systemFontOfSize:14.0];
    ren.textColor = [UIColor colorWithRed:94/255.0 green:99/255.0 blue:123/255.0 alpha:1.0];
    UILabel *time = [UILabel new];
    timeLabel = time;
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
    taskTypeLabel.text = model.ClassifName;
    nameLabel.text = model.EventName;
    addressLabel.attributedText = [self installAtrribute:@"地址：" second:model.QuestionFixedLocation];
    renLabel.attributedText = [self installAtrribute:@"负责人：" second:model.QuestionReporterName];
    timeLabel.attributedText = [self installAtrribute:@"截止时间：" second:model.QuestionOffDate];
}

#pragma mark - 辅助方法

-(NSMutableAttributedString *)installAtrribute:(NSString *)first second:(NSString *)second
{
    NSString *text = [NSString stringWithFormat:@"%@%@",first,second];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Medium" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:94/255.0 green:99/255.0 blue:123/255.0 alpha:1.0]}];
    
    [string addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:47/255.0 green:56/255.0 blue:86/255.0 alpha:1.0]} range:NSMakeRange(first.length, second.length)];
    return string;
}

//设置圆角
-(void)maskLayer:(UIView *)view
{
    //设置所需的圆角位置以及大小
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}
@end
