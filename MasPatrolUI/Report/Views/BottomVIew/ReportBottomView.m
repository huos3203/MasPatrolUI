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

@implementation ReportBottomView
{
    StoreTypeColView *_storeTypeView;
    ReportCameraView *_cameraView;
    UILabel *_renLabel;
    UILabel *_addrLabel;
    UILabel *_timeLabel;
    UIView *_doneView;
}

-(instancetype)init
{
    self = [super init];
    [self installView];
    return self;
}

-(void)show:(TaskFlagType)type forStoreType:(NSUInteger)num;
{
    if (num == 0) _storeTypeView.hidden = YES;
    switch (type) {
        case Task_Invalid:
        {
            _storeTypeView.hidden = YES;
            _cameraView.hidden = YES;
            break;
        }
        case Task_Doing:
        {
            _doneView.hidden = YES;
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
    //tag
    StoreTypeColView *tagView = [[StoreTypeColView alloc] initWith:^(NSString * typeId) {
        NSLog(@"返回值:%@",typeId);
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
    UIView *noteView = [UIView new];
//    noteView.backgroundColor= [UIColor grayColor];
    [noteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@100);
    }];
    [root addArrangedSubview:noteView];
    
    //处理人
    UIView *infoView = [self infoView];
    _doneView = infoView;
    [root addArrangedSubview:infoView];
    [self addSubview:root];
    [root mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    [self reloadData];
}

-(void)reloadData
{
    NSMutableArray *array = [NSMutableArray new];
    for (int i = 0; i < 8; i++) {
        StoreTypeModel *model = [StoreTypeModel new];
        model.typeId = [NSString stringWithFormat:@"%d",i];
        model.title = @"业态一";
        model.flag = SType_Completed;
        [array addObject:model];
    }
    _storeTypeView.dataArray = [array copy];
    [_storeTypeView reloadData];
    
    NSMutableArray *cameraArr = [NSMutableArray new];
    for (int i = 0; i < 8; i++) {
        ReportCameraModel *model = [ReportCameraModel new];
        model.type = Cell_CanDel;
        model.url = @"https://upload.jianshu.io/users/upload_avatars/2456771/d9dc05b91093.jpg";
        [cameraArr addObject:model];
    }
    _cameraView.dataArray = [cameraArr copy];
    
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
    _renLabel.text = @"处理人处理人";
    _addrLabel.text = @"定位地址";
    _timeLabel.text = @"处理时间";
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
@end
