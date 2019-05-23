//
//  ReportInvalidDetailController.m
//  MasPatrolUI
//
//  Created by admin on 2019/5/23.
//  Copyright © 2019 com. All rights reserved.
//

#import "ReportInvalidDetailController.h"
#import "ReportBottomView.h"
@interface ReportInvalidDetailController ()

@end

@implementation ReportInvalidDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ReportBottomView *bottomView = [ReportBottomView new];
//    bottomView.backgroundColor = [UIColor redColor];
    [bottomView show:Task_Invalid forStoreType:0];
    [self.scrollView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view.frame.size.width);
        make.top.equalTo(self.line.mas_bottom).offset(8);
    }];
}


@end
