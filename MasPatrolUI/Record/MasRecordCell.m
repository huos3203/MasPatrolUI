//
//  MasRecordCell.m
//  MasPatrolUI
//
//  Created by du on 2019/4/27.
//  Copyright © 2019 com. All rights reserved.
//

#import "MasRecordCell.h"
#import <Masonry/Masonry.h>

@interface MasRecordCell()
@property (strong, nonatomic) UIView *statusView;
@property (strong, nonatomic) UIView *bodyView;
@end

@implementation MasRecordCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self.contentView addSubview:self.statusView];
    [self.statusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.width.equalTo(@20);
        make.top.bottom.equalTo(self.contentView);
    }];
    UIView *body = [self bodyView];
    [self.contentView addSubview:body];
    [body mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.statusView.mas_right);
        make.top.right.bottom.equalTo(self.contentView);
    }];
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

//状态View
-(UIView *)statusView
{
    if (!_statusView) {
        _statusView = [UIView new];
        //状态
        UIImageView *imgView = [UIImageView new];
        imgView.backgroundColor = [UIColor redColor];
        [_statusView addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.equalTo(@20);
            make.center.equalTo(self->_statusView);
        }];
        //竖线1
        UIView *top = [UIView new];
        top.backgroundColor = [UIColor grayColor];
        [_statusView addSubview:top];
        [top mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@1);
            make.height.equalTo(@20);
            make.centerX.equalTo(imgView);
            make.top.equalTo(self->_statusView);
            make.bottom.equalTo(imgView.mas_top);
        }];
        //竖线2
        UIView *bottom = [UIView new];
        bottom.backgroundColor = [UIColor grayColor];
        [_statusView addSubview:bottom];
        [bottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(top);
            make.centerX.equalTo(imgView);
            make.top.equalTo(imgView.mas_bottom);
            make.bottom.equalTo(self->_statusView);
        }];
    }
    return _statusView;
}

-(UIView *)bodyView
{
    if (!_bodyView) {
        _bodyView = [UIView new];
        _bodyView.backgroundColor = [UIColor yellowColor];
        //icon
        UIImageView *imgView = [UIImageView new];
        imgView.backgroundColor = [UIColor redColor];
        [_bodyView addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.equalTo(@15);
            make.left.equalTo(@8);
            make.top.equalTo(self->_bodyView).offset(10);
        }];
        //title
        UILabel *title = [UILabel new];
        title.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        title.backgroundColor = [UIColor greenColor];
        title.font = [UIFont systemFontOfSize:15];
        [_bodyView addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imgView.mas_right).offset(5);
            make.height.equalTo(@20);
            make.centerY.equalTo(imgView);
            make.right.equalTo(self->_bodyView).offset(-10);
        }];
        //address
        UILabel *address = [UILabel new];
        address.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        address.font = [UIFont systemFontOfSize:13];
        [_bodyView addSubview:address];
        address.backgroundColor = [UIColor darkTextColor];
        [address mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@8);
            make.top.equalTo(title.mas_bottom).offset(5);
            make.bottom.equalTo(self->_bodyView).offset(-5);
            make.right.equalTo(self->_bodyView).offset(-10);
        }];
    }
    return _bodyView;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
