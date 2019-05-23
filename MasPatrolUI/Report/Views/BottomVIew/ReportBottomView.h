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

@interface ReportBottomView : UIView
-(void)show:(TaskFlagType)type forStoreType:(NSUInteger)num;
@end

NS_ASSUME_NONNULL_END
