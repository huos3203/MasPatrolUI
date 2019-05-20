//
//  ReportTaskListController.m
//  MasPatrolUI
//
//  Created by admin on 2019/5/20.
//  Copyright © 2019 com. All rights reserved.
//

#import "ReportTaskListController.h"
#import <Masonry/Masonry.h>
#import "ReportTaskModel.h"
#pragma mark - cell
@interface ReportTaskListCell:UITableViewCell
@property (strong, nonatomic) ReportTaskModel *model;
@end
@implementation ReportTaskListCell
{
    UILabel *taskTypeLabel;
    UILabel *nameLabel;
    UILabel *addressLabel;
    UILabel *renLabel;
    UILabel *timeLabel;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self installView];
    return self;
}
-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self maskLayer:taskTypeLabel];
}
-(void)installView
{
    //title
    UILabel *taskType = [UILabel new];
    taskTypeLabel = taskType;
    taskType.backgroundColor = [UIColor colorWithRed:51/255.0 green:146/255.0 blue:254/255.0 alpha:1.0];
    taskType.textColor = [UIColor whiteColor];
    taskType.font = [UIFont systemFontOfSize:11.0];
    taskType.textAlignment = NSTextAlignmentCenter;
    UILabel *name = [UILabel new];
    nameLabel = name;
    name.font = [UIFont boldSystemFontOfSize:16.0];
    name.textColor = [UIColor colorWithRed:47/255.0 green:56/255.0 blue:86/255.0 alpha:1.0];
    UILabel *address = [UILabel new];
    addressLabel = address;
    address.font = [UIFont systemFontOfSize:14.0];
    address.textColor = [UIColor colorWithRed:94/255.0 green:99/255.0 blue:123/255.0 alpha:1.0];
    UILabel *ren = [UILabel new];
    renLabel = ren;
    ren.font = [UIFont systemFontOfSize:14.0];
    ren.textColor = [UIColor colorWithRed:94/255.0 green:99/255.0 blue:123/255.0 alpha:1.0];
    UILabel *time = [UILabel new];
    timeLabel = time;
    time.font = [UIFont systemFontOfSize:14.0];
    time.textColor = [UIColor colorWithRed:94/255.0 green:99/255.0 blue:123/255.0 alpha:1.0];
    [self.contentView addSubview:taskType];
    [self.contentView addSubview:name];
    [self.contentView addSubview:address];
    [self.contentView addSubview:ren];
    [self.contentView addSubview:time];
    [taskType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.height.equalTo(@18);
        make.top.equalTo(@8);
        make.width.equalTo(@60);
    }];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(taskType.mas_right).offset(8);
        make.centerY.equalTo(taskType);
        make.right.equalTo(@10);
    }];
    [address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(taskType.mas_bottom).offset(8);
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
        make.bottom.equalTo(@-8);
    }];
    
}

-(void)setModel:(ReportTaskModel *)model
{
    taskTypeLabel.text = model.ClassifName;
    nameLabel.text = model.EventName;
    addressLabel.attributedText = [self installAtrribute:@"地址：" second:model.QuestionFixedLocation];
    renLabel.attributedText = [self installAtrribute:@"负责人：" second:model.QuestionReporterName];
    timeLabel.attributedText = [self installAtrribute:@"截止时间：" second:model.QuestionOffDate];
}

-(NSMutableAttributedString *)installAtrribute:(NSString *)first second:(NSString *)second
{
    NSString *text = [NSString stringWithFormat:@"%@%@",first,second];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Medium" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:94/255.0 green:99/255.0 blue:123/255.0 alpha:1.0]}];
    
    [string addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:47/255.0 green:56/255.0 blue:86/255.0 alpha:1.0]} range:NSMakeRange(first.length, second.length)];
    return string;
}

//设置圆角
-(void)maskLayer:(UIView *)view
{
    //设置所需的圆角位置以及大小
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}
@end





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
        make.center.equalTo(self.view);
        make.size.equalTo(self.view);
    }];
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
