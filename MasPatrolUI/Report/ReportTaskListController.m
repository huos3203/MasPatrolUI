//
//  ReportTaskListController.m
//  MasPatrolUI
//
//  Created by admin on 2019/5/20.
//  Copyright © 2019 com. All rights reserved.
//

#import "ReportTaskListController.h"
#import <Masonry/Masonry.h>
#pragma mark - cell
@interface ReportTaskListCell:UITableViewCell
@end
@implementation ReportTaskListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self installView];
    return self;
}
-(void)installView
{
    //title
    UILabel *taskType = [UILabel new];
    taskType.backgroundColor = [UIColor colorWithRed:51/255.0 green:146/255.0 blue:254/255.0 alpha:1.0];
    taskType.textColor = [UIColor whiteColor];
    UILabel *name = [UILabel new];
    name.font = [UIFont boldSystemFontOfSize:16.0];
    name.textColor = [UIColor colorWithRed:47/255.0 green:56/255.0 blue:86/255.0 alpha:1.0];
    UILabel *address = [UILabel new];
    address.font = [UIFont systemFontOfSize:14.0];
    address.textColor = [UIColor colorWithRed:94/255.0 green:99/255.0 blue:123/255.0 alpha:1.0];
    UILabel *ren = [UILabel new];
    ren.font = [UIFont systemFontOfSize:14.0];
    ren.textColor = [UIColor colorWithRed:94/255.0 green:99/255.0 blue:123/255.0 alpha:1.0];
    UILabel *time = [UILabel new];
    time.font = [UIFont systemFontOfSize:14.0];
    time.textColor = [UIColor colorWithRed:94/255.0 green:99/255.0 blue:123/255.0 alpha:1.0];
    [self.contentView addSubview:taskType];
    [self.contentView addSubview:name];
    [self.contentView addSubview:address];
    [self.contentView addSubview:ren];
    [self.contentView addSubview:time];
    [taskType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@8);
    }];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(taskType.mas_right).offset(8);
        make.right.equalTo(@10);
    }];
    [address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(taskType.mas_bottom).offset(-8);
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
    }];
    
}

@end





@interface ReportTaskListController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataArray;
@end

@implementation ReportTaskListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    return cell;
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
    }
    return _tableView;
}

-(NSArray *)dataArray{
    if (!_dataArray) {
        NSMutableArray *array = [NSMutableArray new];
        _dataArray = [array copy];
    }
    return _dataArray;
}
@end
