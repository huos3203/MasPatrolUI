//
//  ReportedDetailController.m
//  MasPatrolUI
//
//  Created by admin on 2019/5/21.
//  Copyright © 2019 com. All rights reserved.
//

#import "ReportedDetailController.h"
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
    [self installView];
    [self reloadViewData];
    
}

#pragma mark - View
-(void)installView
{
    __weak typeof(self) weakSelf = self;
    [self.view addSubview:self.scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
        weakSelf.scrollView_mas_Bottom = make.bottom.equalTo(weakSelf.view);
    }];
    _detailView = [ReportDetailView new];
    self.line = _detailView.line;
    [_scrollView addSubview:_detailView];
    [_detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self->_scrollView.contentSize);
        make.center.equalTo(self->_scrollView);
    }];
}


-(void)reloadViewData
{
    [self reloadDetailViewData];
}

-(void)reloadDetailViewData
{
    ReportDetailViewModel *model = [ReportDetailViewModel new];
    model.name = @"南北方向施工南北方向施工";
    model.status= @"待认领";
    model.preImgUrl = @"https://upload.jianshu.io/users/upload_avatars/2456771/d9dc05b91093.jpg";
    model.type = @"道路阻塞";
    model.time = @"2019.01.10";
    model.address = @"北京市海淀区上地街道上地东路上地街道上地东路";
    model.detailText = @"描述文字描述文字描述文字描述文字描述文字描述文字描述文字描述文字描述文字描述文字描述文字描述文字描述文字描述文字描述文字描述文字描述文字描述文字描述文字描述文字描述文字描述文字描述文字描述文字";
    model.detailImgUrl = @"https://upload.jianshu.io/users/upload_avatars/2456771/d9dc05b91093.jpg";
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


-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height - 60);
    }
    return _scrollView;
}

@end
