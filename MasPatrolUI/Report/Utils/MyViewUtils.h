//
//  MyViewUtils.h
//  MasPatrolUI
//
//  Created by admin on 2019/5/20.
//  Copyright © 2019 com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    Task_TODO,
    Task_Doing,
    Task_Done,
    Task_TimeOut,
    Task_Invalid,
} TaskFlagType;

typedef enum : NSUInteger {
    SType_CanDo,
    SType_CantDo,
    SType_Completed,
} StoreTypeFlag;

@interface MyViewUtils : NSObject
+(NSMutableAttributedString *)installAtrribute:(NSString *)first second:(NSString *)second;
+(void)maskLayer:(UIView *)view;
+(UIBarButtonItem *)createBarBy:(UIButton *)btn;
+(UILabel *)secondCell:(NSString *)name for:(UIView *)view;
+(void)clearNavBarLine:(UINavigationBar *)navbar;
+(void)clear:(UINavigationController *)navVC barType:(BOOL)isClear;
@end

NS_ASSUME_NONNULL_END
