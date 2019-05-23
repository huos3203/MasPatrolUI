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
@end

@implementation ReportedDoingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height - 60 - 44);
    // Do any additional setup after loading the view.
    ReportBottomView *bottomView = [[ReportBottomView alloc] initWith:self.typeArray and:self.bodyArray];
    [bottomView show:Task_Doing forStoreType:2];
    [self.scrollView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view.frame.size.width);
        make.top.equalTo(self.line.mas_bottom).offset(8);
    }];
    //提交按钮
    [self installCommitView];
}
//无效上报/领取任务
-(void)installCommitView
{
    UIButton *commitBtn = [UIButton new];
    [commitBtn setTitle:@"检查结果上传" forState:UIControlStateNormal];
    commitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitBtn setBackgroundColor:[UIColor colorWithRed:44/255.0 green:215/255.0 blue:115/255.0 alpha:1.0]];
    [commitBtn addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
    __weak typeof(self) weakSelf = self;
    [self.view addSubview:commitBtn];
    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf.view);
        make.height.equalTo(@44);
    }];
    self.scrollView_mas_Bottom.offset(-44);
}

-(void)commitAction
{
    
}

#pragma mark - getter
- (NSMutableArray<StoreTypeModel *> *)typeArray
{
    if (!_typeArray) {
        _typeArray = [NSMutableArray new];
        for (int i = 0; i < 8; i++) {
            StoreTypeModel *model = [StoreTypeModel new];
            model.typeId = [NSString stringWithFormat:@"%d",i];
            model.title = @"业态一";
            model.flag = SType_Completed;
            [_typeArray addObject:model];
        }
    }
    return _typeArray;
}

-(NSMutableArray<STypeBodyModel *> *)bodyArray
{
    if (!_bodyArray) {
        _bodyArray = [NSMutableArray new];
        for (int i = 0; i < 8; i++) {
            STypeBodyModel *stmodel = [STypeBodyModel new];
            stmodel.typeId = [NSString stringWithFormat:@"%d",i];
            stmodel.pepleName = [NSString stringWithFormat:@"alin%d",i];
            stmodel.time = @"2019-08-09";
            stmodel.note = @"https://upload.jianshu.io/users/uploahttps://upload.jianshu.io/users/uploa";
            stmodel.address = @"beijingshi xierqi";
            NSString *url = @"";
            if (i%2) {
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
