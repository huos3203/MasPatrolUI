//
//  ReportTaskListCell.h
//  MasPatrolUI
//
//  Created by admin on 2019/5/20.
//  Copyright © 2019 com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ReportTaskModel;
@interface ReportTaskListCell : UITableViewCell
@property (strong, nonatomic) UILabel *taskTypeLabel;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *addressLabel;
@property (strong, nonatomic) UILabel *renLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) ReportTaskModel *model;
@end

NS_ASSUME_NONNULL_END
