//
//  ReportTaskListController.m
//  MasPatrolUI
//
//  Created by admin on 2019/5/20.
//  Copyright © 2019 com. All rights reserved.
//

#import "ReportTaskListController.h"
#import <Masonry/Masonry.h>
#import "MyViewUtils.h"
#import "ReportTaskModel.h"
#import "ReportTaskListCell.h"
#import "ReportOpenAPI.h"
#import "MyContrStackView.h"

@interface ReportTaskListController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray<ReportTaskModel *> *dataArray;
@end

@implementation ReportTaskListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(60);
        make.leading.trailing.equalTo(self.view);
    }];
    //按钮
    UIButton *task = [UIButton new];
    [task setTitle:@"任务管理" forState:UIControlStateNormal];
    [task setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [task addTarget:self action:@selector(toReportManager) forControlEvents:UIControlEventAllTouchEvents];
    [task setBackgroundColor: [UIColor colorWithRed:44/255.0 green:215/255.0 blue:115/255.0 alpha:1.0]];
    [self.view addSubview:task];
    [task mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView.mas_bottom);
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    
    [self customBarButton];
}

-(void)customBarButton
{
    self.title = @"精确治理";
    UIButton *btn = [UIButton new];
    btn.backgroundColor = [UIColor redColor];
    UIButton *contribtn = [UIButton new];
    contribtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [contribtn setTitle:@"我的贡献" forState:UIControlStateNormal];
    [contribtn setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:UIControlStateNormal];
    UIImage *btnimg = [UIImage imageNamed:@"GBCheckUpResource.bundle/whpoint.tiff"];
    [btn setImage:btnimg forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnBackClick) forControlEvents:UIControlEventTouchUpInside];
    [contribtn addTarget:self action:@selector(contriInfo) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [MyViewUtils createBarBy:btn];
    self.navigationItem.rightBarButtonItem = [MyViewUtils createBarBy:contribtn];
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


#pragma mark - UIAction
-(void)btnBackClick
{
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
}
-(void)contriInfo
{
    [ReportOpenAPI open:MyContriInfo from:self];
}
-(void)toReportManager
{
    [ReportOpenAPI open:ReportManager from:self.navigationController];
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
