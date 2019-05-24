//
//  ReportBottomView.m
//  MasPatrolUI
//
//  Created by admin on 2019/5/23.
//  Copyright © 2019 com. All rights reserved.
//

#import "ReportBottomView.h"
#import "StoreTypeColView.h"
#import "ReportCameraView.h"
#import "MyViewUtils.h"
#import <Masonry/Masonry.h>

@implementation STypeBodyModel
-(instancetype)initForInvalidNote:(NSString *)note
                              who:(NSString *)pepleName
                          address:(NSString *)address
                             time:(NSString *)time
{
    self = [super init];
    self.note = note;
    self.pepleName = pepleName;
    self.address = address;
    self.time = time;
    return self;
}
-(NSMutableArray<ReportCameraModel *> *)cameraArray
{
    if (!_cameraArray) {
        _cameraArray = [NSMutableArray new];
    }
    return _cameraArray;
}
@end

@implementation ReportBottomView
{
    NSMutableArray<StoreTypeModel *> *_typeArray;
    NSMutableArray<STypeBodyModel *> *_bodyArray;
    
    StoreTypeColView *_storeTypeView;
    ReportCameraView *_cameraView;
    UILabel *_renLabel;
    UILabel *_addrLabel;
    UILabel *_timeLabel;
    UIView *_doneView;
    UIButton *_note;
    UIView *_noteline;
    void(^isDetail)(BOOL);
}

-(instancetype)initWith:(NSMutableArray *)typeArray
                    and:(NSMutableArray *)bodyArray
               isDetail:(void(^)(BOOL isDetail))handler
{
    self = [super init];
    isDetail = handler;
    _typeArray = typeArray;
    _bodyArray = bodyArray;
    [self installView];
    _storeTypeView.dataArray = _typeArray;
    [_storeTypeView reloadData];
    [self reloadData:nil];
    return self;
}

-(void)show:(TaskFlagType)type
{
    if (_typeArray.count == 0) _storeTypeView.hidden = YES;
    switch (type) {
        case Task_Invalid:
        {
            _storeTypeView.hidden = YES;
            _cameraView.hidden = YES;
            [self noteDetail];
            break;
        }
        case Task_Doing:
        {
            _doneView.hidden = YES;
            break;
        }
        case Task_Done:
        {
            [self noteDetail];
            break;
        }
        default:
            break;
    }
}
-(void)showByType:(StoreTypeFlag)type
{
    switch (type) {
        case SType_CanDo:
        {
            _doneView.hidden = YES;
            if (isDetail) isDetail(NO);
            [self noteEdit];
            break;
        }
        case SType_Completed:
        {
            _doneView.hidden = NO;
            [self noteDetail];
            if (isDetail) isDetail(YES);
            break;
        }
        default:
            break;
    }
}

-(void)installView
{
    UIStackView *root = [UIStackView new];
    root.axis = UILayoutConstraintAxisVertical;
    __weak typeof(self) weakSelf = self;
    StoreTypeColView *tagView = [[StoreTypeColView alloc] initWith:^(NSString * typeId) {
        [weakSelf reloadData:typeId];
    }];
    [tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
    }];
    _storeTypeView = tagView;
    [root addArrangedSubview:tagView];
    
    //camera
    ReportCameraView *cameraView = [ReportCameraView new];
    [cameraView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@140);
    }];
    _cameraView = cameraView;
    [root addArrangedSubview:cameraView];
    
    //备注
    UIView *noteView = [self noteView];
    [root addArrangedSubview:noteView];
    
    //处理人
    UIView *infoView = [self infoView];
    _doneView = infoView;
    [root addArrangedSubview:infoView];
    [self addSubview:root];
    [root mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
}

