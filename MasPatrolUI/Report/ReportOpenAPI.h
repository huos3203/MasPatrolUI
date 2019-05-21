//
//  ReportOpenAPI.h
//  MasPatrolUI
//
//  Created by admin on 2019/5/21.
//  Copyright © 2019 com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
   ReportManager, //上报管理
   TaskManager,   //精确治理
   MyContriInfo,  //我的贡献
} ReportVCType;

NS_ASSUME_NONNULL_BEGIN

@interface ReportOpenAPI : NSObject

+(void)open:(ReportVCType)vcType from:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
