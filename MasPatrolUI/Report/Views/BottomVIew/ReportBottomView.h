//
//  ReportBottomView.h
//  MasPatrolUI
//
//  Created by admin on 2019/5/23.
//  Copyright © 2019 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyViewUtils.h"
NS_ASSUME_NONNULL_BEGIN

@class StoreTypeModel;
@class ReportCameraModel;
@interface STypeBodyModel : NSObject
@property (strong, nonatomic) NSString *typeId;
@property (strong, nonatomic) NSMutableArray<ReportCameraModel *> *cameraArray;
@property (strong, nonatomic) NSString *pepleName;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSString *note;
@end
@interface ReportBottomView : UIView
-(instancetype)initWith:(NSMutableArray *)typeArray and:(NSMutableArray *)bodyArray;
-(void)show:(TaskFlagType)type forStoreType:(NSUInteger)num;
@end

NS_ASSUME_NONNULL_END
