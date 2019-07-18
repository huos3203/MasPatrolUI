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
{
    UIImageView *_selIcon;
    UILabel *_label;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    _selIcon = [UIImageView new];
    _selIcon.image = [UIImage imageNamed:@"deseleced"];
    [self addSubview:_selIcon];
    [_selIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@20);
        make.centerY.equalTo(@0);
        make.right.equalTo(@-10);
    }];
    _label = [UILabel new];
    _label.numberOfLines = 0;
    [self addSubview:_label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.bottom.equalTo(@-10);
        make.left.equalTo(@15);
        make.right.equalTo(self->_selIcon.mas_left).offset(-10);
    }];
    
    return self;
}
-(void)setModel:(PatrolOptionSelModel *)model
{
    _model = model;
    _label.text = model.Name;
    if (_model.isSelected) {
        _label.font = [UIFont systemFontOfSize:14];
        _label.textColor = [UIColor colorWithRed:66/255.0 green:139/255.0 blue:254/255.0 alpha:1.0];
        _selIcon.image = [UIImage imageNamed:@"optSelected"];
    }else{
        _selIcon.image = [UIImage imageNamed:@"deseleced"];
        _label.font = [UIFont systemFontOfSize:14];
        _label.textColor =  [UIColor colorWithRed:94/255.0 green:99/255.0 blue:123/255.0 alpha:1.0];
    }
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

//回传选中的检查项数组
@property (strong, nonatomic) NSMutableArray *optsArr;

@end

@implementation PatrolOptionSelController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIButton *confirmBtn = [UIButton new];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmBtn setBackgroundColor:[UIColor colorWithRed:44/255.0 green:215/255.0 blue:115/255.0 alpha:1.0]];
    [confirmBtn addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
    UIEdgeInsets theInsets;
    if (@available(iOS 11.0, *)) {
        theInsets = [UIApplication sharedApplication].keyWindow.rootViewController.view.safeAreaInsets;
    }
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-theInsets.bottom));
        make.left.right.equalTo(@0);
        make.height.equalTo(@44);
    }];
    
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];
    __weak typeof(self) weakSelf = self;
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@100);
        make.left.top.equalTo(@0);
        make.bottom.equalTo(confirmBtn.mas_top);
    }];
    [self.rightTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.leftTableView.mas_right).offset(0);
        make.right.top.equalTo(@0);
        make.bottom.equalTo(confirmBtn.mas_top);
    }];
}

-(void)confirmAction:(UIButton *)confirm
{
    //TODO:回调电子巡查事件
    __weak typeof(self) weakSelf = self;
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.optionHandler) {
            self.optionHandler(weakSelf.optsArr);
        }
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
        PatrolOptionSelModel *model = self.curModel.opts[indexPath.row];
        if (model.isSelected) {
            [self.optsArr removeObject:model];
        }else{
            [self.optsArr addObject:model];
        }
        model.isSelected = !model.isSelected;
        [self.rightTableView reloadData];
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
                selM.Name = [NSString stringWithFormat:@"分类分类分类分类分类分类分类分类分类分类分类分类分类分类分类分类分类分类分类分类分类分类分类分类分类分类分类分类分类分类分类分类分类分类%d>检查项:%d",i,j];
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

-(NSMutableArray *)optsArr
{
    if (!_optsArr) {
        _optsArr = [NSMutableArray new];
    }
    return _optsArr;
}

@end
