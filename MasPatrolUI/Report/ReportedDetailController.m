//
//  ReportedDetailController.m
//  MasPatrolUI
//
//  Created by admin on 2019/5/21.
//  Copyright © 2019 com. All rights reserved.
//

#import "ReportedDetailController.h"
#import <Masonry/Masonry.h>
#import "MyViewUtils.h"
#import "ReportDetailView.h"
@interface ReportedDetailController ()

@end

@implementation ReportedDetailController
{
    ReportDetailView *_detailView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self customBarButton];
    _detailView = [ReportDetailView new];
    [self.view addSubview:_detailView];
    __weak typeof(self) weakSelf = self;
    [_detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@70);
        make.left.right.equalTo(weakSelf.view);
    }];
    [self reloadViewData];
}

#pragma mark - View

-(void)reloadViewData
{
    [self reloadDetailViewData];
}

-(void)reloadDetailViewData
{
    ReportDetailViewModel *model = [ReportDetailViewModel new];
    model.name = @"南北方向施工";
    model.status= @"待认领";
    model.preImgUrl = @"https://upload.jianshu.io/users/upload_avatars/2456771/d9dc05b91093.jpg";
    model.type = @"道路阻塞";
    model.time = @"2019.01.10";
    model.address = @"北京市海淀区上地街道上地东路上地街道上地东路";
    model.detailText = nil;// @"描述文字描述文字描述文字描述文字描述文字描述文字描述文字描述文字描述文字描述文字描述文字描述文字描述文字描述文字描述文字描述文字描述文字描述文字描述文字描述文字描述文字描述文字描述文字描述文字";
    model.detailImgUrl = nil;
    model.ren = @"道路部门道路部门道路部门";
    model.shixian = @"2019.01.01-2019.02.01";
    [_detailView reloadData:model];
}

#pragma mark bar
-(void)customBarButton
{
    self.title = @"上报详情";
    UIButton *btn = [UIButton new];
    btn.backgroundColor = [UIColor redColor];
    UIImage *btnimg = [UIImage imageNamed:@"GBCheckUpResource.bundle/whpoint.tiff"];
    [btn setImage:btnimg forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnBackClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [MyViewUtils createBarBy:btn];
}
#pragma mark body



-(void)btnBackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end