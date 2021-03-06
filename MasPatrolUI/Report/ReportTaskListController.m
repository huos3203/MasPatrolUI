//
//  ReportTaskListController.m
//  MasPatrolUI
//
//  Created by admin on 2019/5/20.
//  Copyright © 2019 com. All rights reserved.
//

#import "ReportTaskListController.h"
#import "ReportTaskListCell.h"
#import "ReportedDetailController.h"
#import "ReportInvalidDetailController.h"
#import "ReportedDoingController.h"
@interface ReportTaskListController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ReportTaskListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.view);
        make.center.equalTo(self.view);
    }];
    
    [self customBarButton];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MyViewUtils clearNavBarLine:self.navigationController.navigationBar];
}
-(void)customBarButton
{
    UIButton *btn = [UIButton new];
    UIImage *btnimg = [UIImage imageNamed:@"repback"];
    [btn setImage:btnimg forState:UIControlStateNormal];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btn addTarget:self action:@selector(btnBackClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [MyViewUtils createBarBy:btn];
}

#pragma mark - TableView
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
    ReportTaskListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReportTaskListCell"];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *taskVC;
    _flag = Task_Doing;
    switch (_flag) {
        case Task_TODO:
        {
            ReportedDoingController *doing = [ReportedDoingController new];
            doing.flag = Task_TODO;
            taskVC = doing;
            break;
        }
        case Task_Doing:
        {
            ReportedDoingController *doing = [ReportedDoingController new];
            doing.flag = Task_Doing;
            taskVC = doing;
            break;
        }
        case Task_Done:
        {
            ReportedDetailController *detail = [ReportedDetailController new];
            taskVC = detail;
            break;
        }
        case Task_TimeOut:
        {
            ReportedDetailController *detail = [ReportedDetailController new];
            taskVC = detail;
            break;
        }
        case Task_Invalid:
        {
            ReportInvalidDetailController *invalid = [ReportInvalidDetailController new];
            taskVC = invalid;
            break;
        }
        default:
            break;
    }
    [self.navigationController pushViewController:taskVC animated:NO];
}

#pragma mark - UIAction
-(void)btnBackClick
{
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
}


#pragma mark - getter
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[ReportTaskListCell class] forCellReuseIdentifier:@"ReportTaskListCell"];
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

-(NSArray *)dataArray{
    if (!_dataArray) {
        NSMutableArray *array = [NSMutableArray new];
        for (int i = 1; i < 5; i++) {
            ReportTaskModel *model = [ReportTaskModel new];
            model.ClassifName = @"交通拥堵";
            model.EventName = @"南北方向施工";
            model.QuestionFixedLocation= @"北京市海淀区上地街道上地东路1-5号";
            model.QuestionReporterName = @"李木子";
            model.QuestionOffDate = @"2019-08-09";
            [array addObject:model];
        }
        _dataArray = [array copy];
    }
    return _dataArray;
}
@end
