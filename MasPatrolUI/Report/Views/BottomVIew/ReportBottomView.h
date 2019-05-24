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
-(instancetype)initForInvalidNote:(NSString *)note who:(NSString *)pepleName address:(NSString *)address time:(NSString *)time;
@property (strong, nonatomic) NSString *typeId;
@property (assign, nonatomic) StoreTypeFlag flag;
@property (strong, nonatomic) NSMutableArray<ReportCameraModel *> *cameraArray;
@property (strong, nonatomic) NSString *pepleName;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSString *note;
@end
@interface ReportBottomView : UIView
-(instancetype)initWith:(NSMutableArray *)typeArray
                    and:(NSMutableArray *)bodyArray
   ScrollContentHandler:(void(^)(BOOL height))handler;
-(void)show:(TaskFlagType)type;
@end

NS_ASSUME_NONNULL_END
