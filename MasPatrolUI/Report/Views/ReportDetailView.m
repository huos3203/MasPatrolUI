//
//  ReportDetailView.m
//  MasPatrolUI
//
//  Created by admin on 2019/5/22.
//  Copyright © 2019 com. All rights reserved.
//

#import "ReportDetailView.h"
#import "MyViewUtils.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
@implementation ReportDetailViewModel
@end
@interface ReportDetailView()
@property (strong, nonatomic) UIStackView *infoView;
@property (strong, nonatomic) UIStackView *detailView;

@end

@implementation ReportDetailView
{
    UILabel *_reportType;
    UIImageView *_preImgView;
    UILabel *_nameLabel;
    UILabel *_statusLabel;
    UILabel *_timeLabel;
    UILabel *_addressLabel;
    UIImageView *_detailImgView;
    UILabel *_detailTextLabel;
    UILabel *_renLabel;
    UILabel *_shixianLabel;
    UIView *_firstView;
    
}
-(instancetype)init
{
    self = [super init];
    [self installView];
    return self;
}

-(void)drawRect:(CGRect)rect
{
    [MyViewUtils maskLayer:_reportType];
    [super drawRect:rect];
}

-(void)reloadData:(ReportDetailViewModel *)model
{
    _reportType.text = model.type;
    _nameLabel.text = model.name;
    _statusLabel.text = model.status;
    _timeLabel.text = [NSString stringWithFormat:@"上报时间：%@",model.time];
    _addressLabel.text = model.address;
    _detailTextLabel.text = model.detailText;
    _renLabel.text = model.ren;
    _shixianLabel.text = model.shixian;
    
    if ([model.preImgUrl hasPrefix:@"http"]) {
        [_preImgView sd_setImageWithURL:[NSURL URLWithString:model.preImgUrl]];
    }else{
        _preImgView.hidden = YES;
    }
    if ([model.detailImgUrl hasPrefix:@"http"]) {
        [_detailImgView sd_setImageWithURL:[NSURL URLWithString:model.detailImgUrl]];
    }else{
        _detailImgView.hidden = YES;
    }
    
    if (![model.detailImgUrl hasPrefix:@"http"] && model.detailText.length == 0) {
        _firstView.hidden = YES;
    }
}

-(void)installView
{
    //上报信息
    [self addSubview:self.infoView];
    __weak typeof(self) weakSelf = self;
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@8);
        make.height.equalTo(@100);
        make.top.right.equalTo(weakSelf);
    }];
    UIView *line1 = [UIView new];
    line1.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    [weakSelf addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@8);
        make.left.right.equalTo(weakSelf);
        make.top.equalTo(weakSelf.infoView.mas_bottom).offset(8);
    }];
    
    [self addSubview:self.detailView];
    [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom).offset(8);
        make.left.equalTo(@8);
        make.right.equalTo(@-8);
    }];
    UIView *line2 = [UIView new];
    line2.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    [self addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@8);
        make.left.right.equalTo(weakSelf);
        make.top.equalTo(self.detailView.mas_bottom);
    }];
}

-(UIStackView *)infoView
{
    if (!_infoView) {
        _infoView = [UIStackView new];
        _infoView.axis = UILayoutConstraintAxisHorizontal;
        _infoView.distribution = UIStackViewDistributionFillProportionally;
        _infoView.spacing = 10;
        UIImageView *imgView = [UIImageView new];
        imgView.backgroundColor = [UIColor redColor];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@72);
            make.width.equalTo(@95);
        }];
        [_infoView addArrangedSubview:imgView];
        //
        UIView *view = [UIView new];
        [_infoView addArrangedSubview:view];
        UILabel *type = [UILabel new];
        _reportType = type;
        type.backgroundColor = [UIColor colorWithRed:51/255.0 green:146/255.0 blue:254/255.0 alpha:1.0];
        type.textColor = [UIColor whiteColor];
        type.font = [UIFont systemFontOfSize:11.0];
        type.textAlignment = NSTextAlignmentCenter;
        UILabel *name = [UILabel new];
        name.font = [UIFont boldSystemFontOfSize:16.0];
        name.textColor = [UIColor colorWithRed:47/255.0 green:56/255.0 blue:86/255.0 alpha:1.0];
        UILabel *status = [UILabel new];
        status.textAlignment = NSTextAlignmentRight;
        status.font = [UIFont systemFontOfSize:13.0];
        status.textColor = [UIColor colorWithRed:255/255.0 green:106/255.0 blue:52/255.0 alpha:1.0];
        UILabel *time = [UILabel new];
        time.font = [UIFont systemFontOfSize:12.0];
        time.textColor = [UIColor colorWithRed:153/255.0 green:160/255.0 blue:182/255.0 alpha:1.0];
        UIImageView *icon = [UIImageView new];
        UILabel *address = [UILabel new];
        address.font = [UIFont systemFontOfSize:12.0];
        address.numberOfLines = 0;
        address.textColor = [UIColor colorWithRed:94/255.0 green:99/255.0 blue:123/255.0 alpha:1.0];
        [view addSubview:type];
        [view addSubview:name];
        [view addSubview:status];
        [view addSubview:time];
        [view addSubview:icon];
        [view addSubview:address];
        
        _preImgView = imgView;
        _nameLabel = name;
        _statusLabel = status;
        _timeLabel = time;
        _addressLabel = address;
        
        [type mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(@0);
            make.height.equalTo(@25);
            make.width.equalTo(@80);
        }];
        
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(type);
            make.left.equalTo(type.mas_right).offset(8);
        }];
        
        [status mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(type);
            make.width.equalTo(@40);
            make.left.equalTo(name.mas_right).offset(8);
            make.right.equalTo(view).offset(-8);
        }];
        [time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(type.mas_bottom).offset(8);
            make.height.equalTo(@25);
            make.leading.equalTo(type.mas_leading);
            make.trailing.equalTo(name.mas_trailing);
        }];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(type.mas_leading);
            make.height.width.equalTo(@12);
        }];
        [address mas_makeConstraints:^(MASConstraintMaker *make) {
             make.top.equalTo(time.mas_bottom);
            make.top.equalTo(icon.mas_top);
            make.left.equalTo(icon.mas_right).offset(8);
            make.trailing.equalTo(name.mas_trailing);
        }];
    }
    return _infoView;
}

