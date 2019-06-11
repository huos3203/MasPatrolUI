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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    NSString *title = @"";
    if (tableView.tag == 100){
        PatrolOptClsModel *clsm = self.dataArray[indexPath.row];
        title = clsm.Name;
    }
    if (tableView.tag == 101){
        PatrolOptionSelModel *selm = self.curModel.opts[indexPath.row];
        title = selm.Name;
    }
    cell.textLabel.text = title;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.curModel = self.dataArray[indexPath.row];
    [self.rightTableView reloadData];
}

#pragma mark - getter
-(UITableView *)leftTableView
{
    if (!_leftTableView) {
        _leftTableView = [UITableView new];
        _leftTableView.tag = 100;
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        [_leftTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"leftT"];
        _leftTableView.tableFooterView = [UIView new];
        
        _leftTableView.backgroundColor = [UIColor yellowColor];
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
        [_rightTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"rightT"];
        _rightTableView.tableFooterView = [UIView new];
        
        _rightTableView.backgroundColor = [UIColor orangeColor];
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
