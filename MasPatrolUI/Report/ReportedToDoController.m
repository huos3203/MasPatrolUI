//
//  ReportedToDoController.m
//  MasPatrolUI
//
//  Created by admin on 2019/5/23.
//  Copyright © 2019 com. All rights reserved.
//

#import "ReportedToDoController.h"

@interface ReportedToDoController ()

@end

@implementation ReportedToDoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height - 60 - 50);
    [self installBottomView];
}

//无效上报/领取任务
-(void)installBottomView
{
    UIStackView *stackView = [UIStackView new];
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.distribution = UIStackViewDistributionFillEqually;
    UIButton *invalidBtn = [UIButton new];
    [invalidBtn setTitle:@"无效上报" forState:UIControlStateNormal];
    invalidBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [invalidBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [invalidBtn setBackgroundColor:[UIColor colorWithRed:243/255.0 green:190/255.0 blue:76/255.0 alpha:1.0]];
    [invalidBtn addTarget:self action:@selector(invalidAction) forControlEvents:UIControlEventTouchUpInside];
    UIButton *todoBtn = [UIButton new];
    [todoBtn setTitle:@"领取任务" forState:UIControlStateNormal];
    todoBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [todoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [todoBtn setBackgroundColor:[UIColor colorWithRed:44/255.0 green:215/255.0 blue:115/255.0 alpha:1.0]];
    [todoBtn addTarget:self action:@selector(todoAction) forControlEvents:UIControlEventTouchUpInside];
    [stackView addArrangedSubview:invalidBtn];
    [stackView addArrangedSubview:todoBtn];
    [self.view addSubview:stackView];
    __weak typeof(self) weakSelf = self;
    [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf.view);
        make.height.equalTo(@44);
    }];
    [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@44);
    }];
}

#pragma mark - UIAction
-(void)invalidAction
{
    
}

-(void)todoAction
{
    
}


@end
