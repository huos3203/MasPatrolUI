//
//  ReportManagerController.m
//  MasPatrolUI
//
//  Created by admin on 2019/5/20.
//  Copyright © 2019 com. All rights reserved.
//

#import "ReportManagerController.h"
#import <Masonry/Masonry.h>
#import "ReportTaskListController.h"
#import "MyContributionController.h"
#import "MyViewUtils.h"

#pragma mark - cellView
@interface ReportTCell : UITableViewCell
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *numberLabel;
@end

@implementation ReportTCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self installView];
    return self;
}
//cell
-(void)installView
{
    //title
    UILabel *title = [UILabel new];
    title.textColor = [UIColor colorWithRed:47/255.0 green:56/255.0 blue:86/255.0 alpha:1.0];
    title.font = [UIFont systemFontOfSize:14.0];
    self.titleLabel = title;
    UILabel *number = [UILabel new];
    number.textColor = [UIColor colorWithRed:153/255.0 green:160/255.0 blue:182/255.0 alpha:1.0];
    number.font = [UIFont systemFontOfSize:14.0];
    self.numberLabel = number;
    UIImageView *imgView = [UIImageView new];
    imgView.image = [UIImage new];
    imgView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:title];
    [self.contentView addSubview:number];
    [self.contentView addSubview:imgView];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.centerY.equalTo(self.contentView);
    }];
    [number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(imgView.mas_left).offset(-10);
        make.centerY.equalTo(title.mas_centerY);
    }];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-20);
        make.height.width.equalTo(@20);
        make.centerY.equalTo(title.mas_centerY);
    }];
}
@end

#pragma mark - model
#pragma mark cellmodel
@interface ReportTModel : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *number;
@property (strong, nonatomic) NSString *sction;
@end
@implementation ReportTModel
@end

#pragma mark secionModel
@interface ReportSectionModel : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSMutableArray<ReportTModel *> *reports;
@end
@implementation ReportSectionModel
-(NSMutableArray<ReportTModel *> *)reports
{
    if (!_reports) {
        _reports = [NSMutableArray new];
    }
    return _reports;
}
@end





@interface ReportManagerController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray<ReportSectionModel *>  *dataArray;
@end

@implementation ReportManagerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.equalTo(self.view);
    }];
    self.title = @"上报管理";
    UIButton *btn = [UIButton new];
    UIImage *btnimg = [UIImage imageNamed:@"repback"];
    [btn setImage:btnimg forState:UIControlStateNormal];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btn addTarget:self action:@selector(backBarAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [MyViewUtils createBarBy:btn];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MyViewUtils clearNavBarLine:self.navigationController.navigationBar];
}
#pragma mark - UIAction
-(void)backBarAction
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray[section].reports.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReportTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReportTCell"];
    ReportTModel *model = self.dataArray[indexPath.section].reports[indexPath.row];
    cell.titleLabel.text = model.title;
    cell.numberLabel.text = model.number;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *text = @"上报信息";
    if (section != 0) {
        text = @"异常上报";
    }
    return [self createHeadView:text];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReportTaskListController *taskList = [ReportTaskListController new];
    ReportTModel *model = self.dataArray[indexPath.section].reports[indexPath.row];
    taskList.title = model.title;
    taskList.flag = Task_TODO;
    [self.navigationController pushViewController:taskList animated:NO];
}

-(UIView *)createHeadView:(NSString *)text
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    UILabel *label = [UILabel new];
    label.textColor = [UIColor colorWithRed:94/255.0 green:99/255.0 blue:123/255.0 alpha:1.0];
    label.font = [UIFont systemFontOfSize:16 weight:1];
    label.text = text;
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(view).offset(10);
    }];
    return view;
}

#pragma mark - getter
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[ReportTCell class] forCellReuseIdentifier:@"ReportTCell"];
        //设置分割线颜色
        [_tableView setSeparatorColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0]];
        //隐藏多余的分割线
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        [_tableView setTableFooterView:view];
    }
    return _tableView;
}

-(NSArray *)dataArray{
    if (!_dataArray) {
        NSMutableArray *array = [NSMutableArray new];
        for (int i = 0; i < 2; i++) {
            ReportSectionModel *model = [ReportSectionModel new];
            model.title = @"section";
            for (int j = 0; j < 5; j++) {
                ReportTModel *tmodel = [ReportTModel new];
                tmodel.title = @"title";
                tmodel.number = @"number";
                [model.reports addObject:tmodel];
            }
            [array addObject:model];
        }
        _dataArray = [array copy];
    }
    return _dataArray;
}

@end
