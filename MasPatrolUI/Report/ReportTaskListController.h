//
//  ReportTaskListController.h
//  MasPatrolUI
//
//  Created by admin on 2019/5/20.
//  Copyright © 2019 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "MyViewUtils.h"
#import "ReportOpenAPI.h"
#import "ReportTaskModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ReportTaskListController : UIViewController
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray<ReportTaskModel *> *dataArray;
-(void)customBarButton;
@end

NS_ASSUME_NONNULL_END
