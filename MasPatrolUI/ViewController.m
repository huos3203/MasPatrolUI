//
//  ViewController.m
//  MasPatrolUI
//
//  Created by du on 2019/4/25.
//  Copyright © 2019 com. All rights reserved.
//

#import "ViewController.h"
#import "ReportOpenAPI.h"
#import "DrawEditerController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
//    [ReportOpenAPI open:TaskManager from:self];
    DrawEditerController *editerVC = [DrawEditerController new];
    [self presentViewController:editerVC animated:YES completion:nil];
}

@end
