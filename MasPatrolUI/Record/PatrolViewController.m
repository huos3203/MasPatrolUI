//
//  PatrolViewController.m
//  BDDExamplesSwift
//
//  Created by du on 2019/4/24.
//  Copyright © 2019 huoshuguang. All rights reserved.
//

#import "PatrolViewController.h"
#import "MasRecordHeaderView.h"
#import "MasCalendarView.h"
#import <Masonry/Masonry.h>

@interface PatrolViewController ()

@end

@implementation PatrolViewController
{
    MasRecordHeaderView *headerView;
    MasCalendarView *calendarView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    calendarView = [[MasCalendarView alloc] initWithBlock:^(NSString * year) {
        [self filterRecordBy:year];
    }];
    

    headerView = [[MasRecordHeaderView alloc] initWith:@"阿庆嫂包子铺" Block:^{
        //显示日历
        [calendarView showCalendar];
    }];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(self.view);
        make.size.equalTo(self.view);
    }];
    [headerView reloadYear:@"2019" num:@"99"];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark filterAction
-(void)filterRecordBy:(NSString *)year
{
    NSLog(@"过滤 %@ 的数据",year);
}

@end
