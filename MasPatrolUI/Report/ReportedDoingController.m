//
//  ReportedDoingController.m
//  MasPatrolUI
//
//  Created by admin on 2019/5/23.
//  Copyright © 2019 com. All rights reserved.
//

#import "ReportedDoingController.h"
#import "ReportBottomView.h"
#import <Masonry/Masonry.h>
#import "StoreTypeColView.h"
#import "ReportBottomView.h"
#import "ReportCameraView.h"
@interface ReportedDoingController ()
@property (strong, nonatomic) NSMutableArray<StoreTypeModel *> *typeArray;
@property (strong, nonatomic) NSMutableArray<STypeBodyModel *> *bodyArray;
@property (strong, nonatomic) ReportBottomView *bottomView;
@property (strong, nonatomic) UIStackView *threeButVIew;
@end

@implementation ReportedDoingController
{
    BOOL _isDetail;
    
    UIButton *_invalidBtn;
    UIButton *_todoBtn;
    UIButton *_commitBtn;
    MASConstraint *_threeButHeight;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //提交按钮
    [self installThreeBtnView];
    [self.bottomView show:Task_Doing];
}

-(void)reloadThreeBtnView
{
    _invalidBtn.hidden = YES;
    _todoBtn.hidden = YES;
    _commitBtn.hidden = YES;
    _threeButHeight.offset(44);
    self.scrollView_mas_Bottom.offset(-44);
    if (self.flag == Task_TODO) {
        _invalidBtn.hidden = NO;
        _todoBtn.hidden = NO;
    }else if (self.flag == Task_Doing) {
        _commitBtn.hidden = NO;
    }else{
        self.scrollView_mas_Bottom.offset(0);
        _threeButHeight.offset(0);
    }

    CGFloat h;
    if (self.flag == Task_TODO) {
        _bottomView.hidden = YES;
        h = originHeight;
    }else{
        _bottomView.hidden = NO;
        CGFloat hh = originHeight + bodyHeight;
        h = _isDetail?hh+doneHeight:hh;
    }
    CGSize size = CGSizeMake(self.scrollView.contentSize.width, h);
    self.scrollView.contentSize = size;
}

//无效上报/领取任务/检查结果上传
-(void)installThreeBtnView
{
    UIStackView *stackView = [UIStackView new];
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.distribution = UIStackViewDistributionFillEqually;
    UIButton *invalidBtn = [UIButton new];
    _invalidBtn = invalidBtn;
    [invalidBtn setTitle:@"无效上报" forState:UIControlStateNormal];
    invalidBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [invalidBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [invalidBtn setBackgroundColor:[UIColor colorWithRed:243/255.0 green:190/255.0 blue:76/255.0 alpha:1.0]];
    [invalidBtn addTarget:self action:@selector(invalidAction) forControlEvents:UIControlEventTouchUpInside];
    UIButton *todoBtn = [UIButton new];
    _todoBtn = todoBtn;
    [todoBtn setTitle:@"领取任务" forState:UIControlStateNormal];
    todoBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [todoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [todoBtn setBackgroundColor:[UIColor colorWithRed:44/255.0 green:215/255.0 blue:115/255.0 alpha:1.0]];
    [todoBtn addTarget:self action:@selector(todoAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *commitBtn = [UIButton new];
    _commitBtn = commitBtn;
    [commitBtn setTitle:@"检查结果上传" forState:UIControlStateNormal];
    commitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitBtn setBackgroundColor:[UIColor colorWithRed:44/255.0 green:215/255.0 blue:115/255.0 alpha:1.0]];
    [commitBtn addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
    
    [stackView addArrangedSubview:invalidBtn];
    [stackView addArrangedSubview:todoBtn];
    [stackView addArrangedSubview:commitBtn];
    
    [self.view addSubview:stackView];
    __weak typeof(self) weakSelf = self;
    [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf.view);
        self->_threeButHeight = make.height.equalTo(@44);
    }];
    [self reloadThreeBtnView];
}


#pragma mark - UIAction
-(void)invalidAction
{
    
}

-(void)todoAction
{
    
}
-(void)commitAction
{
    
}

#pragma mark - getter
-(ReportBottomView *)bottomView
{
    if (!_bottomView) {
        __weak typeof(self) weakSelf = self;
        _bottomView = [[ReportBottomView alloc] initWith:self.typeArray
                                                     and:self.bodyArray
                                                isDetail:^(BOOL isDetail) {
                                                    if (weakSelf.flag != Task_TODO){
                                                        weakSelf.flag = isDetail?Task_Done:Task_Doing;
                                                        self->_isDetail = isDetail;
                                                        [weakSelf reloadThreeBtnView];
                                                    }
                                               }
                                  ];
        [self.scrollView addSubview:_bottomView];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.view.frame.size.width);
            make.top.equalTo(self.line.mas_bottom).offset(8);
        }];
    }
    return _bottomView;
}
- (NSMutableArray<StoreTypeModel *> *)typeArray
{
    if (!_typeArray) {
        _typeArray = [NSMutableArray new];
        for (int i = 0; i < 8; i++) {
            StoreTypeModel *model = [StoreTypeModel new];
            model.typeId = [NSString stringWithFormat:@"%d",i];
            model.title = @"业态一";
            if (i == 1) {
                model.flag = SType_CantDo;
            }else if (i == 2) {
                model.flag = SType_CanDo;
            }else if(i == 3 || i == 4 || i == 5){
                model.flag = SType_Completed;
            }else{
               model.flag = SType_CanDo;
            }
            [_typeArray addObject:model];
        }
    }
    return _typeArray;
}

-(NSMutableArray<STypeBodyModel *> *)bodyArray
{
    if (!_bodyArray) {
        _bodyArray = [NSMutableArray new];
        for (StoreTypeModel *type in self.typeArray) {
            STypeBodyModel *stmodel = [STypeBodyModel new];
            stmodel.typeId = type.typeId;
            stmodel.pepleName = type.title;
            stmodel.flag = type.flag;
            stmodel.time = @"2019-08-09";
            stmodel.note = @"https://upload.jianshu.io/users/uploahttps://upload.jianshu.io/users/uploa";
            stmodel.address = @"beijingshi xierqi";
            NSString *url = @"";
            if (type.typeId.integerValue%2) {
                url = @"https://upload.jianshu.io/users/upload_avatars/1654560/e28e067af84a.JPG";
            }else{
                url = @"https://upload.jianshu.io/users/upload_avatars/2456771/d9dc05b91093.jpg";
            }
            for (int i = 0; i < 8; i++) {
                ReportCameraModel *model = [ReportCameraModel new];
                model.type = Cell_CanDel;
                model.url = url;
                [stmodel.cameraArray addObject:model];
            }
            [_bodyArray addObject:stmodel];
        }
    }
    return _bodyArray;
}
@end