-(UIStackView *)detailView
{
    if (!_detailView) {
        _detailView = [UIStackView new];
        _detailView.axis = UILayoutConstraintAxisVertical;
        _detailView.distribution = UIStackViewDistributionFill;
        UIView *firstView = [self detailFirstView];
        _firstView = firstView;
        [_detailView addArrangedSubview:firstView];
        UIView *secondView = [self detailSecondView];
        [_detailView addArrangedSubview:secondView];
    }
    return _detailView;
}

-(UIView *)detailSecondView
{
    UIView *view = [UIView new];
    UIView *cell1 = [UIView new];
    UIView *cell2 = [UIView new];
    _renLabel = [self secondCell:@"负责人" for:cell1];
    _shixianLabel = [self secondCell:@"任务时限" for:cell2];
    UIView *line = [UIView new];
    line.backgroundColor =[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    [view addSubview:cell1];
    [view addSubview:cell2];
    [view addSubview:line];
    [cell1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).offset(10);
        make.left.right.equalTo(view);
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.left.equalTo(view).offset(-8);
        make.right.equalTo(view).offset(8);
        make.top.equalTo(cell1.mas_bottom).offset(8);
    }];
    
    [cell2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(view);
        make.top.equalTo(line.mas_bottom).offset(8);
        make.bottom.equalTo(view).offset(-10);
    }];
    return view;
}

-(UILabel *)secondCell:(NSString *)name for:(UIView *)view
{
    UILabel *label = [UILabel new];
    label.textColor = [UIColor colorWithRed:47/255.0 green:56/255.0 blue:86/255.0 alpha:1.0];
    label.font = [UIFont boldSystemFontOfSize:16.0];
    label.text = name;
    UILabel *text = [UILabel new];
    text.numberOfLines = 0;
    text.textColor = [UIColor colorWithRed:47/255.0 green:56/255.0 blue:86/255.0 alpha:1.0];
    text.font = [UIFont systemFontOfSize:16.0];
    [view addSubview:label];
    [view addSubview:text];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@8);
        make.top.equalTo(text.mas_top);
    }];
    [text setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).offset(8);
        make.right.equalTo(view);
        make.centerY.equalTo(view);
        make.left.equalTo(label.mas_right).offset(8);
    }];
    
    return text;
}

-(UIView *)detailFirstView
{
    UIView *view = [UIView new];
    //描述信息
    UILabel *detailLabel = [UILabel new];
    detailLabel.textColor = [UIColor colorWithRed:47/255.0 green:56/255.0 blue:86/255.0 alpha:1.0];
    detailLabel.font = [UIFont boldSystemFontOfSize:16.0];
    detailLabel.text = @"详情描述";
    
    UIStackView *stackView = [UIStackView new];
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.distribution = UIStackViewDistributionFill;
    stackView.alignment = UIStackViewAlignmentTop;
    stackView.spacing = 8;
    UIImageView *imgView = [UIImageView new];
    imgView.backgroundColor = [UIColor redColor];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@72);
    }];
    [stackView addArrangedSubview:imgView];
    //
    UILabel *detail = [UILabel new];
    detail.numberOfLines = 0;
    detail.textColor = [UIColor colorWithRed:47/255.0 green:56/255.0 blue:86/255.0 alpha:1.0];
    detail.font = [UIFont systemFontOfSize:14];
    [stackView addArrangedSubview:detail];
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    
    [view addSubview:detailLabel];
    [view addSubview:stackView];
    [view addSubview:line];
    
    _detailImgView = imgView;
    _detailTextLabel = detail;
    
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@-8);
        make.top.equalTo(view).offset(8);
    }];
    [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(view);
        make.top.equalTo(detailLabel.mas_bottom).offset(8);
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.bottom.equalTo(view);
        make.left.equalTo(view).offset(-8);
        make.right.equalTo(view).offset(8);
        make.top.equalTo(stackView.mas_bottom).offset(8);
    }];
    
    return view;
}

@end
