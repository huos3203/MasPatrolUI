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
@property (strong, nonatomic) NSMutableArray<STypeBodyModel *> *bodyArray;
@end

@implementation ReportInvalidDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ReportBottomView *bottomView = [[ReportBottomView alloc] initWith:@[]
                                                                  and:self.bodyArray
                                                             isDetail:nil
                                    ];
    [bottomView show:Task_Invalid];
    [self.scrollView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view.frame.size.width);
        make.top.equalTo(self.line.mas_bottom).offset(8);
    }];
}
-(NSMutableArray<STypeBodyModel *> *)bodyArray
{
    if (!_bodyArray) {
        _bodyArray = [NSMutableArray new];
        NSString *note = @"timetimetimetimetimetimetimetime";
        NSString *who = @"whohow";
        NSString *address = @"addressaddress";
        NSString *time = @"timetime";
        STypeBodyModel *body = [[STypeBodyModel alloc] initForInvalidNote:note who:who address:address time:time];
        [_bodyArray addObject:body];
    }
    return _bodyArray ;
}

@end
