//
//  TaskManagerController.m
//  MasPatrolUI
//
//  Created by admin on 2019/5/21.
//  Copyright © 2019 com. All rights reserved.
//

#import "TaskManagerController.h"

@implementation TaskManagerController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    //更新约束
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(60);
        make.leading.trailing.equalTo(self.view);
    }];
    //按钮
    UIButton *task = [UIButton new];
    [task setTitle:@"任务管理" forState:UIControlStateNormal];
    [task setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [task addTarget:self action:@selector(toReportManager) forControlEvents:UIControlEventAllTouchEvents];
    [task setBackgroundColor: [UIColor colorWithRed:44/255.0 green:215/255.0 blue:115/255.0 alpha:1.0]];
    [self.view addSubview:task];
    [task mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView.mas_bottom);
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    [self customBarButton];
}
-(void)customBarButton
{
    [super customBarButton];
    self.title = @"精确治理";
    UIButton *contribtn = [UIButton new];
    contribtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [contribtn setTitle:@"我的贡献" forState:UIControlStateNormal];
    [contribtn setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:UIControlStateNormal];
    [contribtn addTarget:self action:@selector(contriInfo) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [MyViewUtils createBarBy:contribtn];
}

#pragma mark - UIAction
-(void)contriInfo
{
    [ReportOpenAPI open:MyContriInfo from:self];
}
-(void)toReportManager
{
    [ReportOpenAPI open:ReportManager from:self.navigationController];
}
@end
