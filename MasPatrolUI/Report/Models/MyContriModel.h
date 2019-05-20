//
//  MyContriModel.h
//  MasPatrolUI
//
//  Created by admin on 2019/5/20.
//  Copyright © 2019 com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class ReportTaskModel;
@interface MyContriModel : NSObject
//累计被采纳次数
@property (strong, nonatomic) NSNumber *AdoptNumber;
//上报次数
@property (strong, nonatomic) NSNumber *ReportNumber;
//待办次数
@property (strong, nonatomic) NSNumber *WaitingNumber;
@property (strong, nonatomic) NSMutableArray<ReportTaskModel *> *Questions;
@end

NS_ASSUME_NONNULL_END