-(void)noteDetail
{
    _note.userInteractionEnabled = NO;
    _note.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    _note.backgroundColor = [UIColor whiteColor];
    [_note setTitleColor:[UIColor colorWithRed:47/255.0 green:56/255.0 blue:86/255.0 alpha:1.0] forState:UIControlStateNormal];
    _noteline.hidden = NO;
}
-(void)noteEdit
{
    _noteline.hidden = YES;
    _note.userInteractionEnabled = YES;
    [_note setTitle:@"多行输入" forState:UIControlStateNormal];
    _note.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    _note.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
    [_note setTitleColor:[UIColor colorWithRed:94/255.0 green:99/255.0 blue:123/255.0 alpha:1.0] forState:UIControlStateNormal];
    
}
-(UIView *)noteView
{
    UIView *view = [UIView new];
    UILabel *title = [UILabel new];
    title.textColor = [UIColor colorWithRed:47/255.0 green:56/255.0 blue:86/255.0 alpha:1.0];
    title.font = [UIFont boldSystemFontOfSize:16.0];
    title.text = @"检查结果描述";
    [view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@8);
    }];
    UIButton *note = [UIButton new];
    _note = note;
    note.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    note.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    note.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    note.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
    [note setTitle:@"多行输入" forState:UIControlStateNormal];
    note.titleLabel.font = [UIFont systemFontOfSize:14.0];
    note.titleLabel.numberOfLines = 0;
    [note setTitleColor:[UIColor colorWithRed:94/255.0 green:99/255.0 blue:123/255.0 alpha:1.0] forState:UIControlStateNormal];
    [note addTarget:self action:@selector(editNoteAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *line = [UIView new];
    line.hidden = YES;
    _noteline = line;
    line.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    [view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.bottom.left.right.equalTo(@0);
    }];
    
    [view addSubview:note];
    [note mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.top.equalTo(title.mas_bottom).offset(8);
        make.right.equalTo(@-8);
        make.height.equalTo(@80);
        make.bottom.equalTo(line.mas_top).offset(-8);
    }];
    return view;
}

-(UIView *)infoView
{
    UIView *view = [UIView new];
    UIView *cell1 = [UIView new];
    UIView *cell2 = [UIView new];
    UIView *cell3 = [UIView new];
    _renLabel = [MyViewUtils secondCell:@"处理人" for:cell1];
    _addrLabel = [MyViewUtils secondCell:@"定位地址" for:cell2];
    _timeLabel = [MyViewUtils secondCell:@"处理时间" for:cell3];
    UIView *line = [UIView new];
    line.backgroundColor =[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    UIView *line2 = [UIView new];
    line2.backgroundColor =[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    [view addSubview:cell1];
    [view addSubview:cell2];
    [view addSubview:cell3];
    [view addSubview:line];
    [view addSubview:line2];
    [cell1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).offset(10);
        make.left.right.equalTo(view);
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.left.equalTo(view).offset(-8);
        make.right.equalTo(view).offset(8);
        make.top.equalTo(cell1.mas_bottom).offset(8);
    }];
    
    [cell2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(view);
        make.top.equalTo(line.mas_bottom).offset(8);
    }];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.left.equalTo(view).offset(-8);
        make.right.equalTo(view).offset(8);
        make.top.equalTo(cell2.mas_bottom).offset(8);
    }];
    [cell3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(view);
        make.top.equalTo(line2.mas_bottom).offset(8);
        make.bottom.equalTo(view).offset(-10);
    }];
    return view;
}

#pragma mark - API
-(void)reloadData:(NSString *)typeId
{
    STypeBodyModel *model;
    if (typeId) {
        NSString *preStr = [NSString stringWithFormat:@"typeId contains [cd] '%@'", typeId];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:preStr];
        NSArray *array = [self->_bodyArray filteredArrayUsingPredicate:predicate];
        if (array.count == 0) return;
        model = array[0];
    }else{
        if (_bodyArray.count > 0) {
            model = _bodyArray[0];
        }
    }
    if (!model) {
        return;
    }
    [self showByType:model.flag];
    _cameraView.dataArray = model.cameraArray;
    [_cameraView reloadData];
    
    _renLabel.text = model.pepleName;
    _addrLabel.text = model.address;
    _timeLabel.text = model.time;
    
    [_note setTitle:model.note forState:UIControlStateNormal];
    
    
}
#pragma mark - UIAction
-(void)editNoteAction
{
    
}
@end
