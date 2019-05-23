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

@interface ReportedDoingController ()

@end

@implementation ReportedDoingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height - 60 - 44);
    // Do any additional setup after loading the view.
    ReportBottomView *bottomView = [ReportBottomView new];
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
@end
