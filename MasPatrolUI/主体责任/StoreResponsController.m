//
//  StoreResponsController.m
//  MasPatrolUI
//
//  Created by admin on 2019/4/30.
//  Copyright © 2019 com. All rights reserved.
//

#import "StoreResponsController.h"
#import <Masonry/Masonry.h>

@implementation MasRespoModel
@end

@implementation MasRespoCell
{
    UIImageView *iconView;
    UILabel *titleLabel;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    [self createView];
    return self;
}

-(void)setModel:(MasRespoModel *)model
{
    _model = model;
    NSString *icon = [NSString stringWithFormat:@"JHPatrolResources.bundle/%@",_model.icon];
    iconView.image = [UIImage imageNamed:icon];
    titleLabel.text = _model.name;
}
-(void)createView
{
    UIView *rootView = [UIView new];
    rootView.layer.cornerRadius = 8;
    rootView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:rootView];
    [rootView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(8);
        make.right.equalTo(self.contentView).offset(-8);
        make.top.equalTo(self.contentView).offset(20);
        make.bottom.equalTo(self.contentView);
    }];
    //icon
    NSString *icon = [NSString stringWithFormat:@"JHPatrolResources.bundle/%@",_model.icon];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    iconView = imgView;
    imgView.backgroundColor = [UIColor redColor];
    [rootView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(rootView);
        make.left.equalTo(rootView).offset(10);
        make.width.height.equalTo(@17);
    }];
    //绿点
    UIImageView *dotimgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"绿点"]];
    dotimgView.backgroundColor = [UIColor greenColor];
    [rootView addSubview:dotimgView];
    [dotimgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(imgView);
        make.right.equalTo(rootView).offset(-10);
        make.width.height.equalTo(@10);
    }];
    //title
    UILabel *title = [UILabel new];
    titleLabel = title;
    title.text = _model.name;
    title.font = [UIFont systemFontOfSize:17];
    title.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [rootView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(imgView);
        make.top.equalTo(rootView).offset(15);
        make.bottom.equalTo(rootView).offset(-15);
        make.left.equalTo(imgView.mas_right).offset(8);
        make.right.equalTo(dotimgView).offset(-8);
    }];
}
@end



@interface StoreResponsController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataArray;
@end

@implementation StoreResponsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    self.title = @"主体责任落实情况";
    [self creatTopBackImageView];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(40);
        make.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark - UI
//导航条


//背景View
-(void)creatTopBackImageView
{
    UIImageView *imgView = [UIImageView new];
    imgView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.view);
        make.height.equalTo(@200);
    }];
}
//tableView
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 45.f;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[MasRespoCell class] forCellReuseIdentifier:@"MasRespoCell"];
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}
#pragma mark - TableView代理方法
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
    MasRespoCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"MasRespoCell"];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - getter
-(NSArray *)dataArray
{
    if (!_dataArray) {
        NSArray *iconArr = @[@"自记录表",
                             @"制度签字",
                             @"索证索票",
                             @"晨检",
                             @"消毒管理",
                             @"添加剂",
                             @"留样管理",
                             @"厨余垃圾"];
        NSArray *nameArr = @[@"自查记录表",
                             @"管理制度签字",
                             @"进货索证索票",
                             @"晨检管理",
                             @"消毒管理",
                             @"添加剂管理",
                             @"留样管理",
                             @"厨余垃圾管理"];
        NSMutableArray *array = [NSMutableArray new];
        for (int i = 0; i< iconArr.count; i++) {
            MasRespoModel *model = [MasRespoModel new];
            model.icon = iconArr[i];
            model.name = nameArr[i];
            [array addObject:model];
        }
        _dataArray = [array copy];
    }
    return _dataArray;
}
@end
