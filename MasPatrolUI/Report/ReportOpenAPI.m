//
//  ReportOpenAPI.m
//  MasPatrolUI
//
//  Created by admin on 2019/5/21.
//  Copyright © 2019 com. All rights reserved.
//

#import "ReportOpenAPI.h"
#import <UIKit/UIKit.h>

#import "ReportManagerController.h"
#import "TaskManagerController.h"
#import "MyContributionController.h"

@implementation ReportOpenAPI


+(void)open:(ReportVCType)vcType from:(nonnull UIViewController *)vc
{
    UIViewController *tovc;
    switch (vcType) {
        case ReportManager:
        {
            tovc = [ReportManagerController new];
            break;
        }
        case MyContriInfo:
        {
            tovc = [MyContributionController new];
            break;
        }
        case TaskManager:
        {
            tovc = [TaskManagerController new];
            break;
        }
        default:
            break;
    }
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tovc];
    if (vc) {
        [vc presentViewController:nav animated:NO completion:nil];
    }else{
        
        UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
        while (topController.presentedViewController) {
            topController = topController.presentedViewController;
        }
        [topController presentViewController:nav animated:NO completion:nil];
    }
}
@end
