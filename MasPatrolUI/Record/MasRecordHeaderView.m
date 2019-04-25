//
//  MasRecordHeaderView.m
//  BDDExamplesSwift
//
//  Created by du on 2019/4/24.
//  Copyright © 2019 huoshuguang. All rights reserved.
//

#import "MasRecordHeaderView.h"
#import <Masonry/Masonry.h>
@implementation MasRecordHeaderView
{
    NSString *storeName;
    UIButton *yearButton;
    UILabel *statusLabel;
    void(^ActionHandler)(void);
}
-(instancetype)initWith:(NSString *)title Block:(void (^)(void))showHandler
{
    if (self = [super init]) {
        storeName = title;
        [self ibBodyView];
        ActionHandler = showHandler;
    }
    return self;
}

/**
 PatrolMap2.storyboard:CurShopRecordController
 1. IbErrorView
 2. YearBootomView
 */
-(void)ibBodyView
{
    UIView *bodyView = [UIView new];
    bodyView.backgroundColor = [UIColor grayColor];
    [self addSubview:bodyView];
    [bodyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@40);
        make.left.right.bottom.equalTo(self);
    }];
    //门店信息View
    UIView *headerView = [self headerView];
    [bodyView addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bodyView).offset(8);
        make.left.width.equalTo(bodyView);
        make.height.equalTo(@80);
    }];
    //错误View
    UIView *errorView = [self errorView];
    [bodyView addSubview:errorView];
    [errorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_bottom).offset(8);
        make.bottom.leading.trailing.equalTo(bodyView);
    }];
}

-(UIView *)headerView
{
    UIView *headerView = [UIView new];
    headerView.backgroundColor = [UIColor colorWithRed:117.0/255.0 green:189.0/255.0 blue:61.0/255.0 alpha:1.0];
    //标题
    UILabel *name = [UILabel new];
    name.textColor = [UIColor whiteColor];
    name.font = [UIFont systemFontOfSize:17.0];
    name.text = storeName;
    [headerView addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@50);
        make.top.equalTo(headerView).offset(0);
        make.left.equalTo(@20);
        make.right.equalTo(@10);
    }];
    //巡查情况
    UILabel *status = [UILabel new];
    statusLabel = status;
    status.textColor = [UIColor whiteColor];
    status.font = [UIFont systemFontOfSize:15];
    [headerView addSubview:status];
    [status mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(name);
        make.top.equalTo(name.mas_bottom);
    }];
    //日期
    UIButton *switchYear = [UIButton new];
    yearButton = switchYear;
    switchYear.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    switchYear.imageEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
    [switchYear setImage:[UIImage new] forState:UIControlStateNormal];
    switchYear.titleLabel.font = [UIFont systemFontOfSize:15];
    [switchYear setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [switchYear addTarget:self action:@selector(switchYearAction) forControlEvents:UIControlEventTouchDown];
    [headerView addSubview:switchYear];
    [switchYear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.width.equalTo(@70);
        make.height.equalTo(@20);
        make.centerY.equalTo(status);
    }];
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@.5);
        make.left.equalTo(switchYear).offset(5);
        make.top.equalTo(switchYear.mas_bottom);
        make.width.equalTo(@30);
    }];
    return headerView;
}

-(UIView *)errorView
{
    UIView *errorView = [UIView new];
    errorView.backgroundColor = [UIColor whiteColor];
    //状态图片
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    [errorView addSubview:imgView];
    imgView.backgroundColor = [UIColor redColor];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@150);
        make.centerX.equalTo(errorView);
        make.centerY.equalTo(errorView).offset(-70);
    }];
    //提示语
    UIColor *textcolor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    UILabel *msg = [UILabel new];
    msg.text = @"抱歉，您还没有数据";
    msg.font = [UIFont systemFontOfSize:17.0];
    msg.textColor = textcolor;
    [errorView addSubview:msg];
    [msg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgView.mas_bottom).offset(10);
        make.centerX.equalTo(imgView);
    }];
    //刷新按钮
    UIButton *refresh = [UIButton new];
    [refresh setTitleColor:textcolor forState:UIControlStateNormal];
    refresh.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [refresh setTitle:@"点我刷新" forState:UIControlStateNormal];
    [errorView addSubview:refresh];
    [refresh mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@100);
        make.height.equalTo(@30);
        make.top.equalTo(msg.mas_bottom).offset(10);
        make.centerX.equalTo(errorView);
    }];
    return errorView;
}

#pragma mark 显示日历
-(void)switchYearAction
{
    if (ActionHandler) {
        ActionHandler();
    }
}

#pragma mark API
-(void)reloadYear:(NSString *)year num:(NSString *)num
{
    [yearButton setTitle:year forState:UIControlStateNormal];
    statusLabel.text = [NSString stringWithFormat:@"%@年巡查次数:%@",year,num];;
}


@end
