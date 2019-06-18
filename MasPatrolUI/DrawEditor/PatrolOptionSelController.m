//
//  PatrolOptionSelController.m
//  MasPatrolUI
//
//  Created by admin on 2019/6/11.
//  Copyright © 2019 com. All rights reserved.
//

#import "PatrolOptionSelController.h"
#import <Masonry/Masonry.h>
#import "PatrolOptionSelModel.h"


@implementation PatrolOptionSelCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    self.textLabel.numberOfLines = 0;
    return self;
}
-(void)setModel:(PatrolOptionSelModel *)model
{
    _model = model;
    self.textLabel.text = model.Name;
}

@end

@implementation PatrolOptionClsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    //设置cell选中色
    UIView *selection = [[UIView alloc] init];
    selection.backgroundColor = [UIColor whiteColor];
    self.selectedBackgroundView = selection;
    self.backgroundColor = [UIColor clearColor];
    self.textLabel.numberOfLines = 0;
    return self;
}

-(void)setModel:(PatrolOptClsModel *)model
{
    _model = model;
    self.textLabel.text = model.Name;
}
-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        self.textLabel.font = [UIFont boldSystemFontOfSize:12];
        self.textLabel.textColor =  [UIColor colorWithRed:47/255.0 green:56/255.0 blue:86/255.0 alpha:1.0];
    }else{
        self.textLabel.font = [UIFont systemFontOfSize:12];
        self.textLabel.textColor = [UIColor colorWithRed:94/255.0 green:99/255.0 blue:123/255.0 alpha:1.0];
    }
}

@end


@interface PatrolOptionSelController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *leftTableView;
@property (strong, nonatomic) UITableView *rightTableView;

@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) PatrolOptClsModel *curModel;

@end

@implementation PatrolOptionSelController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];
    __weak typeof(self) weakSelf = self;
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@100);
        make.left.top.bottom.equalTo(@0);
    }];
    [self.rightTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.leftTableView.mas_right).offset(0);
        make.right.top.bottom.equalTo(@0);
    }];
}


#pragma mark - tableView 代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 100) return self.dataArray.count;
    if (tableView.tag == 101) return self.curModel.opts.count;
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = tableView.tag == 100?@"leftT":@"rightT";
    UITableViewCell *cell;
    if (tableView.tag == 100){
        PatrolOptionClsCell *clsCell = [tableView dequeueReusableCellWithIdentifier:cellID];
        PatrolOptClsModel *clsm = self.dataArray[indexPath.row];
        clsCell.model = clsm;
        cell = clsCell;
    }
    if (tableView.tag == 101){
        PatrolOptionSelCell *selCell = [tableView dequeueReusableCellWithIdentifier:cellID];
        PatrolOptionSelModel *selm = self.curModel.opts[indexPath.row];
        selCell.model = selm;
        cell = selCell;
    }
    return cell;
}
//
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 100) {
        PatrolOptionClsCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.selected = YES;
        self.curModel = self.dataArray[indexPath.row];
        [self.rightTableView reloadData];
    }

    if (tableView.tag == 101) {
        //TODO:回调电子巡查事件
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 100) {
        PatrolOptionClsCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.selected = NO;
    }
}

#pragma mark - getter
-(UITableView *)leftTableView
{
    if (!_leftTableView) {
        _leftTableView = [UITableView new];
        _leftTableView.tag = 100;
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        [_leftTableView registerClass:[PatrolOptionClsCell class] forCellReuseIdentifier:@"leftT"];
        _leftTableView.tableFooterView = [UIView new];
        _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _leftTableView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    }
    return _leftTableView;
}

-(UITableView *)rightTableView
{
    if (!_rightTableView) {
        _rightTableView = [UITableView new];
        _rightTableView.tag = 101;
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        [_rightTableView registerClass:[PatrolOptionSelCell class] forCellReuseIdentifier:@"rightT"];
        _rightTableView.tableFooterView = [UIView new];
        _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _rightTableView.backgroundColor = [UIColor whiteColor];
    }
    return _rightTableView;
}

-(NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSArray new];
        
        //test
        NSMutableArray *arr = [NSMutableArray new];
        for (int i = 0; i < 10; i++) {
            PatrolOptClsModel *clsm = [PatrolOptClsModel new];
            clsm.Id = [NSString stringWithFormat:@"%d",i];
            clsm.Name = [NSString stringWithFormat:@"左 %d",i];
            for (int j = 0; j < 10; j++) {
                PatrolOptionSelModel *selM = [PatrolOptionSelModel new];
                selM.Id = [NSString stringWithFormat:@"%d",j];
                selM.Name = [NSString stringWithFormat:@"分类%d>检查项:%d",i,j];
                [clsm.opts addObject:selM];
            }
            [arr addObject:clsm];
        }
        _dataArray = [arr copy];
    }
    return _dataArray;
}
-(PatrolOptClsModel *)curModel
{
    if (self.dataArray.count == 0) return nil;
    if (!_curModel) {
        _curModel = self.dataArray[0];
    }
    return _curModel;
}

@end
