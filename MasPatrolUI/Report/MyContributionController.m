//
//  MyContributionController.m
//  MasPatrolUI
//
//  Created by admin on 2019/5/20.
//  Copyright © 2019 com. All rights reserved.
//

#import "MyContributionController.h"
#import "MyContriCell.h"
#import "MyContriModel.h"
#import "ReportTaskModel.h"
#import "MyContrStackView.h"
#import <Masonry/Masonry.h>
@interface MyContributionController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) MyContriModel *myContriModel;
@end

@implementation MyContributionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    MyContrStackView *stack = [MyContrStackView new];
    [self.view addSubview:stack];
    [stack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@100);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.top.equalTo(@60);
    }];
    [stack reloadData:@"19" second:@"23" third:@"5"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(stack.mas_bottom).offset(8);
        make.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}


#pragma mark - TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myContriModel.Questions.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyContriCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyContriCell"];
    cell.model = self.myContriModel.Questions[indexPath.row];
    return cell;
}

#pragma mark - getter
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[MyContriCell class] forCellReuseIdentifier:@"MyContriCell"];
        //设置分割线颜色
        [_tableView setSeparatorColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0]];
        //隐藏多余的分割线
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        [_tableView setTableFooterView:view];
        _tableView.estimatedRowHeight = 100.f;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}
-(MyContriModel *)myContriModel
{
    if (!_myContriModel) {
        _myContriModel = [MyContriModel new];
        _myContriModel.AdoptNumber = @10;
        _myContriModel.ReportNumber = @120;
        _myContriModel.WaitingNumber = @90;
        for (int i = 1; i < 5; i++) {
            ReportTaskModel *model = [ReportTaskModel new];
            model.ClassifName = @"交通拥堵";
            model.EventName = @"南北方向施工";
            model.QuestionFixedLocation= @"北京市海淀区上地街道上地东路1-5号";
            model.QuestionReporterName = @"李木子";
            model.QuestionOffDate = @"2019-08-09";
            model.QuestionStatus = @"待认领";
            [_myContriModel.Questions addObject:model];
        }
    }
    return _myContriModel;
}

@end
