//
//  PatrolOptionSelController.h
//  MasPatrolUI
//
//  Created by admin on 2019/6/11.
//  Copyright © 2019 com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PatrolOptionSelModel;
@interface PatrolOptionSelCell : UITableViewCell
@property (strong, nonatomic) PatrolOptionSelModel *model;
@end
@class PatrolOptClsModel;
@interface PatrolOptionClsCell : UITableViewCell
@property (strong, nonatomic) PatrolOptClsModel *model;
@end


@interface PatrolOptionSelController : UIViewController
///回传已经选中的检查项的数组
@property (strong, nonatomic) void(^optionHandler)(NSArray *opts);
@end

NS_ASSUME_NONNULL_END
