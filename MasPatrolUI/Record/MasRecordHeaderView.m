//
//  MasRecordHeaderView.m
//  BDDExamplesSwift
//
//  Created by du on 2019/4/24.
//  Copyright © 2019 huoshuguang. All rights reserved.
//

#import "MasRecordHeaderView.h"
#import "MasRecordCell.h"
#import <Masonry/Masonry.h>

@interface MasRecordHeaderView()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) UIView *bodyView;
@property (strong, nonatomic) UIView *errorView;
@end

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
        [self installView];
        ActionHandler = showHandler;
    }
    return self;
}

-(void)installView
{
    //门店信息View
    UIView *headerView = [self headerView];
    [self addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.width.equalTo(self);
        make.height.equalTo(@80);
    }];
    //错误View
    [self addSubview:self.errorView];
    [self.errorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_bottom);
        make.bottom.leading.trailing.equalTo(self);
    }];
    
    //tableView
    [self addSubview:self.tableView];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self->_errorView);
        make.center.equalTo(self->_errorView);
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
    if (!_errorView) {
        _errorView = [UIView new];
        _errorView.backgroundColor = [UIColor whiteColor];
        //状态图片
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        [_errorView addSubview:imgView];
        imgView.backgroundColor = [UIColor redColor];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@150);
            make.centerX.equalTo(self->_errorView);
            make.centerY.equalTo(self->_errorView).offset(-70);
        }];
        //提示语
        UIColor *textcolor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
        UILabel *msg = [UILabel new];
        msg.text = @"抱歉，您还没有数据";
        msg.font = [UIFont systemFontOfSize:17.0];
        msg.textColor = textcolor;
        [_errorView addSubview:msg];
        [msg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imgView.mas_bottom).offset(10);
            make.centerX.equalTo(imgView);
        }];
        //刷新按钮
        UIButton *refresh = [UIButton new];
        [refresh setTitleColor:textcolor forState:UIControlStateNormal];
        refresh.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [refresh setTitle:@"点我刷新" forState:UIControlStateNormal];
        [_errorView addSubview:refresh];
        [refresh mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@100);
            make.height.equalTo(@30);
            make.top.equalTo(msg.mas_bottom).offset(10);
            make.centerX.equalTo(self->_errorView);
        }];
    }
    return _errorView;
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [UITableView new];
        [_tableView registerClass:[MasRecordCell class] forCellReuseIdentifier:@"MasRecordCell"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
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
-(void)reloadData:(NSArray *)data
{
    if (data.count > 0) {
        [self sendSubviewToBack:_errorView];
        _dataArray = data;
        [self.tableView reloadData];
    }else{
        [self bringSubviewToFront:_errorView];
    }
}
#pragma mark tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MasRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MasRecordCell"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
