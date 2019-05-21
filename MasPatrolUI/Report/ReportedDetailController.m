//
//  ReportedDetailController.m
//  MasPatrolUI
//
//  Created by admin on 2019/5/21.
//  Copyright © 2019 com. All rights reserved.
//

#import "ReportedDetailController.h"
#import <Masonry/Masonry.h>
#import "MyViewUtils.h"

@interface ReportedDetailController ()
@property (strong, nonatomic) UIStackView *infoView;
@property (strong, nonatomic) UIStackView *detailView;
@end

@implementation ReportedDetailController
{
    UILabel *reportType;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self customBarButton];
    [self installView];
}
-(void)viewDidAppear:(BOOL)animated
{
    [MyViewUtils maskLayer:reportType];
}
#pragma mark - View
#pragma mark bar
-(void)customBarButton
{
    self.title = @"上报详情";
    UIButton *btn = [UIButton new];
    btn.backgroundColor = [UIColor redColor];
    UIImage *btnimg = [UIImage imageNamed:@"GBCheckUpResource.bundle/whpoint.tiff"];
    [btn setImage:btnimg forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnBackClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [MyViewUtils createBarBy:btn];
}
#pragma mark body
-(void)installView
{
    //上报信息
    [self.view addSubview:self.infoView];
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@8);
        make.right.equalTo(self.view).offset(-8);
        make.top.equalTo(self.view).offset(100);
        make.height.equalTo(@100);
    }];
    UIView *line1 = [UIView new];
    line1.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@8);
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.infoView.mas_bottom).offset(8);
    }];
    
    [self.view addSubview:self.detailView];
    [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom).offset(88);
        make.left.equalTo(@8);
        make.right.equalTo(@-8);
    }];
    UIView *line2 = [UIView new];
    line2.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@8);
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.detailView.mas_bottom);
    }];
    
    
}

-(UIStackView *)infoView
{
    if (!_infoView) {
        _infoView = [UIStackView new];
        _infoView.axis = UILayoutConstraintAxisHorizontal;
        _infoView.distribution = UIStackViewDistributionFillProportionally;
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
        reportType = type;
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
        
        name.text = @"name";
        type.text = @"type";
        time.text = @"time";
        status.text = @"status";
        icon.backgroundColor = [UIColor redColor];
        address.text = @"北京市海淀区上地街道上地东路上地街道上地东路";
        [type mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@8);
            make.top.equalTo(@8);
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
            make.top.equalTo(time.mas_bottom).offset(8);
            make.leading.equalTo(type.mas_leading);
            make.height.width.equalTo(@12);
        }];
        [address mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(icon.mas_top);
            make.left.equalTo(icon.mas_right).offset(8);
            make.height.equalTo(@30);
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
        [_detailView addArrangedSubview:firstView];
        UIView *secondView = [self detailSecondView];
        [_detailView addArrangedSubview:secondView];
    }
    return _detailView;
}

-(UIView *)detailSecondView
{
    UIView *view = [UIView new];
    UIView *cell1 = [self secondCell:@"负责人"];
    UIView *cell2 = [self secondCell:@"任务时限"];
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    [view addSubview:cell1];
    [view addSubview:cell2];
    [view addSubview:line];
    [cell1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).offset(10);
        make.left.right.equalTo(view);
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.left.right.equalTo(view);
        make.top.equalTo(cell1.mas_bottom).offset(10);
    }];
    
    [cell2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(view);
        make.top.equalTo(line.mas_bottom).offset(10);
        make.bottom.equalTo(view).offset(-10);
    }];
    return view;
}

-(UIView *)secondCell:(NSString *)name
{
    UILabel *label = [UILabel new];
    label.textColor = [UIColor colorWithRed:47/255.0 green:56/255.0 blue:86/255.0 alpha:1.0];
    label.font = [UIFont boldSystemFontOfSize:16.0];
    label.text = name;
    UILabel *text = [UILabel new];
    text.numberOfLines = 0;
    text.textColor = [UIColor colorWithRed:47/255.0 green:56/255.0 blue:86/255.0 alpha:1.0];
    text.font = [UIFont systemFontOfSize:16.0];
    text.text = @"道路部门道路部门";
    UIView *view = [UIView new];
    [view addSubview:label];
    [view addSubview:text];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@8);
    }];
    [text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label.mas_right).offset(8);
        make.right.equalTo(view).offset(8);
        make.top.equalTo(label.mas_top);
        make.bottom.equalTo(view.mas_bottom);
    }];
    
    return view;
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
    detail.text = @"描述文字描述文字描述文字描述文字描述文字描述文字描述文字描述文字";
    detail.textColor = [UIColor colorWithRed:47/255.0 green:56/255.0 blue:86/255.0 alpha:1.0];
    detail.font = [UIFont systemFontOfSize:14];
    [stackView addArrangedSubview:detail];
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    
    [view addSubview:detailLabel];
    [view addSubview:stackView];
    [view addSubview:line];
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@8);
        make.right.equalTo(@-8);
        make.top.equalTo(view.mas_bottom).offset(8);
    }];
    [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@8);
        make.right.equalTo(@-8);
        make.top.equalTo(detailLabel.mas_bottom).offset(8);
        make.bottom.equalTo(view);
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.bottom.left.right.equalTo(view);
        make.top.equalTo(stackView.mas_bottom).offset(8);
    }];
    
    return view;
}


-(void)btnBackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
